import PropType from 'prop-types'

import { Tooltip } from './template'

Tooltip.prototype = {
  identifier: PropType.string,
  height: PropType.shape({
    min: PropType.number,
    max: PropType.number,
  }),
  width: PropType.shape({
    min: PropType.number,
    max: PropType.number,
  }),
  children: PropType.node,
}

Tooltip.defaultProps = {
  height: {
    min: 300,
    max: 600,
  },
  width: {
    min: 300,
    max: 600,
  },
}

export default Tooltip
