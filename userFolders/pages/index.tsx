import dynamic from 'next/dynamic'
import Layout from 'xrengine/client/components/ui/Layout'
const Scene = dynamic(() => import('xrengine/client/xr/scene/landing'), {
  ssr: false
})

export const IndexPage = () => {
  return (
    <Layout pageTitle="Home">
      <Scene />
    </Layout>
  )
}

export default IndexPage
