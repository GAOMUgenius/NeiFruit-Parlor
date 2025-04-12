import http from '@ohos.net.http';
import { ExpandMode } from '@kit.ArkUI';

// import { i18n } from '@kit.LocalizationKit';
// 定义API 返回的天气数据接口
export class WeatherResponse {
  code: string;
  updateTime: string;
  fxLink: string;
  now: RealtimeWeather;

  constructor(code: string, updateTime: string, fxLink: string, now: RealtimeWeather) {
    this.code = code
    this.updateTime = updateTime
    this.fxLink = fxLink
    this.now = now
  }
}
// 定义实时天气信息的接口
interface RealtimeWeather {
  obsTime: string
  temp: string;
  feelsLike: string;
  icon: string;
  text: string;
  wind360: string
  windDir: string;
  windScale: string;
  windSpeed: string;
  humidity: string;
  precip: string;
  pressure: string;
  vis: string;
  cloud: string;
  dew: string
}


// 发起天气数据的API请求
export async function fetchWeatherData(id: string): Promise<WeatherResponse> {
  const httpClient = http.createHttp();
  const apiKey = 'bb4f27ea1d534542886977213092705a';
  const apiUrl = `https://devapi.qweather.com/v7/weather/now?location=${id}&key=${apiKey}`;

  try {
    const requestOptions: http.HttpRequestOptions = {
      method: http.RequestMethod.GET,
      header: { 'Content-Type': 'application/json' }
    };

    console.log('Sending request to:', apiUrl); // 打印请求URL
    const response = await httpClient.request(apiUrl, requestOptions);

    console.log('Response received:', JSON.stringify(response, null, 2)); // 打印完整响应

    if (response.responseCode === 200) {
      const responseBody = response.result.toString();
      const data: WeatherResponse = JSON.parse(responseBody);
      if (data.code === '200') {
        return data;
      } else {
        throw new Error(`API业务错误：${data.code}`);
      }
    } else {
      throw new Error(`HTTP错误码：${response.responseCode}`);
    }
  } catch (e) {
    console.error('请求失败详情:', e);
    console.error('请求URL:', apiUrl);
    throw new Error(`网络请求失败：${e.message}`);
  }
}

export function changeIcon(icon: string): string {
  switch (icon) {
    // 白天晴
    case '100': return 'sunny_light';
  // 白天多云/阴
    case '101':
    case '104': return 'Overcast_sky';
  // 少云/晴间多云
    case '102':
    case '103': return 'cloudy_light';
  // 夜晚晴
    case '150':
    case '152': return 'sunny_night';
  // 夜晚多云
    case '151':
    case '153': return 'cloudy_night';

  // 雨 (白天)
    case '300': return 'shower_light';      // 阵雨
    case '301': return 'rainstorm';         // 强阵雨
    case '305': return 'small_rain';        // 小雨
    case '306': return 'moderate_rain';     // 中雨
    case '307':
    case '308':
    case '310':
    case '311':
    case '312': return 'heavy_rain';        // 大雨及以上
  // 夜晚降雨
    case '350': return 'shower_night';      // 夜晚阵雨
    case '351': return 'rainstorm';         // 夜晚强阵雨

  // 雷暴相关
    case '302':
    case '303': return 'thundershower';     // 雷阵雨
    case '304': return 'hailstone';         // 冰雹

  // 雪
    case '400': return 'Light_snow';        // 小雪
    case '401': return 'Moderate_snow';     // 中雪
    case '402':
    case '410': return 'Heavy_snow';        // 大雪
    case '403': return 'blizzard';          // 暴雪
    case '404':
    case '405': return 'sleet';             // 雨夹雪
    case '406': return 'shower_light';      // 白天阵雨夹雪
    case '407': return 'Light_snow';        // 白天阵雪
    case '456': return 'sleet';             // 夜晚阵雨夹雪
    case '457': return 'Light_snow';        // 夜晚阵雪
    case '499': return 'snow';              // 通用雪

  // 雾/霾/沙尘
    case '500':
    case '501':
    case '509':
    case '510':
    case '514':
    case '515': return 'The_fog';           // 雾相关
    case '502':
    case '511':
    case '512':
    case '513': return 'haze';              // 霾
    case '503':
    case '504':
    case '507':
    case '508': return 'Sand_blowing';      // 沙尘

  // 极端天气
    case '900':
    case '901': return 'Overcast_sky';      // 热/冷

    // 默认未知天气
    default: return 'Overcast_sky';
  }

}

//获取城市ID
export interface CityData {
  name?: string;
  id?: string;
}
interface City {
  code: string
  location: CityData[]
}

export async function fetchCityNameAndId(city: string): Promise<CityData[]> {
  const apiKey = 'bb4f27ea1d534542886977213092705a';
  const apiUrl = `https://geoapi.qweather.com/v2/city/lookup?location=${city}&key=${apiKey}`;
  try {
    const httpClient = http.createHttp();
    const response = await httpClient.request(
      apiUrl,
      {
        method: http.RequestMethod.GET,
      }
    );
    if (response.responseCode === 200) {
      const responseBody = response.result.toString();
      const data: City = JSON.parse(responseBody);
      if (data.code === '200') {
        // 返回一个符合 CityInfo 结构的对象数组
        return data.location.map((loc: CityData): CityData => ({ name: loc.name, id: loc.id }));
      } else {
        throw new Error('No valid city data found in the response.');
      }
    } else {
      throw new Error(`Server returned error code: ${response.responseCode}`);
    }
  } catch (e) {
    // 打印错误信息，包括请求的URL和错误详情
    console.error('Request failed:', e);
    console.error('Request URL:', apiUrl);
    return []
  }
}

//未来每日天气类
export class FultureWeatherData {
  code: string
  updateTime: string
  fxLink: string
  daily: DailyWeatherData[]

  constructor(code: string, updateTime: string, fxLink: string, daily: DailyWeatherData[]) {
    this.code = code
    this.updateTime = updateTime
    this.fxLink = fxLink
    this.daily = daily
  }
}
//天气信息接口
interface DailyWeatherData {
  fxDate: string
  sunrise: string
  sunset: string
  moonrise: string
  moonset: string
  moonPhase: string
  moonPhaseIcon: string
  tempMax: string
  tempMin: string
  iconDay: string
  textDay: string
  iconNight: string
  textNight: string
  wind360Day: string
  windDirDay: string
  windScaleDay: string
  windSpeedDay: string
  wind360Night: string
  windDirNight: string
  windScaleNight: string
  windSpeedNight: string
  humidity: string
  precip: string
  pressure: string
  vis: string
  cloud: string
  uvIndex: string
}
//获取未来每日天气的数据信息
export async function fetchFultureWeatherData(id: string): Promise<FultureWeatherData> {

  const apiKey = 'bb4f27ea1d534542886977213092705a';
  const apiUrl = `https://devapi.qweather.com/v7/weather/7d?location=${id}&key=${apiKey}`;

  return new Promise<FultureWeatherData>((resolve, reject) => {
    const httpClient = http.createHttp();
    httpClient.request(
      apiUrl,
      {
        method: http.RequestMethod.GET,
      },
      (err, res) => {
        if (err) {
          console.error('Network request failed:', err);
          reject(err);
          return;
        }
        const responseBody = res.result.toString();
        try {
          const fultureWeatherData: FultureWeatherData = JSON.parse(responseBody);
          console.log('texttag', fultureWeatherData);
          resolve(fultureWeatherData);
        } catch (e) {
          console.error('Failed to parse response body:', e);
          reject(e);
        }
      }
    );
  });
}
//未来24小时天气类
export class HourlyWeatherData {
  code: string
  updateTime: string
  fxLink: string
  hourly: HourlyWeather[]

  constructor(code: string, updateTime: string, fxLink: string, hourly: HourlyWeather[]) {
    this.code = code
    this.updateTime = updateTime
    this.fxLink = fxLink
    this.hourly = hourly
  }
}
//天气信息接口
interface HourlyWeather {
  fxTime: string
  temp: string
  icon: string
  text: string
  wind360: string
  windDir: string
  windScale: string
  windSpeed: string
  humidity: string
  pop: string
  precip: string
  pressure: string
  cloud: string
  dew: string
}
//获取24小时天气信息
export async function fetchHourlyWeatherData(id: string): Promise<HourlyWeatherData> {
  const apiKey = 'bb4f27ea1d534542886977213092705a';
  const apiUrl = `https://devapi.qweather.com/v7/weather/24h?location=${id}&key=${apiKey}`;

  return new Promise<HourlyWeatherData>((resolve, reject) => {
    const httpClient = http.createHttp();
    httpClient.request(
      apiUrl,
      {
        method: http.RequestMethod.GET,
      },
      (err, res) => {
        if (err) {
          console.error('Network request failed:', err);
          reject(err);
          return;
        }
        const responseBody = res.result.toString();
        try {
          const hourlyWeatherData: HourlyWeatherData = JSON.parse(responseBody);
          resolve(hourlyWeatherData);
        } catch (e) {
          console.error('Failed to parse response body:', e);
          reject(e);
        }
      }
    );
  });
}