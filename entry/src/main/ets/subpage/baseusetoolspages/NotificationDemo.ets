import { notificationManager } from '@kit.NotificationKit';

@Entry
@Component
export struct NotificationDemo {
  publishNotification() {
    let notificationRequest: notificationManager.NotificationRequest = { // 描述通知的请求
      id: 1, // 通知ID
      content: { // 通知内容
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
        normal: { // 基本类型通知内容
          title: '通知内容标题Demo',
          text: '通知内容详情Demo'
        }
      }
    }
    notificationManager.publish(notificationRequest).then(() => { // 发布通知
      console.info('publish success');
    }).catch((err: Error) => {
      console.error(`publish failed,message is ${err}`);
    });
  }

  build() {
    Column() {
      Button('发送通知')
        .onClick(() => {
          this.publishNotification()
        })
    }
    .width('100%')
  }
}