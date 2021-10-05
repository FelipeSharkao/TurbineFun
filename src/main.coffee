import { accumCombine, sample } from '@funkia/hareactive'
import { elements as e, component, runComponent } from '@funkia/turbine'

import TaskModel from './models/task.coffee'
import todoInput from './components/todo-input.coffee'
import todoList from './components/todo-list.coffee'

import 'tailwindcss/tailwind.css'

app = component (o, start) ->
  items = start accumCombine \
    [
      [
        o.insertItem
        (name, arr) -> [(new TaskModel (arr.at -1).id + 1, name), arr...]
      ]
      [o.removeItem, ((id, arr) -> x for x in arr when x.id != id)]
      [
        o.toggleItem
        (id, arr) ->
          for x in arr
            if x.id == id then new TaskModel id, x.name, not x.done
            else x
      ]
    ]
    , start sample TaskModel.getAll()

  e.main \
    class: 'm-auto w-96'
    , [
      e.h1 class: 'text-5xl text-center', 'Turbine Fun'
      todoInput()
      .use insertItem: 'insert'
      todoList { items }
      .use removeItem: 'remove', toggleItem: 'toggle'
    ]

runComponent('#root', app)