// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_mini_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TileDataAdapter extends TypeAdapter<TileData> {
  @override
  final int typeId = 0;

  @override
  TileData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TileData(
      imageUrl: fields[0] as String,
      title: fields[1] as String,
      movieId: fields[2] as String,
      userRating: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TileData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.movieId)
      ..writeByte(3)
      ..write(obj.userRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TileDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
