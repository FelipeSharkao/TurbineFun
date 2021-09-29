import { snapshot } from '@funkia/hareactive'
import { component, elements as e, go } from '@funkia/turbine'

todoInput = -> component (o) ->
  go ->
    { value } =
      yield (e.input class: 'bg-gray-200 py-1 px-3 m-3 rounded')
      .use value: 'value'
    { click } =
      yield e.button \
        class: 'bg-purple-500 text-white py-1 px-3 rounded'
        , 'Insert'
      .use click: 'click'

    insert: snapshot value, click
  .output insert: o.insert

export default todoInput