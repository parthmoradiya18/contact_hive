// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class myclassAdapter extends TypeAdapter<my_class> {
  @override
  final int typeId = 0;

  @override
  my_class read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return my_class(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      // fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, my_class obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.contact)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.pass)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.skill)
      ..writeByte(6)
      ..write(obj.image);
      // ..writeByte(6)
      // ..write(obj.city)
      // ..writeByte(7)
      // ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is myclassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
