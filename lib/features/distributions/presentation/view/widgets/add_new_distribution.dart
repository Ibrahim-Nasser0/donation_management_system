

import 'package:donation_management_system/core/widgets/widgets.dart';

class AddNewDistribution extends StatefulWidget {
  const AddNewDistribution({super.key});

  @override
  State<AddNewDistribution> createState() => _AddNewDistributionState();
}

class _AddNewDistributionState extends State<AddNewDistribution> {
  //for testing
  final List<String> _allCases = [
    "Case 101 - Ahmad",
    "Case 202 - Sara",
    "Case 303 - Khaled",
    "Case 404 - Mona",
  ];
  final List<String> _allDonations = [
    "Donation #55 - Individual",
    "Donation #12 - Charity Org",
    "Donation #88 - Unknown",
  ];

  String? selectedCase;
  String? selectedDonation;

  @override
  Widget build(BuildContext context) {
    return CustomAddButton(
      text: "Add Case",
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add New Distribution',
                    style: AppTypography.h2.copyWith(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),
              content: SizedBox(
                width:
                    MediaQuery.of(context).size.width *
                    (MediaQuery.of(context).size.width > 600 ? 0.5 : 0.8),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // حقل اختيار الحالة مع بحث
                      _buildSearchableField(
                        label: "Select Case",
                        hint: "Type to search case...",
                        options: _allCases,
                        onSelected: (value) => selectedCase = value,
                      ),
                      Gap(20.h),

                      // حقل مصدر التبرع مع بحث
                      _buildSearchableField(
                        label: "Donation Source",
                        hint: "Type to search source...",
                        options: _allDonations,
                        onSelected: (value) => selectedDonation = value,
                      ),
                      Gap(20.h),

                      // المبالغ
                      Row(
                        children: [
                          Expanded(child: _buildInputField("Amount", "\$0.00")),
                          Gap(20.w),
                          Expanded(
                            child: _buildInputField(
                              "Rest of the amount",
                              "\$0.00",
                            ),
                          ),
                        ],
                      ),
                      Gap(20.h),

                      _buildInputField(
                        "Distribution Notes",
                        "Provide additional details...",
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D7D6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Save Case",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ويدجت البحث والاختيار
  Widget _buildSearchableField({
    required String label,
    required String hint,
    required List<String> options,
    required Function(String) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Gap(8.h),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return options.where((String option) {
              return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
            });
          },
          onSelected: onSelected,
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            return CustomTextField(
              controller:
                  controller, // تأكد أن CustomTextField يدعم الـ controller
              focusNode: focusNode,
              hint: hint,
            );
          },
          // لتنسيق شكل القائمة المنسدلة التي تظهر عند البحث
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.45, // عرض القائمة
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return ListTile(
                        title: Text(option),
                        onTap: () => onSelected(option),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInputField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Gap(8.h),
        CustomTextField(hint: hint, maxLines: maxLines),
      ],
    );
  }
}
