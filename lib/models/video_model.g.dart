// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoModelAdapter extends TypeAdapter<VideoModel> {
  @override
  final int typeId = 3;

  @override
  VideoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoModel(
      id: fields[0] as String,
      title: fields[1] as String,
      author: fields[2] as String,
      createdAt: fields[3] as DateTime,
      price: fields[5] as double,
      postType: fields[6] as String,
      dataUrl: fields[7] as String,
      coverImage: fields[8] as String,
      isBookmarked: fields[10] as bool,
      isPurchased: fields[11] as bool,
      downloadDate: fields[4] as DateTime,
      downloaded: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, VideoModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.downloadDate)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.postType)
      ..writeByte(7)
      ..write(obj.dataUrl)
      ..writeByte(8)
      ..write(obj.coverImage)
      ..writeByte(9)
      ..write(obj.downloaded)
      ..writeByte(10)
      ..write(obj.isBookmarked)
      ..writeByte(11)
      ..write(obj.isPurchased);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
