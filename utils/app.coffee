do (document) ->
  LightTableFilter = ((Arr) ->
    _input = undefined

    _onInputEvent = (e) ->
      _input = e.target
      tables = document.getElementsByClassName(_input.getAttribute('data-table'))
      Arr.forEach.call tables, (table) ->
        Arr.forEach.call table.tBodies, (tbody) ->
          Arr.forEach.call tbody.rows, _filter
          return
        return
      return

    _filter = (row) ->
      text = row.textContent.toLowerCase()
      val = _input.value.toLowerCase()
      row.style.display = if text.indexOf(val) == -1 then 'none' else 'table-row'
      return

    { init: ->
      inputs = document.getElementsByClassName('light-table-filter')
      Arr.forEach.call inputs, (input) ->
        input.oninput = _onInputEvent
        return
      return
    }
  )(Array.prototype)
  document.addEventListener 'readystatechange', ->
    if document.readyState == 'complete'
      LightTableFilter.init()
    return
  return
