import json
import os
import pandas as pd
import faiss
import numpy as np
from dotenv import load_dotenv
from sentence_transformers import SentenceTransformer
from langchain.schema import Document


load_dotenv()

embedding_model = SentenceTransformer(
    "sentence-transformers/all-mpnet-base-v2")


def load_and_index_courses():
    df = pd.read_csv("coursera_courses.csv")

    df['course_description'] = df['course_description'].fillna(
        "No description available")
    df['course_description'] = df['course_description'].astype(str)

    documents = [
        Document(
            page_content=row['course_description'],
            metadata={
                "title": row["course_title"],
                "rating": row["course_rating"],
                "reviews": row["course_reviews_num"],
                "difficulty": row["course_difficulty"],
                "url": row["course_url"]
            }
        )
        for _, row in df.iterrows()
    ]

    course_descriptions = [doc.page_content for doc in documents]
    embeddings = embedding_model.encode(
        course_descriptions, convert_to_numpy=True)

    index = faiss.IndexFlatL2(embeddings.shape[1])
    index.add(embeddings)

    faiss.write_index(index, "faiss_index.bin")
    np.save("metadata.npy", [doc.metadata for doc in documents])


if not os.path.exists("faiss_index.bin") or not os.path.exists("metadata.npy"):
    print("FAISS index not found. Creating a new one...")
    load_and_index_courses()

index = faiss.read_index("faiss_index.bin")
metadata = np.load("metadata.npy", allow_pickle=True)


def search_courses(query, top_k=10):
    """Searches for the top_k most relevant courses based on a query."""
    query_embedding = embedding_model.encode([query], convert_to_numpy=True)
    distances, indices = index.search(query_embedding, top_k)

    results = []
    for idx, dist in zip(indices[0], distances[0]):
        course = metadata[idx]
        results.append(
            {
                "title": course.get("title", "Unknown"),
                "rating": course.get("rating", "N/A"),
                "reviews": course.get("reviews", 0),
                "difficulty": course.get("difficulty", "Unknown"),
                "url": course.get("url", "#"),
                "distance": dist 
            }
        )

    results = sorted(results, key=lambda x: x["distance"])

    for course in results:
        del course["distance"]

    return results[:3]

def get_recommendations(user_query):
    """Fetches course recommendations based on user input."""
    courses = search_courses(user_query)
    return {"recommendations": courses,"status":"success"}
