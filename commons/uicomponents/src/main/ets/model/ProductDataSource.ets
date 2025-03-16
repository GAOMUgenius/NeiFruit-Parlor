import { BasicDataSource } from "datastore";
import { ProductData } from "./ProductModel";

//包装商品信息符合IDataSource接口的数据源
export class ProductDataSource extends BasicDataSource {
  private dataList: ProductData[] = [];

  public updateItem(newData: ProductData): void {
    const index = this.findIndex(item =>
    item.product_id === newData.product_id
    )
    if (index !== -1) {
      this.changeData(index, newData)
    }
  }

  // 添加索引查找方法
  findIndex(predicate: (item: ProductData) => boolean): number {
    return this.dataList.findIndex(predicate)
  }

  public totalCount(): number {
    return this.dataList.length;
  }

  public getData(index: number): ProductData {
    return this.dataList[index];
  }
  public addData(index: number, data: ProductData): void {
    this.dataList.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushDataList(data: ProductData[]): void {
    this.dataList = this.dataList.concat(data);
    this.notifyDataAdd(this.dataList.length - data.length);
  }

  public pushDataItem(data: ProductData): void {
    this.dataList.push(data);
    this.notifyDataAdd(this.dataList.length - 1);
  }

  public deleteData(index: number): void {
    this.dataList.splice(index, 1);
    this.notifyDataDelete(index);
  }

  // public moveData(from: number, to: number): void {
  //   let temp: T = this.dataList[from];
  //   this.dataList[from] = this.dataList[to];
  //   this.dataList[to] = temp;
  //   this.notifyDataMove(from, to);
  // }

  public changeData(index: number, data: ProductData): void {
    this.dataList.splice(index, 1, data);
    this.notifyDataChange(index);
  }

  public refreshData(list: ProductData[]) {
    this.dataList = list
    this.notifyDataReload()
  }

  public reloadData(): void {
    this.notifyDataReload();
  }

  public modifyAllData(changeItem: (item: ProductData) => ProductData): void {
    this.dataList = this.dataList.map((item: ProductData) => {
      return changeItem(item);
    })
  }

}