// 创建符合IDataSource接口的数据源
import { BasicDataSource, PreferenceConstant, UserData } from 'datastore';
import { AMapService, POIItem } from './CategoriesListServer';
import { CategoryType, ShopInterface } from './CategoriesModel';
//添加加载状态管理
enum DataState {
  LOADING = 0,
  LOADED,
  ERROR
}

export class ShopDataSource extends  BasicDataSource {
  @Track dataList: ShopInterface[] = [];
  // private _category: CategoryType;
  private _state: DataState = DataState.LOADING;



  // constructor(category: CategoryType) {
  //   super();
  //
  // }


  // public convertToShopInterface(poi: POIItem): ShopInterface {
  //   const picture = poi.photos?.length
  //     ? poi.photos.map(photo => photo.url)
  //     : ['app.media.community_icon_add_picture'];
  //   return {
  //     id: poi.id,
  //     name: poi.name,
  //     location: poi.address,
  //     phone: poi.tel,
  //     rating: parseFloat(poi.rating || '5.0'),
  //     picture: picture
  //   } as ShopInterface;
  // }


  // 添加索引查找方法
  findIndex(predicate: (item: ShopInterface) => boolean): number {
    return this.dataList.findIndex(predicate)
  }

  public totalCount(): number {
    return this.dataList.length;
  }

  public getData(index: number): ShopInterface {
    return this.dataList[index];
  }
  public addData(index: number, data: ShopInterface): void {
    this.dataList.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushDataList(data: ShopInterface[]): void {
    this.dataList = this.dataList.concat(data);
    this.notifyDataAdd(this.dataList.length - data.length);
  }

  public pushDataItem(data: ShopInterface): void {
    this.dataList.push(data);
    this.notifyDataAdd(this.dataList.length - 1);
  }

  public deleteData(index: number): void {
    this.dataList.splice(index, 1);
    this.notifyDataDelete(index);
  }

  public changeData(index: number, data: ShopInterface): void {
    this.dataList.splice(index, 1, data);
    this.notifyDataChange(index);
  }


  // 重新赋值整个数据数组，并通知监听器重新加载所有数据
  public reloadData(data: ShopInterface[]) {
    this.dataList = data; // 更新数据数组
    this.notifyDataReload(); // 通知监听器重新加载所有数据
  }

  public modifyAllData(changeItem: (item: ShopInterface) => ShopInterface): void {
    this.dataList = this.dataList.map((item: ShopInterface) => {
      return changeItem(item);
    })
  }
}