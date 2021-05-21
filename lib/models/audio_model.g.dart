// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioModelAdapter extends TypeAdapter<AudioModel> {
  @override
  final int typeId = 4;

  @override
  AudioModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioModel(
      id: fields[0] as String,
      title: fields[1] as String,
      author: fields[2] as String,
      createdAt: fields[3] as DateTime,
      price: fields[4] as double,
      postType: fields[5] as String,
      dataUrl: fields[6] as String,
      artUri: fields[7] as String,
      downloaded: fields[8] as bool,
      downloadDate: fields[9] as DateTime,
      isBookmarked: fields[10] as bool,
      isPurchased: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AudioModel obj) {
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
      ..write(obj.artUri)
      ..writeByte(8)
      ..write(obj.downloaded)
      ..writeByte(9)
      ..write(obj.downloadDate)
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
      other is AudioModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
