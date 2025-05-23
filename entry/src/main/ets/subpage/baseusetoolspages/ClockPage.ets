import { BusinessError, systemDateTime } from '@kit.BasicServicesKit';
import { display, UIContext } from '@kit.ArkUI';
import { Clock } from './Clock';
import Logger from '../../util/Logger';

const TAG: string = 'ClockPage'

@Entry
@Component
struct ClockPage {
  @State canvasWidth: number = 300
  @State canvasHeight: number = 300
  @State clockTime: number = 0
  @State currentHour: number = 0
  @State currentMinute: number = 0
  @State currentTime: string = '00:00'

  // 获取设备宽高计算表盘大小
  async getSize() {
    let mDisplay = await display.getDefaultDisplay()
    this.canvasWidth = px2vp(mDisplay.width)
    this.canvasHeight = mDisplay.height
  }



  aboutToAppear() {
    this.getSize()
  }

  radianToClockTime(radian: number) : string{
    // 一个完整的圆是 2π 弧度，对应 12 小时
    const totalHours = 12;
    const totalRadians = 2 * Math.PI;
    // 计算对应的小时数
    const hours = (radian / totalRadians) * totalHours;
    // 计算小时和分钟
    const wholeHours = Math.floor(hours);
    const minutes = Math.round((hours - wholeHours) * 60);
    // 格式化时间
    const formattedHours = wholeHours.toString().padStart(2, '0');
    const formattedMinutes = minutes.toString().padStart(2, '0');
    this.currentHour = wholeHours
    this.currentMinute = minutes

    Logger.info(TAG + " movePosition", `time = ${formattedHours}:${formattedMinutes}`)
    return formattedHours + ':' + formattedMinutes
  }

  build() {
    Column() {
      Image($r('app.media.clock_top'))
        .width('100%')
      Stack() {
        Image($r('app.media.clock_center'))
          .id('clock_center')
          .width('100%')
        Clock()
          .onTouch((event: TouchEvent) => {
            switch (event.type) {
              case TouchType.Down:
                break
              case TouchType.Move:
                break
              case TouchType.Up:
                let x = event.changedTouches[0].x
                let y = event.changedTouches[0].y
                let vx = x - this.canvasWidth / 2
                let vy = y - this.canvasWidth * 0.7 / 2
                let angle = -Math.atan2(vx, vy)
                Logger.info(TAG + " movePosition", `angle = ${angle}`)
                Logger.info(TAG + " movePosition", `angle + Math.PI = ${angle + Math.PI}`)
                this.currentTime = this.radianToClockTime(angle + Math.PI * 1)
                break
            }
          })
      }
      .width('100%')
      Image($r('app.media.clock_bottom'))
        .width('100%')
      Text('您当前制定的闹钟是：' + this.currentTime)
        .fontSize(35)
        .fontColor('#000')
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}