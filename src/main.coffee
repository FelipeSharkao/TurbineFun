import {
  accumCombine,
  changes,
  performStream,
  sample,
} from '@funkia/hareactive'
import { component, elements as e, fgo, runComponent } from '@funkia/turbine'

import TaskModel from './models/task.coffee'
import todoInput from './components/todo-input.coffee'
import todoList from './components/todo-list.coffee'

import 'tailwindcss/tailwind.css'

app = component (o, start) ->
  storedItems = start sample TaskModel.getAll()
  nextId = 1 + storedItems.reduce \
    (max, item) ->
      if (n = Number item.id).isNaN then max
      else Math.max max, n
    , -1

  items = start accumCombine \
    [
      [o.insertItem, (name, arr) -> [(new TaskModel nextId, name), arr...]]
      [o.removeItem, ((id, arr) -> x for x in arr when x.id != id)]
      [
        o.toggleItem
        (id, arr) ->
          for x in arr
            if x.id == id then new TaskModel id, x.name, not x.done
            else x
      ]
    ]
    , storedItems

  start performStream o.insertItem.map (name) ->
    (new TaskModel nextId, name).save()
  saveOnChangeIO = changes \
    items
    , (a, b) -> a.length == b.length and a.every (_, i) -> a[i] == b[i]
  .map fgo (arr) -> yield task.save() for task in arr; undefined
  start performStream saveOnChangeIO

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