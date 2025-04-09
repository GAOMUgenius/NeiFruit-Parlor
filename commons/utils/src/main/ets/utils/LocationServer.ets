import http from '@ohos.net.http';

// 定义返回数据结构接口
export interface IpLocationResult {
  status: string;
  info: string;
  province: string;
  city: string;
  adcode: string;
  rectangle: string;
}

// 定义高德API配置



export async function getIpLocation(ip?: string): Promise<IpLocationResult> {
  // 创建HTTP请求
  const httpRequest = http.createHttp();
  const GAODE_API_KEY = '544ce4be1bc5dbfcd915b51e366bbcc3'; // 请替换为你的高德Web服务API Key
  const GAODE_IP_URL = `https://restapi.amap.com/v3/ip?&key=${GAODE_API_KEY}`;
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
      const result: IpLocationResult = response.result as IpLocationResult

      // 检查接口返回状态
      if (result.status === '1') {
        return result;
      } else {
        throw new Error(`API Error: ${result.info}`);
      }
    } else {
      throw new Error(`HTTP Error: ${response.responseCode}`);
    }
  } catch (error) {
    throw new Error(`Location request failed: ${error}`);
  } finally {
    // 关闭请求
    httpRequest.destroy();
  }
}

export function splitRectangle(geoString: string): string{
  // 将输入的字符串分割成数组
  const coordinates = geoString.split(';');
  // 用于存储格式化后的坐标
  let formattedCoordinates: string[] = [];
  // 用于存储经度和纬度总和
  let totalLon = 0;
  let totalLat = 0;
  // 遍历坐标数组
  coordinates.forEach(coord => {
    // 使用普通的属性访问，而不是解构赋值
    let parts = coord.split(',');
    let lon = Number(parts[0]);
    let lat = Number(parts[1]);
    totalLon += lon;
    totalLat += lat;
  });
  // 计算平均经度和纬度
  const avgLon = totalLon / coordinates.length;
  const avgLat = totalLat / coordinates.length;
  // 四舍五入到小数点后两位
  const roundedLon = avgLon.toFixed(2);
  const roundedLat = avgLat.toFixed(2);
  // // 将格式化后的坐标添加到数组中
  // formattedCoordinates.push(roundedLon + ',' + roundedLat);
  // 将格式化后的坐标数组连接成字符串并返回
  return roundedLon + ',' + roundedLat;
}