import { elements as e, component, runComponent } from '@funkia/turbine'

import { accumCombine } from '@funkia/hareactive'
import todoInput from './components/todo-input.coffee'
import todoList from './components/todo-list.coffee'

import 'tailwindcss/tailwind.css'

initialList = (id: i, name: "Todo Item #{i}" for i in [1..5])

app = component (o, start) ->
  items = start accumCombine \
    [[o.insertItem, ((name, arr) -> [{ id: (arr.at -1).id + 1, name }, arr...])]
     [o.removeItem, ((id, arr) -> x for x in arr when x.id != id)]
    ],
    initialList
  e.main class: 'm-auto w-96', [ e.h1 class: 'text-5xl text-center', 'Turbine Fun'
                                 todoInput()
                                 .use insertItem: 'insert'
                                 todoList { items }
                                 .use removeItem: 'remove' ]

runComponent('#root', app)