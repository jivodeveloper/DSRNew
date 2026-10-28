class Env {
  
  const Env._();
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://dsrtest.jivo.in/api/',
  );

}
