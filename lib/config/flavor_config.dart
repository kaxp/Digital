enum Flavor { staging, production }

class FlavorValues {
  const FlavorValues({
    required this.baseUrl,
    required this.authorization,
  });
  final String baseUrl;
  final String authorization;
}

class FlavorConfig {
  factory FlavorConfig({required Flavor flavor, required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(flavor, flavor.toString().split('.').last, values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.values);

  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig? _instance;

  static FlavorConfig? get instance => _instance;

  static bool isProduction() => _instance?.flavor == Flavor.production;

  static bool isStaging() => _instance?.flavor == Flavor.staging;
}
