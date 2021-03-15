// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContentModelAdapter extends TypeAdapter<ContentModel> {
  @override
  final int typeId = 1;

  @override
  ContentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContentModel(
      id: fields[0] as int,
      title: fields[1] as String,
      author: fields[2] as String,
      createdAt: fields[3] as DateTime,
      price: fields[4] as int,
      postType: fields[5] as String,
      dataUrl: fields[6] as String,
      coverImage: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContentModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.postType)
      ..writeByte(6)
      ..write(obj.dataUrl)
      ..writeByte(7)
      ..write(obj.coverImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
