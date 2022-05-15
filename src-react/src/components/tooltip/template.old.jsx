import { useEffect, useState } from 'react'
import { createPortal } from 'react-dom'

import { useConfigurableSize, useConfigurablePosition } from './hooks'

export const Tooltip = ({ identifier, height, width, children }) => {
  const [ el ] = useState(document.createElement('di'))

  const [ isOpen, setIsOpen ] = useState(true)
  const [ position, setX, setY ] = useConfigurablePosition(0, 0)
  const [ size, setWidth, setHeight ] = useConfigurableSize(height.min, width.min)
  const [ isDraggable, setIsDraggable ] = useState(false)
  const [ isDragging, setIsDraging ] = useState(false)

  const handleOver = () => setIsDraggable(true)
  const handleBlur = () => setIsDraggable(false)
  const handleDragStart = (event) => {
    const dataTransfer = event.dataTransfer

    document.addEventListener('mousemove', handleDrag)

    dataTransfer.dropEffect = 'move'
    dataTransfer.effectAllowed = 'move'
    dataTransfer.addElement(el)
    dataTransfer.setData('text', identifier)

    setIsDraging(true)
  }
  const handleDragEnd = () => {
    document.removeEventListener('mousemove', handleDrag)
    setIsDraging(false)
  }
  const handleDrag = ({ clientX, clientY }) => {
    console.log({ clientX, clientY })
  }

  setTimeout(() => document.getElementById('root').appendChild(el), 500)

  return createPortal(
    <div>
      <div 
    
        draggable={isDraggable}
        onDragStart={handleDragStart}
        onDragEnd={event => {
          handleDragEnd()
          handleDrag(event)
        }}
        className="position-absolute bg-light shadow"
        style={{
          display: isOpen ? 'block' : 'none',
          top: position.x,
          left: position.y,
          with: size.width,
          height: size.height,
          maxWidth: width.max,
          maxHeight: height.max,
          minWidth: width.min,
          minHeight: height.min,
          pointer: 'cursor',
        }}
      >
        <div className="text-center pointer" onMouseEnter={handleOver} onMouseLeave={handleBlur}>
          {identifier}
        </div>
        <div className="p-2">
          { children }
        </div>
      </div>
    </div>,
    el
  )
}

