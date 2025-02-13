import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/colors/app_colors.dart';

class DataDropDown extends StatelessWidget {
  const DataDropDown(
      {super.key,
      required this.suggestions,
      required this.controller,
      
      required this.label,
      this.enabled = true});
  final List<String> suggestions;
  final TextEditingController controller;
  final String label;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
        ),
        const SizedBox(height: 8),
        DropDownSearchField<String>(
          hideKeyboard: enabled,
          isMultiSelectDropdown: false,
          suggestionsBoxDecoration: const SuggestionsBoxDecoration(
            constraints: BoxConstraints(maxHeight: 300),
            color: AppColors.navBarColor,
            elevation: 4,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          textFieldConfiguration: TextFieldConfiguration(
            cursorColor: AppColors.textWhite,
            style: TextStyle(color: AppColors.textWhite),
            enabled: enabled,
            controller: controller,
            
            //controller: VariableControllers.customerNameController,
            //autofocus: true,
            // style: DefaultTextStyle.of(context)
            //     .style
            //     .copyWith(fontStyle: FontStyle.normal),
          ),
          suggestionsCallback: (pattern) {
            return suggestions
                .where((element) =>
                    element.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          itemBuilder: (context, suggestion) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(suggestion,
                  style: GoogleFonts.nunito(
                      color: AppColors.textWhite, fontSize: 16)),
            );
          },
          onSuggestionSelected: (suggestion) {
            controller.text = suggestion;
          },
          displayAllSuggestionWhenTap: true,
        ),
      ],
    );
  }
}
