import * as local from '../drivers/local-storage.coffee'

import StoredModel from './stored.coffee'

###*
Defines a to-do task
###
class TaskModel extends StoredModel
  @modelName: 'task'

  ###*
  @param {string | number} id
  @param {string} name
  @param {string} [done]
  ###
  constructor: (id, @name, @done=false) -> super id


export default TaskModel