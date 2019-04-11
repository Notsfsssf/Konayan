
import 'package:json_annotation/json_annotation.dart';
class Post{
  int id;
  String tags;
  int createdAt;
  int updatedAt;
  int creatorId;
  int approverId;
  String author;
  int change;
  String source;
  int score;
  String md5;
  int fileSize;
  String fileExt;
  String fileUrl;
  bool isShownInIndex;
  String previewUrl;
  int previewWidth;
  int previewHeight;
  int actualPreviewWidth;
  int actualPreviewHeight;
  String sampleUrl;
  int sampleWidth;
  int sampleHeight;
  int sampleFileSize;
  String jpegUrl;
  int jpegWidth;
  int jpegHeight;
  int jpegFileSize;
  String rating;
  bool isRatingLocked;
  bool hasChildren;
  int parentId;
  String status;
  bool isPending;
  int width;
  int height;
  bool isHeld;
  String framesPendingString;
  List<String> framesPending;
  String framesString;
  List<String> frames;
  bool isNoteLocked;
  int lastNotedAt;
  int lastCommentedAt;

  Post(
      {this.id,
      this.tags,
      this.createdAt,
      this.updatedAt,
      this.creatorId,
      this.approverId,
      this.author,
      this.change,
      this.source,
      this.score,
      this.md5,
      this.fileSize,
      this.fileExt,
      this.fileUrl,
      this.isShownInIndex,
      this.previewUrl,
      this.previewWidth,
      this.previewHeight,
      this.actualPreviewWidth,
      this.actualPreviewHeight,
      this.sampleUrl,
      this.sampleWidth,
      this.sampleHeight,
      this.sampleFileSize,
      this.jpegUrl,
      this.jpegWidth,
      this.jpegHeight,
      this.jpegFileSize,
      this.rating,
      this.isRatingLocked,
      this.hasChildren,
      this.parentId,
      this.status,
      this.isPending,
      this.width,
      this.height,
      this.isHeld,
      this.framesPendingString,
      this.framesPending,
      this.framesString,
      this.frames,
      this.isNoteLocked,
      this.lastNotedAt,
      this.lastCommentedAt});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tags = json['tags'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    creatorId = json['creator_id'];
    approverId = json['approver_id'];
    author = json['author'];
    change = json['change'];
    source = json['source'];
    score = json['score'];
    md5 = json['md5'];
    fileSize = json['file_size'];
    fileExt = json['file_ext'];
    fileUrl = json['file_url'];
    isShownInIndex = json['is_shown_in_index'];
    previewUrl = json['preview_url'];
    previewWidth = json['preview_width'];
    previewHeight = json['preview_height'];
    actualPreviewWidth = json['actual_preview_width'];
    actualPreviewHeight = json['actual_preview_height'];
    sampleUrl = json['sample_url'];
    sampleWidth = json['sample_width'];
    sampleHeight = json['sample_height'];
    sampleFileSize = json['sample_file_size'];
    jpegUrl = json['jpeg_url'];
    jpegWidth = json['jpeg_width'];
    jpegHeight = json['jpeg_height'];
    jpegFileSize = json['jpeg_file_size'];
    rating = json['rating'];
    isRatingLocked = json['is_rating_locked'];
    hasChildren = json['has_children'];
    parentId = json['parent_id'];
    status = json['status'];
    isPending = json['is_pending'];
    width = json['width'];
    height = json['height'];
    isHeld = json['is_held'];
    framesPendingString = json['frames_pending_string'];
    if (json['frames_pending'] != null) {
      framesPending = new List<String>();
      json['frames_pending'].forEach((v) {
        framesPending.add(v);
      });
    }
    framesString = json['frames_string'];
    if (json['frames'] != null) {
      frames = new List<String>();
      json['frames'].forEach((v) {
        frames.add(v);
      });
    }
    isNoteLocked = json['is_note_locked'];
    lastNotedAt = json['last_noted_at'];
    lastCommentedAt = json['last_commented_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tags'] = this.tags;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['creator_id'] = this.creatorId;
    data['approver_id'] = this.approverId;
    data['author'] = this.author;
    data['change'] = this.change;
    data['source'] = this.source;
    data['score'] = this.score;
    data['md5'] = this.md5;
    data['file_size'] = this.fileSize;
    data['file_ext'] = this.fileExt;
    data['file_url'] = this.fileUrl;
    data['is_shown_in_index'] = this.isShownInIndex;
    data['preview_url'] = this.previewUrl;
    data['preview_width'] = this.previewWidth;
    data['preview_height'] = this.previewHeight;
    data['actual_preview_width'] = this.actualPreviewWidth;
    data['actual_preview_height'] = this.actualPreviewHeight;
    data['sample_url'] = this.sampleUrl;
    data['sample_width'] = this.sampleWidth;
    data['sample_height'] = this.sampleHeight;
    data['sample_file_size'] = this.sampleFileSize;
    data['jpeg_url'] = this.jpegUrl;
    data['jpeg_width'] = this.jpegWidth;
    data['jpeg_height'] = this.jpegHeight;
    data['jpeg_file_size'] = this.jpegFileSize;
    data['rating'] = this.rating;
    data['is_rating_locked'] = this.isRatingLocked;
    data['has_children'] = this.hasChildren;
    data['parent_id'] = this.parentId;
    data['status'] = this.status;
    data['is_pending'] = this.isPending;
    data['width'] = this.width;
    data['height'] = this.height;
    data['is_held'] = this.isHeld;
    data['frames_pending_string'] = this.framesPendingString;
    if (this.framesPending != null) {
      data['frames_pending'] =
          this.framesPending.map((v) => v).toList();
    }
    data['frames_string'] = this.framesString;
    if (this.frames != null) {
      data['frames'] = this.frames.map((v) => v).toList();
    }
    data['is_note_locked'] = this.isNoteLocked;
    data['last_noted_at'] = this.lastNotedAt;
    data['last_commented_at'] = this.lastCommentedAt;
    return data;
  }
}
