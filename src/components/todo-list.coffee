import { accum, combine, shiftCurrent } from '@funkia/hareactive'
import { component, elements as e, list } from '@funkia/turbine'

import todoItem from './todo-item.coffee'

initialList = (id: i, name: "Todo Item #{i}" for i in [1..5])

todoList = -> component (o, start) ->
  listB = start accum ((id, arr) -> x for x in arr when x.id != id),
                      initialList,
                      shiftCurrent o.remove
  e.div class: 'm-auto w-96',
    list ((item) ->
            todoItem id: item.id, name: item.name
            .use ({ remove }) -> remove: remove.mapTo item.id),
         listB,
         (item) -> item.id
    .use (arrB) ->
      remove: arrB.map (arr) -> combine (arr.map ({ remove }) -> remove)...

export default todoList