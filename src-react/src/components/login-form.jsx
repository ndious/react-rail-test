import { useState } from 'react';

const LoginForm = ({ afterLoggin }) => {
  const [ email, setEmail ] = useState('admin@unkle.com')
  const [ password, setPassword ] = useState('password')

  const handleSubmit = async (event) => {
    event.preventDefault()
    const response = await fetch('http://localhost:1337/auth/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ email, password }),
    })
    console.log(response)                                 
    if (response.status === 200) {
      const { token } = await response.json()
      localStorage.setItem('auth-token', token)
      afterLoggin()
    }
  }

  return (
    <div className="login-form">
      <div className="login-form-body">
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="email">E-mail</label>
            <input onChange={(e) => setEmail(e.target.value)} value={email} type="text" className="form-control" id="email" placeholder="admin@unkle.com" />
          </div>
          <div className="form-group">
            <label htmlFor="password">Password</label>
            <input onChange={(e) => setPassword(e.target.value)} value={password} type="password" className="form-control" id="password" placeholder="password" />
          </div>
          <button type="submit" className="btn btn-primary">Submit</button>
        </form>
      </div>
    </div>
  );
}

export default LoginForm
