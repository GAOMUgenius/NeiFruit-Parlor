// 导入 HTTP 模块
import http from '@ohos.net.http';
import { UserTypeEnum } from 'datastore/src/main/ets/model/UserAccount';
import { APIContants } from 'network/src/main/ets/contants/APIContants';

// 定义响应数据结构接口
interface CodeResponse {
  status: number;
  message: string;
  data: CodeDataResponse
}

interface CodeDataResponse {
  code: string
}

// 获取验证码方法
export async function getVerificationCode(email: string): Promise<string> {
  // 创建 HTTP 客户端
  const httpClient = http.createHttp();
  let ip = APIContants.IP
  let port = APIContants.PORT

  try {
    // 配置请求参数
    const requestOptions: http.HttpRequestOptions = {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: JSON.stringify({ email }), // 请求体数据
      expectDataType: http.HttpDataType.OBJECT // 期望返回数据类型
    };

    // 发送 POST 请求
    const response = await httpClient.request(
      `http://${ip}:${port}/api/v1/auth/code`,
      requestOptions
    );

    // 检查响应状态码
    if (response.responseCode === 200) {
      // 解析响应数据
      const result = response.result as CodeResponse;

      if (result.status === 1000) {
        return result.data.code; // 返回验证码
      } else {
        throw new Error(result.message || '验证码获取失败');
      }
    } else {
      throw new Error(`请求失败，状态码：${response.responseCode}`);
    }
  } catch (error) {
    // 处理错误情况
    console.error('获取验证码失败:', error);
    throw new Error(`网络请求失败：${error.message}`);
  } finally {
    // 释放 HTTP 客户端资源
    httpClient.destroy();
  }
}

// 定义响应数据结构接口
interface SginResponse {
  status: number;
  message: string;
  data: string
}

// 用户注册方法
export async function register(email: string, password: string, type: string, code: string): Promise<boolean> {
  // 创建 HTTP 客户端
  const httpClient = http.createHttp();
  let ip = APIContants.IP
  let port = APIContants.PORT

  try {
    // 配置请求参数
    const requestOptions: http.HttpRequestOptions = {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: JSON.stringify({ email, password, type, code }), // 请求体数据
      expectDataType: http.HttpDataType.OBJECT // 期望返回数据类型
    };

    // 发送 POST 请求
    const response = await httpClient.request(
      `http://${ip}:${port}/api/v1/auth/register`,
      requestOptions
    );

    // 检查响应状态码
    if (response.responseCode === 200) {
      // 解析响应数据
      const result = response.result as SginResponse;

      if (result.status === 1000) {
        return true
      } else {
        throw new Error(result.message || '用户注册失败');
      }
    } else {
      throw new Error(`请求失败，状态码：${response.responseCode}`);
    }
  } catch (error) {
    // 处理错误情况
    console.error('注册失败:', error);
    throw new Error(`网络请求失败：${error.message}`);
  } finally {
    // 释放 HTTP 客户端资源
    httpClient.destroy();
  }
}

// 定义响应数据结构接口
interface LoginResponse {
  status: number;
  message: string;
  data: LoginDataResponse
}

interface LoginDataResponse {
  usuer_id: string
  token: string
}


// 用户登录方法
export async function login(email: string, password: string): Promise<string> {
  // 创建 HTTP 客户端
  const httpClient = http.createHttp();
  let ip = APIContants.IP
  let port = APIContants.PORT

  try {
    // 配置请求参数
    const requestOptions: http.HttpRequestOptions = {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: JSON.stringify({ email, password }), // 请求体数据
      expectDataType: http.HttpDataType.OBJECT // 期望返回数据类型
    };

    // 发送 POST 请求
    const response = await httpClient.request(
      `http://${ip}:${port}/api/v1/auth/login`,
      requestOptions
    );

    // 检查响应状态码
    if (response.responseCode === 200) {
      // 解析响应数据
      const result = response.result as LoginResponse;

      if (result.status === 1000) {
        return result.data.token
      } else {
        throw new Error(result.message || '用户登录失败');
      }
    } else {
      throw new Error(`请求失败，状态码：${response.responseCode}`);
    }
  } catch (error) {
    // 处理错误情况
    console.error('登录失败:', error);
    throw new Error(`网络请求失败：${error.message}`);
  } finally {
    // 释放 HTTP 客户端资源
    httpClient.destroy();
  }
}
