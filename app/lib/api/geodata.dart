// Openapi Generator last run: : 2024-06-16T13:33:05.388857

import 'package:dio/src/response.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: AdditionalProperties(
    pubName: 'geodata_api_sdk',
    pubAuthor: 'geodata_api_sdk',
  ),
  inputSpec: InputSpec(
      path: '../backend/pkg/geodata/interface/http/api/geodata/openapi.yaml'),
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: '../geodata_api_sdk',
)
class GeodataRepository {
  final GeodataApiSdk api;

  const GeodataRepository({required this.api});

  Future<Response<FeatureCollection>> buildingGet() async {
    return await api.getDefaultApi().buildingGet();
  }

  Future<Response<FeatureCollection>> levelGet(int buildingId) async {
    return await api.getDefaultApi().levelGet(buildingId: buildingId);
  }

  Future<Response<FeatureCollection>> roomGet(int levelId) async {
    return await api.getDefaultApi().roomGet(levelId: levelId);
  }

  Future<Response<FeatureCollection>> doorGet(int levelId) async {
    return await api.getDefaultApi().doorGet(levelId: levelId);
  }
}