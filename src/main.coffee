import { elements as e, runComponent } from '@funkia/turbine'

import './styles/test.stylus'

App = e.main e.h1 'Hello World'

runComponent '#root', App