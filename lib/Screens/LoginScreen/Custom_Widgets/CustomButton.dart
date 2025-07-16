import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color color;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double buttonWidth = ScreenUtil().screenWidth * 0.9;

    return Center(
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 12.0.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            elevation: 4,
            textStyle: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              fontFamily: 'NotoSansUI',
            ),
          ),
          child: isLoading
              ? const SizedBox(
            height: 24, width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2, color: Colors.white,
            ),
          )
              : Text(text),
        ),
      ),
    );
  }
}
