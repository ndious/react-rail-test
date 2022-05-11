import { QueryClient, QueryClientProvider } from 'react-query'

import DefaultView from './default-view'


const App = () => {
  const queryClient = new QueryClient()

  return (
    <QueryClientProvider client={queryClient}>
      <DefaultView />
    </QueryClientProvider>
  )
}

export default App
