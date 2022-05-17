import { useRef } from 'react'

import { useDragging, useResize } from './hooks'

export const Tooltip = ({ identifier, height, width, children }) => {
  const ref = useRef(null)
  const [ dragRef, position ] = useDragging(ref)
  const [ resizeRef, size ] = useResize(ref, { width: 300, height: 300 }, height, width)

  return (
    <div 
      ref={ref}
      className="position-absolute bg-light shadow"
      style={{
        display: 'block',
        left: position.x,
        top: position.y,
        maxWidth: width.max,
        maxHeight: height.max,
        minWidth: width.min,
        minHeight: height.min,
        pointer: 'cursor',
      }}
    >
      <div className="position-relative" style={{ width: size.width, height: size.height }}>
        <div ref={dragRef} className="text-center pointer">
          {identifier}
        </div>
        <div className="p-2">
          { children }
        </div>
        <div ref={resizeRef} className="bg-dark position-absolute" style={{ bottom: 0, right: 0, height: 10, width: 10, cursor: 'nw-resize' }}>
        </div> 
      </div>
    </div>
  )
}

