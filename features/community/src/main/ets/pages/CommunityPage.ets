import { PostComponent } from "../components/PostComponent"
import { PostDataSource } from "../model/PostDataResource"
import { postDataEg, PostModel } from "../model/PostModel"

@Component
export struct CommunityPage {
  @State postListData: PostDataSource = new PostDataSource()

  aboutToAppear(): void {
    this.postListData.pushDataList([postDataEg])
  }

  build() {
    NavDestination() {
      Stack() {
        Scroll() {
          WaterFlow() {
             LazyForEach(this.postListData, (item: PostModel) => {
               PostComponent({ postData: item })
             })
          }
        }
      }
    }
  }
}
