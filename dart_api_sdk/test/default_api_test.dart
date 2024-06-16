import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for DefaultApi
void main() {
  final instance = Openapi().getDefaultApi();

  group(DefaultApi, () {
    // Get Buildings
    //
    // Returns outlines and information for all buildings
    //
    //Future<FeatureCollection> buildingGet() async
    test('test buildingGet', () async {
      // TODO
    });

    // Get Doors
    //
    // Returns outlines and information for all doors
    //
    //Future<FeatureCollection> doorGet(int levelId) async
    test('test doorGet', () async {
      // TODO
    });

    // Get Levels
    //
    // Returns outlines and information for all levels
    //
    //Future<FeatureCollection> levelGet(int buildingId) async
    test('test levelGet', () async {
      // TODO
    });

    // Get Rooms
    //
    // Returns outlines and information for all rooms
    //
    //Future<FeatureCollection> roomGet(int levelId) async
    test('test roomGet', () async {
      // TODO
    });
  });
}
