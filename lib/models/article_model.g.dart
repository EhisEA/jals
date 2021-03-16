// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleModelAdapter extends TypeAdapter<ArticleModel> {
  @override
  final int typeId = 2;

  @override
  ArticleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleModel(
      id: fields[0] as String,
      title: fields[1] as String,
      author: fields[2] as String,
      createdAt: fields[3] as DateTime,
      price: fields[4] as double,
      postType: fields[5] as String,
      dataUrl: fields[6] as String,
      coverImage: fields[7] as String,
      isBookmarked: fields[8] as bool,
      content: fields[9] as String,
      downloaded: fields[10] as bool,
      downloadDate: fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleModel obj) {
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
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.postType)
      ..writeByte(6)
      ..write(obj.dataUrl)
      ..writeByte(7)
      ..write(obj.coverImage)
      ..writeByte(8)
      ..write(obj.isBookmarked)
      ..writeByte(9)
      ..write(obj.content)
      ..writeByte(10)
      ..write(obj.downloaded)
      ..writeByte(11)
      ..write(obj.downloadDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
