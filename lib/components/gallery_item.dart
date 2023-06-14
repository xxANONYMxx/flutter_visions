import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_url_gen/transformation/effect/effect.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GalleryItem extends StatefulWidget {
  final publicId;

  const GalleryItem({
    Key? key,
    required this.publicId,
  }) : super(key: key);

  @override
  _GalleryItemState createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem> {
  String selectedEffect = 'sepia';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20,),
          CldImageWidget(
            publicId: widget.publicId,
            transformation: Transformation()
              ..resize(
                Resize.fill()
                  ..width(100)
                  ..height(100),
              )
              ..effect(getSelectedEffect()),
          ),
          DropdownButton<String>(
            value: selectedEffect,
            onChanged: (String? newValue) {
              setState(() {
                selectedEffect = newValue!;
              });
            },
            items: <String>[
              'sepia',
              'negate',
              'oilPaint',
              'blacknwhite',
            ].map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Effect getSelectedEffect() {
    switch (selectedEffect) {
      case 'sepia':
        return Effect.sepia();
      case 'negate':
        return Effect.negate();
      case 'oilPaint':
        return Effect.oilPaint();
      case 'blacknwhite':
        return Effect.blackwhite();
      default:
        return Effect.sepia();
    }
  }
}
