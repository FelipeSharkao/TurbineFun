import { elements as e, component, runComponent } from '@funkia/turbine'

import { accum } from '@funkia/hareactive'
import todoList from './components/todo-list.coffee'

import 'tailwindcss/tailwind.css'

initialList = (id: i, name: "Todo Item #{i}" for i in [1..5])

app = component (o, start) ->
  items = start accum ((id, arr) -> x for x in arr when x.id != id),
                      initialList,
                      o.removeItem
  e.main [ e.h1 'Turbine Fun'
           todoList { items }
             .use removeItem: 'remove' ]

runComponent('#root', app)