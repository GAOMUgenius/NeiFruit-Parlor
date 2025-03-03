// import { TCPSocket } from '@'
//
// export class TcpServer {
//   private server: TCPSocket;
//
//   constructor() {
//     this.server = socket.constructTCPSocketInstance();
//   }
//
//   public start(port: number): Promise<void> {
//     return new Promise((resolve, reject) => {
//       this.server.bind({ address: '0.0.0.0', port }, (err: Error) => {
//         if (err) return reject(err);
//         this.setupListeners();
//         resolve();
//       });
//     });
//   }
//
//   private setupListeners() {
//     this.server.on('connect', (client: TCPSocket) => {
//       client.on('message', (msgInfo: SocketMessageInfo) => {
//         this.handleMessage(client, msgInfo);
//       });
//     });
//   }
//
//   private handleMessage(client: TCPSocket, msgInfo: SocketMessageInfo) {
//     // 业务逻辑处理...
//   }
//
//   public shutdown() {
//     this.server.close();
//   }
// }