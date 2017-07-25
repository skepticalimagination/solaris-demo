import Solaris from 'solaris-js'
import Pikaday from 'pikaday'

class App
  constructor: ->
    if window.cordova then document.addEventListener('deviceready', @onReady, false)
    else document.addEventListener('DOMContentLoaded', @onReady)

    @solaris = new Solaris('solaris')

  onReady: =>
    navigator.splashscreen.hide()

    @info = document.getElementById('info')
    @info.style.display = 'block'
    @info.addEventListener('click', @onInfoWindowClick)
 
    @showInfo = document.getElementById('showInfo')
    @showInfo.style.display = 'block'
    @showInfo.addEventListener('click', @onShowInfoClick)
    
    @datepicker = document.getElementById('datepicker')
    @pikaday = new Pikaday
      field: document.querySelector('#datepicker input')
      theme: 'dark-theme'
      yearRange: [1800, 2050]
      setDefaultDate: yes
      defaultDate: @solaris.model.time
      onSelect: @onSelectDate
    @datepicker.style.display = 'block'

  onInfoWindowClick: (e) =>
    if e.target.id is 'info' or e.target.parentElement?.classList?.contains('close')
      @info.style.display = 'none'

  onShowInfoClick: =>
    @info.style.display = 'block'

  onSelectDate: (date) =>
    @solaris.setTime(date)

new App
