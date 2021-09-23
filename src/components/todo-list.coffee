import { elements as e } from '@funkia/turbine'
import todoItem from './todo-item.coffee'

todoList = e.div class: 'm-auto w-96',
  [1..5].map (i) -> todoItem name: "Todo Item #{i}"
export default todoList