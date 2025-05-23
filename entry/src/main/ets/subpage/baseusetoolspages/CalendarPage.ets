// EntryAbility.ets
import { BusinessError } from '@kit.BasicServicesKit';
import { calendarManager } from '@kit.CalendarKit';
import { calendarMgr } from '../../entryability/EntryAbility';
import { NotificationDemo } from './NotificationDemo';

let calendar: calendarManager.Calendar | undefined = undefined;

let TAG: string = '**CalendarPage'

@Entry
@Component
struct CalendarPage {
  @State message: string = 'Hello CalendarPage';

  aboutToAppear(): void {
    let eventId : number | undefined = undefined;
    const date = new Date();
    const event: calendarManager.Event = {
      // 日程标题
      title: '试用',
      // 日程类型，不推荐三方开发者使用calendarManager.EventType.IMPORTANT，重要日程类型不支持一键服务跳转功能及无法自定义提醒时间
      type: calendarManager.EventType.NORMAL,
      // 日程开始时间
      startTime: date.getTime(),
      // 日程结束时间
      endTime: date.getTime() + 3 * 60 * 1000,
      // 距开始时间提前10分钟提醒
      reminderTime: [1],
      // 日程重复规则，可选属性。如果日程为周期性日程需要填写该属性。
      recurrenceRule: {
        // 日程重复规则类型，支持按天、按周、按月、按年重复
        recurrenceFrequency: calendarManager.RecurrenceFrequency.DAILY,
        // 日程重复次数，该字段和expire属性只需要填写一个，如果两个都填写按照count属性计算。
        count: 10000,
        // 重复日程间隔时间，与recurrenceFrequency相关，此示例表示日程每隔2天进行重复。
        interval: 1
      },
      // 日程服务，可选字段，需要一键服务功能的日程，填写该属性。
      service: {
        // 服务类型，比如一键查看、一键入会、一键追剧等。
        type: calendarManager.ServiceType.TRIP,
        // 服务的uri。可以跳转到三方应用相应界面，格式为deeplink。使用deeplink方式需要在华为HAG云侧进行注册，注册提供的信息为应用包名、应用的服务类型。
        // deeplink包括scheme、host、path以及参数（不包含参数值）
        uri: 'xxx://xxx.xxx.com/xxx',
        // 服务辅助描述信息，可选字段
        description: '一键服务'
      }
    };


    // 指定日历账户信息
    const calendarAccount: calendarManager.CalendarAccount = {
      // 日历账户名称
      name: 'MyCalendar',
      // 日历账户类型
      type: calendarManager.CalendarType.LOCAL,
      // 日历账户显示名称，该字段如果不填，创建的日历账户在界面显示为空字符串。
      displayName: 'MyCalendar'
    };
    // 创建日历账户
    calendarMgr?.createCalendar(calendarAccount).then((data: calendarManager.Calendar) => {
      console.info(TAG + `Succeeded in creating calendar data->${JSON.stringify(data)}`);
      calendar = data;
      calendar.addEvent(event).then((data: number) => {
        console.info(TAG + `Succeeded in adding event data->${JSON.stringify(data)}`);
        eventId = data;
      }).catch((err: BusinessError) => {
        console.error(TAG + `Failed to add event. Code: ${err.code}, message: ${err.message}`);
      })
      // 查询指定日历账户下的所有日程
      calendar.getEvents().then((data: calendarManager.Event[]) => {
        console.info(TAG + `Succeeded in getting events data->${JSON.stringify(data)}`);
      }).catch((err: BusinessError) => {
        console.error(TAG + `Failed to get events. Code: ${err.code}, message: ${err.message}`);
      })
      // 请确保日历账户创建成功后，再进行后续相关操作
      calendarMgr?.getCalendar(calendarAccount).then((data: calendarManager.Calendar) => {
        console.info(TAG + `Succeeded in getting calendar data->${JSON.stringify(data)}`);
      }).catch((err: BusinessError) => {
        console.error(TAG + `Failed to get calendar. Code: ${err.code}, message: ${err.message}`);
      })
    }).catch((error: BusinessError) => {
      console.error(`Failed to create calendar. Code: ${error.code}, message: ${error.message}`);
    });
  }

  build() {
    Column() {
      Text(this.message)
        .id('CalendarPageHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      NotificationDemo()
    }
    .height('100%')
    .width('100%')
  }
}

const calendarAccount: calendarManager.CalendarAccount = {
  name: 'MyWorkCalendar',
  type: calendarManager.CalendarType.LOCAL,
  displayName: '工作日历'
};
