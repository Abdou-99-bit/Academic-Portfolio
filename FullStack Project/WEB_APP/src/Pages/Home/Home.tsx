import { Hero } from "../../components/Hero/Hero"
import { FeaturesSection } from "../../components/Features/FeaturesSection"
import { ProductsSection } from "../../components/ProductsSection/ProductsSection"
import { WatchesSection } from "../../components/WatchesSection/WatchesSection"
import { SaleBanner } from "../../components/SaleBanner/SaleBanner"
import { BlogSection } from "../../components/BlogSection/BlogSection"
import { TestimonialSection } from "../../components/TestimonialSection/TestimonialSection"
import { SubscribeSection } from "../../components/SubscribeSection/SubscribeSection"


export const Home = () => {
  return (
    <>
      <Hero />
      <FeaturesSection />
      <ProductsSection />
      <WatchesSection />
      <SaleBanner />
      <BlogSection />
      <TestimonialSection />
      <SubscribeSection />
 
    </>
  )
}