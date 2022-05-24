import { useQuery } from 'react-query'
import { ListGroup } from 'react-bootstrap'

const ContractsIndex = () => {
  const { isLoading, error, data } = useQuery('contracts', () =>
    fetch('http://localhost:1337/contracts',{
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `${localStorage.getItem('auth-token')}`
      }
    }).then(res => res.json())
  )

  if (isLoading) return 'Loading...'
  if (error) return 'An error has occurred: ' + error.message

  return (
    <div>
      <h1>Contracts</h1>
      { data.map(contract => (
        <ListGroup key={contract.id} horizontal={contract.id} className="my-2">
          <ListGroup.Item>{contract.number || contract.id}</ListGroup.Item>
          <ListGroup.Item>{contract.status}</ListGroup.Item>
          <ListGroup.Item>{contract.start_at}</ListGroup.Item>
          <ListGroup.Item>{contract.end_at}</ListGroup.Item>
        </ListGroup>
      )) }
    </div>
  )
}

export default ContractsIndex
