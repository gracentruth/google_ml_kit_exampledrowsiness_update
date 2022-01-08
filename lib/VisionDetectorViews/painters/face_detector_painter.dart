import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../face_detector_view.dart';
import 'coordinates_translator.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.faces, this.absoluteImageSize, this.rotation);
  int colorInt = 1;
  final List<Face> faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.limeAccent,
    Colors.orange
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    // final Paint paint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 1.0
    //   ..color = Colors.red;

    // for (final Face face in faces) {
    //   canvas.drawRect(
    //     Rect.fromLTRB(
    //       translateX(face.boundingBox.left, rotation, size, absoluteImageSize),
    //       translateY(face.boundingBox.top, rotation, size, absoluteImageSize),
    //       translateX(face.boundingBox.right, rotation, size, absoluteImageSize),
    //       translateY(
    //           face.boundingBox.bottom, rotation, size, absoluteImageSize),
    //     ),
    //     paint,
    //   );
    //
    //   void paintContour(FaceContourType type) {
    //     final faceContour = face.getContour(type);
    //     if (faceContour?.positionsList != null) {
    //       for (Offset point in faceContour!.positionsList) {
    //         canvas.drawCircle(
    //             Offset(
    //               translateX(point.dx, rotation, size, absoluteImageSize),
    //               translateY(point.dy, rotation, size, absoluteImageSize),
    //             ),
    //             1,
    //             paint);
    //       }
    //     }
    //   }
    //
    //   paintContour(FaceContourType.face);
    //   paintContour(FaceContourType.leftEyebrowTop);
    //   paintContour(FaceContourType.leftEyebrowBottom);
    //   paintContour(FaceContourType.rightEyebrowTop);
    //   paintContour(FaceContourType.rightEyebrowBottom);
    //   paintContour(FaceContourType.leftEye);
    //   paintContour(FaceContourType.rightEye);
    //   paintContour(FaceContourType.upperLipTop);
    //   paintContour(FaceContourType.upperLipBottom);
    //   paintContour(FaceContourType.lowerLipTop);
    //   paintContour(FaceContourType.lowerLipBottom);
    //   paintContour(FaceContourType.noseBridge);
    //   paintContour(FaceContourType.noseBottom);
    //   paintContour(FaceContourType.leftCheek);
    //   paintContour(FaceContourType.rightCheek);
    // }

    try {
      // faces.sort()=>a.;
      Face face = faces[0];

      double averageEyeOpenProb =
          (face.leftEyeOpenProbability!.toDouble() + face.rightEyeOpenProbability!.toDouble()) / 2.0;
      print("hello");
      print("lefteyeprob${face.leftEyeOpenProbability}");
      print("righteyeprob${face.rightEyeOpenProbability}");

      print(averageEyeOpenProb);
      if (averageEyeOpenProb < 0.6) {
        print("Alert");
        drown=true;
        colorInt = 0;
      } else {
        drown=false;
        colorInt = 1;
      }

      canvas.drawRect(
        // face.boundingBox,
          Rect.fromLTRB(
            face.boundingBox.left * scaleX,
            face.boundingBox.top * scaleY,
            face.boundingBox.right * scaleX,
            face.boundingBox.bottom * scaleY,
          ),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4.0
            ..color = colors[colorInt]);
    } catch (e) {
      print("noFaceDetected");
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
