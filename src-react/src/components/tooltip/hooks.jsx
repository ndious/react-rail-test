import { useState, useEffect, useRef } from 'react'

export const useConfigurableSize = (defaultWidth, defaultHeight) => {
  const [ size, setSize ] = useState({ width: defaultWidth, height: defaultHeight })

  const setWidth = (width) => setSize({ ...size, width })
  const setHeight = (height) => setSize({ ...size, height })

  return [ size, setWidth, setHeight ]
}

export const useConfigurablePosition = (defaultX, defaultY) => {
  const [ position, setPosition ] = useState({ x: defaultX, y: defaultY })
  
  const setX = (x) => setPosition({ ...position, x })
  const setY = (y) => setPosition({ ...position, y })

  return [ position, setX, setY ]
}

const handleMouseMove = (isAvailable) => (handler) => (event) => {
  if (isAvailable) { return } 

  handler(event)

  event.stopPropagation()
  event.preventDefault()
}

const handleMouseDown = (isProcessing) => (handle) => (event) => {
  if (event.button !== 0) { return }

  isProcessing(true)

  handle(event)

  event.stopPropagation()
  event.preventDefault()
}

const handleMouseUp =  (setIsProcessing) => (event) => {
  setIsProcessing(false)

  event.stopPropagation()
  event.preventDefault()
}

const getValueBehindLimits = (value, { min, max }) => (value < min || value > max)
      ? ( // limit height reached
        value < min && min || 
        value > max && max
      ) : value


/**
 * Give the ability to your component to be resizable
 *
 * @param component React.MutableRefObject
 */
export const useResize = (component, defaultSize, heightLimit, widthLimit) => {
  const ref = useRef(null)
  const [ isResizing, setIsResizing ] = useState(false)
  const [ delta, setDelta ] = useState({ x: 0, y: 0 })
  const [ size, setSize ] = useState({
    height: defaultSize.height,
    width: defaultSize.width,
  })
        
  const onMouseMove = handleMouseMove(!isResizing)((event) => {
    const newHeight = size.height + (event.y - delta.y)
    const newWidth = size.width + (event.x - delta.x)

    const height = getValueBehindLimits(newHeight, heightLimit)
    const width = getValueBehindLimits(newWidth, widthLimit)

    setSize({
      height,
      width,
    })
  })

  const onMouseUp = handleMouseUp(setIsResizing)  

  const onMouseDown = handleMouseDown(setIsResizing)((event) => setDelta({
    x: event.clientX,
    y: event.clientY,
  }))

  useEffect(() => {
    ref.current.addEventListener('mousedown', onMouseDown)

    return () => {
      ref.current.removeEventListener('mousedown', onMouseDown)
    };
  }, [ ref.current ])


  useEffect(() => {
    if (isResizing) {
      document.addEventListener('mouseup', onMouseUp)
      document.addEventListener('mousemove', onMouseMove)
    } else {
      document.removeEventListener('mouseup', onMouseUp)
      document.removeEventListener('mousemove', onMouseMove)
    }

    return () => {
      document.removeEventListener('mouseup', onMouseUp)
      document.removeEventListener('mousemove', onMouseMove)
    };
  }, [ isResizing ]);

  return [ ref, size, isResizing ]
}

/**
 * Hook used to transform your div into a draggable element
 *
 * @param element React.MutableRefObject
 * @return [ React.MutableRefObject, number, number, boolean ]
 */
export const useDragging = (element) => {
  const ref = useRef(null)
  const [ isDragging, setIsDragging ] = useState(false)
  const [ delta, setDelta ] = useState({ x: 0, y: 0 })
  const [ position, setPosition ] = useState({ x: 0, y: 0 })

  /**
   * When thw mouse move we need to recompute the element position by subtracting
   * the mouse position over the div and the mouse position in the document
   *
   * @param event MouseEvent
   */
  const onMouseMove = handleMouseMove(!isDragging)((event) => setPosition({
    x: event.x - delta.x,
    y: event.y - delta.y,
  }))
   
  const onMouseUp = handleMouseUp(setIsDragging)

  /**
   * When the user click, we need to compute the mouse position in the div
   * This delta is computed by subtracting the div position by the mouse position
   *
   * @param event MouseEvent
   */
  const onMouseDown = handleMouseDown(setIsDragging)((event) => setDelta({
      x: event.x - element.current.offsetLeft,
      y: event.y - element.current.offsetTop,
    }))

  // Attach mouse listeners

  // When the element mounts, attach an mousedown listener
  useEffect(() => {
    ref.current.addEventListener('mousedown', onMouseDown)

    return () => {
      ref.current.removeEventListener('mousedown', onMouseDown)
    };
  }, [ ref.current ])

  // Every time the isDragging state changes, assign or remove
  // the corresponding mousemove and mouseup handlers
  useEffect(() => {
    if (isDragging) {
      document.addEventListener('mouseup', onMouseUp)
      document.addEventListener('mousemove', onMouseMove)
    } else {
      document.removeEventListener('mouseup', onMouseUp)
      document.removeEventListener('mousemove', onMouseMove)
    }

    return () => {
      document.removeEventListener('mouseup', onMouseUp)
      document.removeEventListener('mousemove', onMouseMove)
    };
  }, [ isDragging ]);

  return [ ref, position, isDragging ]
}
