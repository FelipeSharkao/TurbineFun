import { snapshot } from '@funkia/hareactive'
import { component, elements as e, go } from '@funkia/turbine'

todoInput = -> component (o) ->
  go ->
    { value } = yield e.input().use value: 'value'
    { click } = yield (e.button 'Insert').use click: 'click'

    insert: snapshot value, click
  .output insert: o.insert

export default todoInput