class Env{
  
  const Env._();
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'http://138.252.101.118:90');
  
}