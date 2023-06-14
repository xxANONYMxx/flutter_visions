// import 'dart:io';
//
// import 'package:cloudinary/cloudinary.dart';
//
// void uploadAndTransformImage(imagePath, filtername) async {
//   // Configure Cloudinary with your account credentials
//   Cloudinary cloudinary = Cloudinary.signedConfig(
//     apiKey: "355217681432134",
//     apiSecret: "LSbfDNUv-0lG9GpdtGX3rFbIbUU",
//     cloudName: "dzsrsvkla",
//   );
//
//   // Upload the image to Cloudinary
//   CloudinaryResponse uploadResponse = await cloudinary.upload(
//     file: imagePath,
//   );
//
//   // Get the public ID of the uploaded image
//   String imagePublicId = uploadResponse.publicId!;
//
//   // Apply a filter to the uploaded image
//   String transformedImageUrl = cloudinary.url(
//     imagePublicId,
//     transformation: CloudinaryTransformation().effect(filterName),
//   );
//
//   // Print the URL of the transformed image
//   print('Transformed Image URL: $transformedImageUrl');
// }
//
// Future<List<int>> getFileBytes(String path) async {
//   return await File(path).readAsBytes();
// }
//
// Future<void> doSingleUpload({bool signed = true}) async {
//   try {
//     final data = dataImages;
//     List<int>? fileBytes;
//
//     if (fileSource == FileSource.bytes) {
//       fileBytes = await getFileBytes(data.path!);
//     }
//
//     CloudinaryResponse response = signed
//         ? await cloudinary.upload(
//       file: data.path,
//       fileBytes: fileBytes,
//       resourceType: CloudinaryResourceType.image,
//       folder: folder,
//       progressCallback: data.progressCallback,
//     )
//         : await cloudinary.unsignedUpload(
//       file: data.path,
//       fileBytes: fileBytes,
//       resourceType: CloudinaryResourceType.image,
//       folder: folder,
//       progressCallback: data.progressCallback,
//       uploadPreset: uploadPreset,
//     );
//
//     if (response.isSuccessful && response.secureUrl!.isNotEmpty) {
//       setState(() {
//         cloudinaryResponses = response;
//       });
//     } else {
//       setState(() {
//         errorMessage = response.error;
//       });
//     }
//   } catch (e) {
//     setState(() {
//       errorMessage = e.toString();
//     });
//     if (kDebugMode) {
//       print(e);
//     }
//   }