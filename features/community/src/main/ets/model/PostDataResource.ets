import { BasicDataSource } from "datastore";
import { PostModel } from "./PostModel";


//包装商品信息符合IDataSource接口的数据源
@Observed
export class PostDataSource extends BasicDataSource {
  @Track dataList: PostModel[] = [];

  public updateItem(newData: PostModel): void {
    const data = new PostModel(
      newData.post_id,
      newData.user_id,
      newData.user_picture,
      newData.user_name,
      newData.user_community,
      newData.post_appraise_number,
      newData.post_likes_number,
      newData.post_title,
      newData.post_content,
      newData.post_content_picture
      );

    // 通过ID查找索引
    const index = this.findIndex((item) => item.user_name === newData.user_name);

    if (index !== -1) {
      // 使用已封装的changeData方法进行替换
      this.changeData(index, data);
    }
  }

  // 添加索引查找方法
  findIndex(predicate: (item: PostModel) => boolean): number {
    return this.dataList.findIndex(predicate)
  }

  public totalCount(): number {
    return this.dataList.length;
  }

  public getData(index: number): PostModel {
    return this.dataList[index];
  }
  public addData(index: number, data: PostModel): void {
    this.dataList.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushDataList(data: PostModel[]): void {
    this.dataList = this.dataList.concat(data);
    this.notifyDataAdd(this.dataList.length - data.length);
  }

  public pushDataItem(data: PostModel): void {
    this.dataList.push(data);
    this.notifyDataAdd(this.dataList.length - 1);
  }

  public deleteData(index: number): void {
    this.dataList.splice(index, 1);
    this.notifyDataDelete(index);
  }

  public changeData(index: number, data: PostModel): void {
    this.dataList.splice(index, 1, data);
    this.notifyDataChange(index);
  }

  public async refreshData(list: PostModel[]): Promise<void> {
    // 使用更精确的对比方式
    const isChanged = this.dataList.length !== list.length

    if (!isChanged) return;

    this.dataList = list.map(item => new PostModel(
      item.post_id,
      item.user_id,
      item.user_picture,
      item.user_name,
      item.user_community,
      item.post_appraise_number,
      item.post_likes_number,
      item.post_title,
      item.post_content,
      item.post_content_picture
    )); // 必须创建新对象
    this.notifyDataReload(); // 确保触发刷新
  }

  public reloadData(): void {
    this.notifyDataReload();
  }

  public modifyAllData(changeItem: (item: PostModel) => PostModel): void {
    this.dataList = this.dataList.map((item: PostModel) => {
      return changeItem(item);
    })
  }

}