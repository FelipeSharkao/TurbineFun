import * as storage from '../drivers/local-storage.coffee'

import { go } from '@funkia/turbine'
import { moment } from '@funkia/hareactive'

###*
Defines a model that is stored in the localStorage
@abstract
###
class StoredModel
  @modelName: 'never'

  ###*
  @param {string} id
  ###
  constructor: (@id) -> undefined

  itemKey: -> @constructor.itemKey @id

  modelKey: -> @constructor.modelKey()

  save: ->
    self = this
    go ->
      yield storage.setItemIO self.itemKey(), self

      list = yield self.constructor.getIds()
      newList = [(list.filter (v) -> v == self.id)..., self.id]

      yield storage.setItemIO self.modelKey(), newList

  remove: ->
    self = this
    go ->
      yield storage.removeItemIO self.itemKey

      list = yield self.constructor.getIds()
      newList = [(list.filter (v) -> v == self.id)..., self.id]

      yield storage.setItemIO self.modelKey(), newList

  @itemKey: (id) -> "document:#{@modelName}:#{id}"

  @modelKey: -> "model:#{@modelName}"

  @getIds: -> (storage.getItem @modelKey()).map (lst) -> lst or []

  @getOne: (id) ->
    (storage.getItem @itemKey id).map (pojoItem) =>
      Object.create @prototype, Object.getOwnPropertyDescriptors pojoItem

  @getAll: -> moment (at) => ((at @getOne id) for id in at @getIds())


export default StoredModel