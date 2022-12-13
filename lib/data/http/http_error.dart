enum HttpError {
  badRequest, //malformed syntax - 400
  notFound, //server problem - 404
  serverError, //server down - 500
  invalidData, //received invalid data from api
}
