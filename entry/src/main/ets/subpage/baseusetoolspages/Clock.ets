/*

 * Copyright (c) 2022 Huawei Device Co., Ltd.

 * Licensed under the Apache License, Version 2.0 (the "License");

 * you may not use this file except in compliance with the License.

 * You may obtain a copy of the License at

 *

 *     http://www.apache.org/licenses/LICENSE-2.0

 *

 * Unless required by applicable law or agreed to in writing, software

 * distributed under the License is distributed on an "AS IS" BASIS,

 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

 * See the License for the specific language governing permissions and

 * limitations under the License.

 */

import display from '@ohos.display'
import Logger from '../../util/Logger'

const TAG: string = 'Clock'

@Component
export struct Clock {

  private settings: RenderingContextSettings = new RenderingContextSettings(true)

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private settingsClock: RenderingContextSettings = new RenderingContextSettings(true)

  private contextClock: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settingsClock)

  @State canvasWidth: number = 300 // 300是表盘默认大小

  private radius: number = 150 // 默认表盘半径

  private windowWidth: number = 0

  private intervalId: number = 0

  updateTime = () => {
    this.context.clearRect(0, 0, this.canvasWidth, this.canvasWidth)
    let nowTime = new Date()
    let hour = nowTime.getHours()
    let minute = nowTime.getMinutes()
    let second = nowTime.getSeconds()
    this.drawBackGround()
    this.drawHour(hour, minute)
    this.drawMinute(minute)
    this.drawSecond(second)
    this.drawDot()
    this.context.translate(-this.radius, -this.radius)
  }

  aboutToAppear() {
    this.getSize()
  }

  // 获取设备宽高计算表盘大小
  async getSize() {
    let mDisplay = await display.getDefaultDisplay()
    Logger.info(TAG, `getDefaultDisplay mDisplay = ${JSON.stringify(mDisplay)}`)
    this.windowWidth = px2vp(mDisplay.width)
    this.canvasWidth = px2vp(mDisplay.width) * 0.7
    this.radius = this.canvasWidth / 2
  }

  drawBackGround() {
    this.context.translate(this.radius, this.radius)
  }

  // 绘制时针
  drawHour(hour: number, minute: number) {
    this.context.save()
    this.context.beginPath()
    this.context.lineWidth = 8
    this.context.lineCap = 'round'
    let rad = 2 * Math.PI / 12 * hour
    let mrad = 2 * Math.PI / 12 / 60 * minute
    this.context.rotate(rad + mrad)
    this.context.moveTo(0, 10)
    this.context.strokeStyle = '#000'
    this.context.lineTo(0, -this.radius / 2)
    this.context.stroke()
    this.context.restore()
  }

  // 绘制分针
  drawMinute(minute: number) {
    this.context.save()
    this.context.beginPath()
    this.context.lineWidth = 5
    this.context.lineCap = 'round'
    let rad = 2 * Math.PI / 60 * minute
    this.context.rotate(rad)
    this.context.moveTo(0, 10)
    this.context.strokeStyle = '#000'
    this.context.lineTo(0, -this.radius + 40)
    this.context.stroke()
    this.context.restore()
  }

  // 绘制秒针
  drawSecond(second: number) {
    this.context.save()
    this.context.beginPath()
    this.context.lineWidth = 2
    this.context.lineCap = 'round'
    let rad = 2 * Math.PI / 60 * second
    this.context.rotate(rad)
    this.context.moveTo(0, 10)
    this.context.strokeStyle = '#05f'
    this.context.lineTo(0, -this.radius + 21)
    this.context.stroke()
    this.context.restore()
  }

  // 绘制闹钟
  drawClock(angle: number) {
    this.contextClock.clearRect(0, 0, this.canvasWidth, this.canvasWidth)
    this.contextClock.translate(this.radius, this.radius)
    this.contextClock.save()
    this.contextClock.beginPath()
    this.contextClock.lineWidth = 12
    this.contextClock.lineCap = 'round'
    let rad = angle + (Math.PI / 2)
    this.contextClock.rotate(rad)
    this.contextClock.moveTo(0, 10)
    this.contextClock.strokeStyle = '#ffff5900'
    this.contextClock.lineTo(0, -this.radius + 21)
    this.contextClock.stroke()
    this.contextClock.restore()
    this.contextClock.translate(-this.radius, -this.radius)
  }

  // 绘制中心点
  drawDot() {
    this.context.save()
    this.context.beginPath()
    this.context.fillStyle = '#05f'
    this.context.arc(0, 0, 4, 0, 2 * Math.PI, false)
    this.context.fill()
    this.context.restore()
  }

  setMovePosition(event: TouchEvent) {
    let x = event.changedTouches[0].x
    let y = event.changedTouches[0].y

    Logger.info("movePosition", `setMovePosition x = ${x}, y = ${y}`)
    let vx = x - this.windowWidth / 2
    let vy = y - this.radius

    let angle = Math.atan2(vy, vx)
    Logger.info("movePosition", `angle = ${angle}`)
    this.drawClock(angle)
  }

  handleTouchEvent(event: TouchEvent) {
    switch (event.type) {
      case TouchType.Down:
        break
      case TouchType.Move:
        this.setMovePosition(event)
        break
      case TouchType.Up:
        break
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.contextClock)
      .width(this.canvasWidth)
      .height(this.canvasWidth)
      .onReady(() => {
        this.drawClock(-Math.PI / 2)
      })
      Canvas(this.context)
        .width(this.canvasWidth)
        .height(this.canvasWidth)
        .onReady(() => {
          this.updateTime()
          this.intervalId = setInterval(this.updateTime, 1000)
        })
    }
    .width('100%')
    .onTouch(this.handleTouchEvent.bind(this))
  }

  onPageHide() {
    clearInterval(this.intervalId)
  }

  aboutToDisappear(){
    clearInterval(this.intervalId)
  }
}
