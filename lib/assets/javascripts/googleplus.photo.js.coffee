class Photo
  constructor: (@attributes) ->
    @$ = jQuery

  load: (options = {}) ->
    deferred = @$.Deferred()

    width = options.width if options.width?

    if @attributes.width?
      if width?
        width = Math.min(width, @attributes.width)
      else
        width = @attributes.width

    if width?
      width = Math.round(width)
      url = @attributes.url.replace(/w\d+-h\d+(-p)?/, "w#{width}")
    else
      url = @attributes.url

    element = @$('<img/>')

    element
      .on 'load', ->
        element.off('load error')
        deferred.resolve(element)
        return

      .on 'error', (details...) ->
        element.off('load error')
        deferred.reject(details...)
        return

    element.attr(src: url)

    deferred.promise()

window.GooglePlus ||= {}
window.GooglePlus.Photo = Photo
