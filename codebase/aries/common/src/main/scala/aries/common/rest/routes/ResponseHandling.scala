package aries.common.rest.routes

import akka.http.scaladsl.model.StatusCode
import akka.http.scaladsl.server.{ Directives, Route }
import aries.common.json4s.Json4sSupport
import aries.common.rest.marshalling.Json4sHttpSupport
import aries.domain.rest.HttpContract
import aries.domain.service.DomainObject

trait ResponseHandling {
  self: Directives with Json4sSupport with Json4sHttpSupport =>

  def respond(code: StatusCode): Route = {
    complete(code)
  }

  def respond[From <: DomainObject, To <: HttpContract](value: From)(implicit translator: Translator[From, To]): Route = {
    complete(translator.translate(value))
  }

  def respond[From <: DomainObject, To <: HttpContract](code: StatusCode, value: From)(implicit translator: Translator[From, To]): Route = {
    complete((code, translator.translate(value)))
  }

  def respond[From <: DomainObject, To <: HttpContract](values: Seq[From])(implicit translator: Translator[From, To]): Route = {
    complete(values map translator.translate)
  }
}