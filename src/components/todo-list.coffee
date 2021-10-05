import { combine, shiftCurrent } from '@funkia/hareactive'
import { component, elements as e, list } from '@funkia/turbine'

import todoItem from './todo-item.coffee'

todoList = ({ items }) -> component (o, start) ->
  items.log 'items'
  e.div class: 'w-full',
    list \
      (item) ->
        (todoItem item).use ({ remove, toggle }) ->
          remove: remove.mapTo item.id
          toggle: toggle.mapTo item.id
      , items
      , (item) -> item.id + item.done
    .use (arrB) ->
      remove: shiftCurrent arrB.map (arr) -> combine (x.remove for x in arr)...
      toggle: shiftCurrent arrB.map (arr) -> combine (x.toggle for x in arr)...
  .output remove: o.remove, toggle: o.toggle

export default todoList