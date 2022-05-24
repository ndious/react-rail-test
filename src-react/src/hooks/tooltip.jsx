import { useState, useRef } from 'react';
import { useDraggable, useResizable } from './mouseCapabilities'
import PropType from 'prop-types'

const btnCloseStyle = {
  border: '2px solid',
  borderRadius: '5px',
  lineHeight: '32px',
  padding: '0 10px 5px',
  right: 0,
  top: 0,
}

export const useTooltip = (defaultPosistion, defaulSize, defaultLimits) => {
  const dPosistion = { x: 0, y: 0, ...defaultPosistion }
  const dSize = { height: 300, width: 300, ...defaulSize }
  const dLimits = { height: { min: 300, max: 600 }, width: { min: 300, max: 600 }, ...defaultLimits }
  console.log({dPosistion, dSize})
  
  const tooltipRef = useRef(null)
  const [ isVisible, setIsvisible ] = useState(false)
  const [ dragRef, position ] = useDraggable(tooltipRef, dPosistion)
  const [ resizeRef, size ] = useResizable(dSize, dLimits.height, dLimits.width)

  const toggleVisibility = () => {
    setIsvisible(!isVisible)
  }

  const Tooltip = ({ identifier, children, style }) => (
    <div 
      ref={tooltipRef}
      className="position-absolute shadow"
      style={{
        borderRadius: '5px',
        display: isVisible ? 'block' : 'none',
        left: position.x,
        top: position.y,
        ...style,
      }}
    >
      <div className="X position-relative" style={{ width: size.width, height: size.height }}>
        <div ref={dragRef} className="text-center pointer">
          {identifier}
        </div>
        <div onClick={toggleVisibility} className="position-absolute pointer" style={btnCloseStyle}>x</div>
        <div className="p-2">
          { children }
        </div>
        <div ref={resizeRef} className="bg-dark position-absolute" style={{ bottom: 0, right: 0, height: 10, width: 10, cursor: 'nw-resize' }}>
        </div> 
      </div>
    </div>
  )

  Tooltip.propTypes = {
    identifier: PropType.string.isRequired,
    children: PropType.node.isRequired,
    style: PropType.object,
  }

  Tooltip.defaultProps = {
    style: {},
  }

  return [
    Tooltip,
    toggleVisibility,
  ]
}
