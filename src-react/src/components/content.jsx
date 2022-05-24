import { useState } from 'react'

import { useTooltip } from './../hooks/tooltip'
import LoginForm from './login-form'
import ContractsIndex from './contracts/index'

import logo from '../assets/img/logo.jpeg'
import '../assets/style/app.css'

const Content = () => {
  const [ isLogged, setIsLogged ] = useState(false)
  const [ Tooltip, togleTooltip ] = useTooltip({ x: 200, y: 100 }, { width: 400 })
  const afterLoggin = () => {
    setIsLogged(true)
    togleTooltip()
  }

  return (
    <div className="App">
      {
        !isLogged && (
          <header className="App-header">
            <img src={logo} className="App-logo" alt="logo" />
            <p>Hello unkle</p>
            <div>
              <button type="button" onClick={togleTooltip}>Login</button>
            </div>
          </header>
        )
      }
      {
        isLogged && (<ContractsIndex />)
      }
      <Tooltip identifier="Login" style={{ backgroundColor: '#2b9dfe' }}>
        <div>
          <LoginForm afterLoggin={afterLoggin} />
        </div>
      </Tooltip>
    </div>
  )
}

export default Content
