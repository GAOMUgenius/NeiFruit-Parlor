// 导入 HTTP 模块
import http from '@ohos.net.http';
import { PreferenceManager } from 'datastore';
import { APIContants } from 'network/src/main/ets/contants/APIContants';
import { ResourceConstants } from '../constants/ResourceConstants';

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

// 用户服务类
export class UserService {
  private preferenceManager = PreferenceManager.getInstance();

  // 自动登录检查方法
  async checkAutoLogin(): Promise<boolean> {
    try {
      // 检查自动登录开关
      const isAutoLogin = await this.preferenceManager.getValue<boolean>(
        ResourceConstants.IS_AUTOLOGIN_OPEN_KEY
      );

      if (!isAutoLogin) return false;

      // 获取保存的账号信息
      const email = await this.preferenceManager.getValue<string>(
        ResourceConstants.LAST_LOGIN_EMAIL_KEY
      );
      const password = await this.preferenceManager.getValue<string>(
        ResourceConstants.LAST_LOGIN_PASSWORD_KEY
      );

      if (!email || !password) {
        console.log('未找到保存的登录凭证');
        return false;
      }

      // 执行自动登录
      const token = await login(email, password);

      // 登录成功处理
      console.log('自动登录成功');
      // 保存token到存储
      this.saveToken(token)
      return true;
    } catch (error) {
      console.error('自动登录失败:', error);
      // 自动登录失败时关闭自动登录功能
      await this.preferenceManager.setValue(
        ResourceConstants.IS_AUTOLOGIN_OPEN_KEY,
        false
      );
      return false;
    }
  }

  // 手动登录方法
  async manualLogin(email: string, password: string, rememberMe: boolean) {
    try {
      const token = await login(email, password);

      // 根据rememberMe状态保存凭证
      if (rememberMe) {
        await this.saveLoginCredentials(email, password);
      } else {
        // 如果取消记住我，清除历史凭证
        await this.preferenceManager.setValue(
          ResourceConstants.IS_AUTOLOGIN_OPEN_KEY,
          false
        );
      }

      // 保存token
      await this.saveToken(token);
      return true;
    } catch (error) {
      console.error('登录失败:', error);
      throw new Error(error.message || '登录失败');
    }
  }

  // 保存登录凭证方法
  private async saveLoginCredentials(email: string, password: string) {
    await Promise.all([
      this.preferenceManager.setValue(
        ResourceConstants.IS_AUTOLOGIN_OPEN_KEY,
        true
      ),
      this.preferenceManager.setValue(
        ResourceConstants.LAST_LOGIN_EMAIL_KEY,
        email
      ),
      this.preferenceManager.setValue(
        ResourceConstants.LAST_LOGIN_PASSWORD_KEY,
        password
      ),
    ]);
  }

  //token操作方法
  private async saveToken(token: string): Promise<void> {
    await this.preferenceManager.setValue(
      ResourceConstants.USER_TOKEN_KEY,
      token
    );
  }

  async getToken(): Promise<string | null> {
    return this.preferenceManager.getValue<string>(
      ResourceConstants.USER_TOKEN_KEY
    );
  }

  async clearToken(): Promise<void> {
    await this.preferenceManager.deleteValue(
      ResourceConstants.USER_TOKEN_KEY
    );
  }

  // 注销方法
  async logout() {
    // 清除自动登录相关数据
    await Promise.all([
      this.preferenceManager.setValue(
        ResourceConstants.IS_AUTOLOGIN_OPEN_KEY,
        false
      ),
      this.preferenceManager.deleteValue(
        ResourceConstants.LAST_LOGIN_EMAIL_KEY
      ),
      this.preferenceManager.deleteValue(
        ResourceConstants.LAST_LOGIN_PASSWORD_KEY
      ),
    ]);
    // TODO: 清除token和其他用户数据
  }
}