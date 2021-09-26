import { component, elements as e } from '@funkia/turbine'

import deleteSvg from '../assets/delete.svg' 
import { Behavior, isBehavior } from '@funkia/hareactive'

todoItem = ({ name, id }) -> component (o) -> 
  id = if isBehavior id then id else Behavior.of id
  txtCls = o.checked.map (b) ->
    'mx-2 flex-grow' + if b then ' line-through' else ''

  e.div class: [ 'mb-3', 'p-3', 'w-full', 'flex', 'items-center'
                 'bg-purple-500', 'text-white', 'rounded'
                 'transition', 'transform', 'hover:-rotate-1'
                 'hover:-translate-y-3', 'hover:-translate-x-3' ],
    [ e.checkbox()
      .use checked: 'checked'
      e.span class: txtCls, name
      e.button class: 'transition transform hover:scale-125', e.img src: deleteSvg
      .use remove: 'click' ]
  .output remove: o.remove.mapTo true
export default todoItem