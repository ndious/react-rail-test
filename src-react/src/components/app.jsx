import { QueryClient, QueryClientProvider } from 'react-query'

import DefaultView from './default-view'
import Tooltip from './tooltip'


const App = () => {
  const queryClient = new QueryClient()

  return (
    <QueryClientProvider client={queryClient}>
      <DefaultView />
      <Tooltip identifier="test">
        <div>Yeah, I'm a tooltip</div>
      </Tooltip>
    </QueryClientProvider>
  )
}

export default App
