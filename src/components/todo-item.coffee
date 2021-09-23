import { component, elements as e } from '@funkia/turbine'
import deleteSvg from '../assets/delete.svg' 

todoItem = ({ name }) -> 
  e.div class: 'mb-3 p-3 w-full flex items-center bg-purple-500 text-white rounded-lg',
    [ e.input type: 'checkbox'
        .use checked: 'checked'
      e.span class: 'mx-2 flex-grow', name
      e.button class: 'transition transform hover:scale-125', e.img src: deleteSvg
        .use remove: 'click' ]
export default todoItem