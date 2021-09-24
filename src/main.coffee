import { elements as e, runComponent } from '@funkia/turbine'
import todoList from './components/todo-list.coffee'

import 'tailwindcss/tailwind.css'

app = e.main [(e.h1 'Turbine Fun'), todoList()]

runComponent('#root', app)