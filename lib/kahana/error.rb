module Kahana
  module Error

    # Custom error class for rescuing from all errors
    class Error < StandardError; end

    # Status code 400
    class BadRequest < Error; end

    # Status code 401
    class Unauthorized < Error; end

    # Status code 404
    class NotFound < Error; end

    # Status code 405
    class MethodNotAllowed < Error; end

    # Status code 406
    class NotAcceptable < Error; end

    # Status code 409
    class Conflict < Error; end

    # Status code 500
    class InternalServerError < Error; end

    # Status code 501
    class NotImplemented < Error; end

    # Status code 503
    class ServiceUnavailable < Error; end

  end
end

