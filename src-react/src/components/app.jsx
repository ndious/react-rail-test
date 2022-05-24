import { QueryClient, QueryClientProvider } from 'react-query'

import Content from './content'

const App = () => {
  const queryClient = new QueryClient()

  return (
    <QueryClientProvider client={queryClient}>
      <Content />
    </QueryClientProvider>
  )
}

export default App
