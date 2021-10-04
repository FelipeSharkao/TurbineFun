import { withEffects } from '@funkia/io'
import { fromFunction } from '@funkia/hareactive'

export getItem = (key) ->
  fromFunction -> JSON.parse localStorage.getItem key

export setItemIO = withEffects (key, value) ->
  localStorage.setItem key, JSON.stringify value

export removeItemIO = withEffects (key) ->
  localStorage.removeItem key