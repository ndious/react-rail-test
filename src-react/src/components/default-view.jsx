import { useState } from 'react'
import { useQuery } from 'react-query'

import logo from '../assets/img/logo.svg'
import '../assets/style/app.css'

const DefaultView = () => {
  const [count, setCount] = useState(0)

  const { isLoading, error, data } = useQuery('test', () => fetch('http://localhost:1337/show').then(res => res.json()))

  if (isLoading) { return 'Loading...' }

  if (error) { return `An error has occured: ${error}` }

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>Hello {data.hello}</p>
        <p>
          <button type="button" onClick={() => setCount((count) => count + 1)}>
            count is: {count}
          </button>
        </p>
        <p>
          Edit <code>App.jsx</code> and save to test HMR updates.
        </p>
        <p>
          <a
            className="App-link"
            href="https://reactjs.org"
            target="_blank"
            rel="noopener noreferrer"
          >
            Learn React
          </a>
          {' | '}
          <a
            className="App-link"
            href="https://vitejs.dev/guide/features.html"
            target="_blank"
            rel="noopener noreferrer"
          >
            Vite Docs
          </a>
        </p>
      </header>
    </div>
  )
}

export default DefaultView
