import { BasicDataSource } from "datastore";
import { AppraiseData } from "./AppraiseModel";


//包装商品信息符合IDataSource接口的数据源
@Observed
export class AppraiseDataSource extends BasicDataSource {
  @Track dataList: AppraiseData[] = [];

  public updateItem(newData: AppraiseData): void {
    const data = new AppraiseData();

    // 通过ID查找索引
    const index = this.findIndex((item) => item.user_name === newData.user_name);

    if (index !== -1) {
      // 使用已封装的changeData方法进行替换
      this.changeData(index, data);
    }
  }

  // 添加索引查找方法
  findIndex(predicate: (item: AppraiseData) => boolean): number {
    return this.dataList.findIndex(predicate)
  }

  public totalCount(): number {
    return this.dataList.length;
  }

  public getData(index: number): AppraiseData {
    return this.dataList[index];
  }
  public addData(index: number, data: AppraiseData): void {
    this.dataList.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushDataList(data: AppraiseData[]): void {
    this.dataList = this.dataList.concat(data);
    this.notifyDataAdd(this.dataList.length - data.length);
  }

  public pushDataItem(data: AppraiseData): void {
    this.dataList.push(data);
    this.notifyDataAdd(this.dataList.length - 1);
  }

  public deleteData(index: number): void {
    this.dataList.splice(index, 1);
    this.notifyDataDelete(index);
  }

  public changeData(index: number, data: AppraiseData): void {
    this.dataList.splice(index, 1, data);
    this.notifyDataChange(index);
  }

  public async refreshData(list: AppraiseData[]): Promise<void> {
    // 使用更精确的对比方式
    const isChanged = this.dataList.length !== list.length

    if (!isChanged) return;

    this.dataList = list.map(item => new AppraiseData()); // 必须创建新对象
    this.notifyDataReload(); // 确保触发刷新
  }

  public reloadData(): void {
    this.notifyDataReload();
  }

  public modifyAllData(changeItem: (item: AppraiseData) => AppraiseData): void {
    this.dataList = this.dataList.map((item: AppraiseData) => {
      return changeItem(item);
    })
  }

}