import 'dart:convert';

class CloudinaryImage {
  final String assetId;
  final String publicId;
  final String folder;
  final String filename;
  final String format;
  final int version;
  final String resourceType;
  final String type;
  final DateTime createdAt;
  final DateTime uploadedAt;
  final int bytes;
  final int backupBytes;
  final int width;
  final int height;
  final double aspectRatio;
  final int pixels;
  final String url;
  final String secureUrl;
  final String status;
  final String accessMode;
  final dynamic accessControl;
  final String etag;
  final Map<String, dynamic> createdBy;
  final Map<String, dynamic> uploadedBy;

  CloudinaryImage({
    required this.assetId,
    required this.publicId,
    required this.folder,
    required this.filename,
    required this.format,
    required this.version,
    required this.resourceType,
    required this.type,
    required this.createdAt,
    required this.uploadedAt,
    required this.bytes,
    required this.backupBytes,
    required this.width,
    required this.height,
    required this.aspectRatio,
    required this.pixels,
    required this.url,
    required this.secureUrl,
    required this.status,
    required this.accessMode,
    required this.accessControl,
    required this.etag,
    required this.createdBy,
    required this.uploadedBy,
  });

  factory CloudinaryImage.fromJson(Map<String, dynamic> json) {
    return CloudinaryImage(
      assetId: json['asset_id'],
      publicId: json['public_id'],
      folder: json['folder'],
      filename: json['filename'],
      format: json['format'],
      version: json['version'],
      resourceType: json['resource_type'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      uploadedAt: DateTime.parse(json['uploaded_at']),
      bytes: json['bytes'],
      backupBytes: json['backup_bytes'],
      width: json['width'],
      height: json['height'],
      aspectRatio: json['aspect_ratio'],
      pixels: json['pixels'],
      url: json['url'],
      secureUrl: json['secure_url'],
      status: json['status'],
      accessMode: json['access_mode'],
      accessControl: json['access_control'],
      etag: json['etag'],
      createdBy: json['created_by'],
      uploadedBy: json['uploaded_by'],
    );
  }

  static List<CloudinaryImage> parseCloudinaryImages(String response) {
    List<CloudinaryImage> images = [];

    // Parse the JSON response
    Map<String, dynamic> data = json.decode(response);

    // Check if "resources" key exists in the response
    if (data.containsKey('resources')) {
      List<dynamic> resources = data['resources'];

      // Iterate through each resource and create a CloudinaryImage object
      for (var resource in resources) {
        CloudinaryImage image = CloudinaryImage(
          assetId: resource['asset_id'],
          publicId: resource['public_id'],
          folder: resource['folder'],
          filename: resource['filename'],
          format: resource['format'],
          version: resource['version'],
          resourceType: resource['resource_type'],
          type: resource['type'],
          createdAt: DateTime.parse(resource['created_at']),
          uploadedAt: DateTime.parse(resource['uploaded_at']),
          bytes: resource['bytes'],
          backupBytes: resource['backup_bytes'],
          width: resource['width'],
          height: resource['height'],
          aspectRatio: resource['aspect_ratio'],
          pixels: resource['pixels'],
          url: resource['url'],
          secureUrl: resource['secure_url'],
          status: resource['status'],
          accessMode: resource['access_mode'],
          accessControl: resource['access_control'],
          etag: resource['etag'],
          createdBy: resource['created_by'],
          uploadedBy: resource['uploaded_by'],
        );

        images.add(image);
      }
    }

    return images;
  }
}
