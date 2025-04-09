// src/service/AMapService.ts
import { CommonUtil } from "utils";
import { CategoryType } from "./CategoriesModel";
import { http } from "@kit.NetworkKit";

interface SerVerInterface {
  suggestion: string;
  count: string;
  pois: POIItem[];
  status: string;
  info: string
}

export interface POIItem {
  id: string;
  name: string;
  location: string;  // 经纬度坐标
  address: string;
  tel: string;
  photos?: photosData[]
  rating?: string;
}

interface photosData {
  title: string
  url: string
}

export class AMapService {
  // 分类类型到高德POI类型编码的映射
  private static readonly categoryMapping: Map<CategoryType, string> = new Map([
    [CategoryType.HOST, '050000|060000'],  // 热门：餐饮+购物
    [CategoryType.CATERING, '050000'],     // 餐饮
    [CategoryType.FRESH, '060705'],         // 生鲜超市
    [CategoryType.SCENIC, '110000']         // 景点
  ]);


  static async getPOIs(category: CategoryType, location: string): Promise<POIItem[]> {
    const types = AMapService.categoryMapping.get(category) || '';
    // 创建HTTP请求
    const httpRequest = http.createHttp();
    const GAODE_API_KEY = '544ce4be1bc5dbfcd915b51e366bbcc3'; // 请替换为你的高德Web服务API Key
    const GAODE_IP_URL = `https://restapi.amap.com/v3/place/around?key=${GAODE_API_KEY}&location=${location}&keywords=&types=${types}&radius=1000&offset=20&page=1&extensions=all`;
    try {
      // 配置请求参数
      const requestOptions: http.HttpRequestOptions = {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json',
        },
        expectDataType: http.HttpDataType.OBJECT // 期望返回数据类型
      };

      //发送get请求
      const response = await httpRequest.request(
        GAODE_IP_URL,
        requestOptions
      );
      // 解析响应数据
      if (response.responseCode === 200) {
        const result: SerVerInterface = response.result as SerVerInterface

        // 检查接口返回状态
        if (result.status === '1') {
          return result.pois;
        } else {
          throw new Error(`API Error: ${result.info}`);
        }
      } else {
        throw new Error(`HTTP Error: ${response.responseCode}`);
      }
    } catch (error) {
      console.error('获取高德数据失败:', error);
      return [];
    }
  }

}