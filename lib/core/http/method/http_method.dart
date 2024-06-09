enum HttpMethod {
  head('HEAD'),
  get('GET'),
  post('POST'),
  patch('PATCH'),
  put('PUT'),
  delete('DELETE');

  const HttpMethod(this.method);
  final String method;
}
