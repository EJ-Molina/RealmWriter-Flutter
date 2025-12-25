import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';

class PhotoBox extends StatelessWidget {
  final String? image;
  final VoidCallback onTap;
  final double Function(BuildContext, double) getResponsiveHeight;

  const PhotoBox({
    super.key,
    required this.image,
    required this.onTap,
    required this.getResponsiveHeight,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: const RectDottedBorderOptions(
        dashPattern: [5, 9],
        strokeWidth: 1,
        color: Color(0xFFC8AA6E),
      ),
      child: SizedBox(
        height: 285,
        width: 390,
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.camera_alt_sharp,
                    color: Colors.white,
                    size: 53,
                  ),
                  SizedBox(height: getResponsiveHeight(context, 0.1)),
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      color: const Color(0xFFC8AA6E),
                      width: 210,
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          "Add Photo",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getResponsiveHeight(context, 0.025)),
                ],
              )
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: image!.startsWith('assets/')
                        ? Image.asset(
                            image!,
                            width: 390,
                            height: 285,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(image!),
                            width: 390,
                            height: 285,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    bottom: getResponsiveHeight(context, 0.025),
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: onTap,
                        child: Container(
                          color: const Color(0xFFC8AA6E),
                          height: 25,
                          width: 210,
                          alignment: Alignment.center,
                          child: const Text(
                            "Change Photo",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
