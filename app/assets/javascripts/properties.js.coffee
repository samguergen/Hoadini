
class RichMarkerBuilder extends Gmaps.Google.Builders.Marker 
      # override method
      create_infowindow: ->
        return null unless _.isString @args.infowindow

        boxText = document.createElement("div")
        boxText.setAttribute("class", 'yellow') #to customize
        boxText.innerHTML = @args.infowindow
        @infowindow = new InfoBox(@infobox(boxText))

        # add @bind_infowindow() for < 2.1

      infobox: (boxText)->
        content: boxText
        pixelOffset: new google.maps.Size(-140, 0)
        boxStyle:
          width: "280px"

  @buildMap = (markers)->
  handler = Gmaps.build 'Google', { builders: { Marker: RichMarkerBuilder} } #dependency injection

  #then standard use
  handler.buildMap { provider: {}, internal: {id: 'map'} }, ->
    markers = handler.addMarkers(markers)
    handler.bounds.extendWith(markers)
    handler.fitMapToBounds()