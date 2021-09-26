import { combine, shiftCurrent } from '@funkia/hareactive'
import { component, elements as e, list } from '@funkia/turbine'

import todoItem from './todo-item.coffee'

todoList = ({ items }) -> component (o) ->
  e.div class: 'w-full',
    list ((item) ->
            todoItem id: item.id, name: item.name
            .use ({ remove }) -> remove: remove.mapTo item.id),
         items,
         (item) -> item.id
    .use (arrB) ->
      remove: arrB.map (arr) -> combine (arr.map ({ remove }) -> remove)...
  .output remove: shiftCurrent o.remove

export default todoList