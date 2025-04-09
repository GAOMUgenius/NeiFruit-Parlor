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
  @Track _data: ShopInterface[] = [];
  private _category: CategoryType;
  private _state: DataState = DataState.LOADING;



  constructor(category: CategoryType) {
    super();
    this._category = category;

    this.loadData()
  }


  public convertToShopInterface(poi: POIItem): ShopInterface {
    const picture = poi.photos?.length
      ? poi.photos.map(photo => photo.url)
      : ['app.media.community_icon_add_picture'];
    return {
      id: poi.id,
      name: poi.name,
      location: poi.address,
      phone: poi.tel,
      rating: parseFloat(poi.rating || '5.0'),
      picture: picture
    } as ShopInterface;
  }

  totalCount(): number {
    return this._data.length;
  }

  getData(index: number): ShopInterface {
    return this._data[index];
  }

  public pushDataList(data: ShopInterface[]) {
    this._data = data
    this.reloadData()
  }


  public async loadData() {
    try {
      const userData: UserData = AppStorage.get(PreferenceConstant.USER_DATA)!;
      const poiData = await AMapService.getPOIs(this._category, userData.community_location);
      this._data = poiData.map(this.convertToShopInterface);
      this.reloadData(); // 使用自定义通知方法
    } catch (error) {
      console.error('数据加载失败:', error);
    }
  }

  public reloadData(): void {
    this.notifyDataReload();
  }


  registerDataChangeListener(listener: DataChangeListener): void {
    // 如果数据会动态变化，需要在此处实现监听
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    // 取消监听实现
  }
}