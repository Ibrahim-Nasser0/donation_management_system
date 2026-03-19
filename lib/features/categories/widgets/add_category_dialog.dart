import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Add New Category",),
            SizedBox(height: 16.h),

            TextField(
              decoration: const InputDecoration(labelText: "Category Name"),
            ),
            SizedBox(height: 12.h),

            TextField(
              decoration: const InputDecoration(labelText: "Description"),
            ),

            SizedBox(height: 24.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Create"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}