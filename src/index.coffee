import Solaris from 'solaris-js'
import Pikaday from 'pikaday'

class App
  constructor: ->
    if window.cordova then document.addEventListener('deviceready', @onReady, false)
    else document.addEventListener('DOMContentLoaded', @onReady)

    @solaris = new Solaris 'solaris', fastClickElement: document.body

  onReady: =>
    navigator.splashscreen.hide() if navigator.splashscreen

    @info = document.getElementById('info')
    @info.style.display = 'block'
    @info.addEventListener('click', @onInfoWindowClick)
 
    @showInfo = document.getElementById('showInfo')
    @showInfo.style.display = 'inline-block'
    @showInfo.addEventListener('click', @onShowInfoClick)

    @homeButton = document.getElementById('home')
    @homeButton.style.display = 'inline-block'
    @homeButton.addEventListener('click', @onHomeButtonClick)

    @createDatepicker()

  createDatepicker: ->    
    @datepicker = document.getElementById('datepicker')
    @dateInput = document.querySelector('#datepicker input')

    if @isiOS()
      @dateInput.setAttribute('type', 'date')
      @dateInput.valueAsDate = @solaris.model.time
      @dateInput.removeAttribute('readonly')
      @dateInput.addEventListener('change', => @onSelectDate @dateInput.valueAsDate)
    else
      @pikaday = new Pikaday
        field: @dateInput
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

  onHomeButtonClick: =>
    @solaris.reset()

  onSelectDate: (date) =>
    @solaris.setTime(date)

  isiOS: ->
    /iPad|iPhone|iPod/.test(navigator.userAgent) and not window.MSStream

new App
