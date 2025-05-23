import { CommonConstants } from '../../constants/CommonConstants';

@Entry
@Component
struct MedicinePage {
  @State message: string = 'Hello World';
  @State isShow:boolean = false
  @State addMedicineIsShow:boolean = false
  @State selectMedicineTypeIsShow: boolean = false
  @State setTimerIsShow: boolean = false
  @State medicineName:string = ''
  @State selectOne: boolean = false
  @State selectTwo: boolean = false
  @State selectThree: boolean = false
  @State selectFour: boolean = false

  build() {
    Column() {
      Image($r('app.media.medicine_1'))
        .width('100%')

      Row(){
        Image($r('app.media.medicine_1_1'))
          .width('15%')
        Text('集中一处，跟踪所有用药')
          .fontSize(25)
          .fontColor('#000')
          .fontWeight(500)
          .fontFamily('HarmonyHeiTi-medium')
          .textAlign(TextAlign.Start)
          .width('85%')
          .maxLines(2)
          .margin({ left: 10 ,right: 10})
      }
      .margin(10)
      .width('100%')
      Row(){
        Image($r('app.media.medicine_1_2'))
          .width('15%')
        Text('设置定时并接收提醒')
          .fontSize(25)
          .fontColor('#000')
          .fontWeight(500)
          .fontFamily('HarmonyHeiTi-medium')
          .textAlign(TextAlign.Start)
          .width('85%')
          .maxLines(2)
          .margin({ left: 10 ,right: 10})
      }
      .margin(10)
      .width('100%')
      Row(){
        Image($r('app.media.medicine_1_3'))
          .width('15%')
        Text('你的用药信息已加密，未经许可:不可被任何人读取。')
          .fontSize(25)
          .fontColor('#000')
          .fontWeight(500)
          .fontFamily('HarmonyHeiTi-medium')
          .textAlign(TextAlign.Start)
          .width('80%')
          .maxLines(2)
          .margin({ left: 10 ,right: 10})
      }
      .margin(10)
      .width('100%')
      Button('添加用药')
        .onClick( () => {
          this.isShow = !this.isShow
        })
        .bindSheet(this.isShow, this.AddMedicine(), {
          detents: [700],
          backgroundColor: Color.White,
          blurStyle: BlurStyle.Thick,
          showClose: true,
          enableOutsideInteractive: false,
          dragBar: true
        })
        .width('80%')
        .height('50vp')
        .margin({top: 10, left: 10, right: 10})
        .fontSize(25)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
      Button('你的药品')
        .onClick( () => {
        })
        .width('80%')
        .height('50vp')
        .margin({top: 10, left: 10, right: 10})
        .fontSize(25)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
    }
    .width('100%')
    .height('100%')
  }

  // 点击后开始添加药品
  @Builder AddMedicine(){
    Column() {
      Image($r('app.media.medicine_2'))
        .width('40%')
      Text('药品名称')
        .fontSize(25)
        .fontColor('#000')
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Center)
        .width('80%')
        .maxLines(2)
        .margin({ left: 10 ,right: 10})
      TextInput({ placeholder: '请输入药品名称' })
        .type(InputType.Normal)
        .placeholderColor('#99182431')
        .height('60vp')
        .fontSize(30)
        .backgroundColor('#F1F3F5')
        .width('100%')
        .margin({ top: $r('app.float.input_margin_top') })
        .onChange((value: string) => {
          this.medicineName = value;
        })
      if(this.medicineName == ''){
        Button('请添加药品')
          .width('80%')
          .height('50vp')
          .margin({top: 10, left: 10, right: 10})
          .fontSize(25)
          .fontWeight(500)
          .fontFamily('HarmonyHeiTi-medium')
          .backgroundColor('#ffc6c6c6')
      }else{
        Button('添加用药')
          .onClick( () => {
            this.addMedicineIsShow = !this.addMedicineIsShow
          })
          .bindSheet(this.addMedicineIsShow, this.SelectMedicineType(), {
            detents: [700],
            backgroundColor: Color.White,
            blurStyle: BlurStyle.Thick,
            showClose: true,
            enableOutsideInteractive: false,
            dragBar: true
          })
          .width('80%')
          .height('50vp')
          .margin({top: 10, left: 10, right: 10})
          .fontSize(25)
          .fontWeight(500)
          .fontFamily('HarmonyHeiTi-medium')
      }
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder SelectMedicineType(){
    Column() {
      Image($r('app.media.medicine_3'))
        .width('40%')
      Text('选取药品类型')
        .fontSize(25)
        .fontColor('#000')
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Center)
        .width('80%')
        .maxLines(2)
        .margin({ left: 10 ,right: 10})
      Row(){
        Text('胶囊')
          .fontSize(20)
          .fontColor('#000')
          .fontWeight(500)
          .fontFamily('HarmonyHeiTi-medium')
          .textAlign(TextAlign.Center)
          .width('80%')
          .maxLines(2)
          .margin({ left: 10 ,right: 10})
        Checkbox({name: '1', group: 'checkboxgroup'})
          .select(this.selectOne)
          .selectedColor(0xed6f21)
          .shape(CheckBoxShape.CIRCLE)
          .onChange((value: boolean) => {
            console.info('Checkbox1 change is' + value)
            if(value){
              this.selectOne = true
              this.selectTwo = false
              this.selectThree = false
              this.selectFour = false
            }else {
              this.selectOne = false
              this.selectTwo = false
              this.selectThree = false
              this.selectFour = false
            }
          })
      }
      .width('100%')
      .backgroundColor('#F1F3F5')
      .margin({bottom: 10, right: 10, left: 10})
      .borderRadius(10)
      Row(){
        Text('药片')
          .fontSize(20)
          .fontColor('#000')
          .fontWeight(500)
          .fontFamily('HarmonyHeiTi-medium')
          .textAlign(TextAlign.Center)
          .width('80%')
          .maxLines(2)
          .margin({ left: 10 ,right: 10})
        Checkbox({name: '1', group: 'checkboxgroup'})
          .select(this.selectTwo)
          .selectedColor(0xed6f21)
          .shape(CheckBoxShape.CIRCLE)
          .onChange((value: boolean) => {
            console.info('Checkbox1 change is' + value)
            if(value){
              this.selectOne = false
              this.selectTwo = true
              this.selectThree = false
              this.selectFour = false
            }else {
              this.selectOne = false
              this.selectTwo = false
              this.selectThree = false
              this.selectFour = false
            }
          })
      }
      .width('100%')
      .backgroundColor('#F1F3F5')
      .margin({bottom: 10, right: 10, left: 10})
      .borderRadius(10)
      Row(){
        Text('液体')
          .fontSize(20)
          .fontColor('#000')
          .fontWeight(500)
          .fontFamily('HarmonyHeiTi-medium')
          .textAlign(TextAlign.Center)
          .width('80%')
          .maxLines(2)
          .margin({ left: 10 ,right: 10})
        Checkbox({name: '1', group: 'checkboxgroup'})
          .select(this.selectThree)
          .selectedColor(0xed6f21)
          .shape(CheckBoxShape.CIRCLE)
          .onChange((value: boolean) => {
            console.info('Checkbox1 change is' + value)
            if(value){
              this.selectOne = false
              this.selectTwo = false
              this.selectThree = true
              this.selectFour = false
            }else {
              this.selectOne = false
              this.selectTwo = false
              this.selectThree = false
              this.selectFour = false
            }
          })
      }
      .width('100%')
      .backgroundColor('#F1F3F5')
      .margin({bottom: 10, right: 10, left: 10})
      .borderRadius(10)
      Row(){
        Text('外用')
          .fontSize(20)
          .fontColor('#000')
          .fontWeight(500)
          .fontFamily('HarmonyHeiTi-medium')
          .textAlign(TextAlign.Center)
          .width('80%')
          .maxLines(2)
          .margin({ left: 10 ,right: 10})
        Checkbox({name: '1', group: 'checkboxgroup'})
          .select(this.selectFour)
          .selectedColor(0xed6f21)
          .shape(CheckBoxShape.CIRCLE)
          .onChange((value: boolean) => {
            console.info('Checkbox1 change is' + value)
            if(value){
              this.selectOne = false
              this.selectTwo = false
              this.selectThree = false
              this.selectFour = true
            }else {
              this.selectOne = false
              this.selectTwo = false
              this.selectThree = false
              this.selectFour = false
            }
          })
      }
      .width('100%')
      .backgroundColor('#F1F3F5')
      .margin({bottom: 10, right: 10, left: 10})
      .borderRadius(10)
      Button('下一步')
        .onClick( () => {
          this.selectMedicineTypeIsShow = !this.selectMedicineTypeIsShow
        })
        .bindSheet(this.selectMedicineTypeIsShow, this.SetTimer(), {
          detents: [700],
          backgroundColor: Color.White,
          blurStyle: BlurStyle.Thick,
          showClose: true,
          enableOutsideInteractive: false,
          dragBar: true
        })
        .width('80%')
        .height('50vp')
        .margin({left: 10, right: 10})
        .fontSize(25)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder SetTimer(){
    Column() {
      Image($r('app.media.medicine_4'))
        .width('40%')
      Text('设置定时')
        .fontSize(25)
        .fontColor('#000')
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Center)
        .width('80%')
        .maxLines(2)
        .margin({ left: 10 ,right: 10})
      Text('您何时使用此药')
        .fontSize(25)
        .fontColor('#000')
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Start)
        .width('80%')
        .maxLines(2)
        .margin({ left: 10 ,right: 10})
      TextInput({ placeholder: '请输入药品名称' })
        .type(InputType.Normal)
        .placeholderColor('#99182431')
        .height('60vp')
        .fontSize(30)
        .backgroundColor('#F1F3F5')
        .width('100%')
        .margin({ top: $r('app.float.input_margin_top') })
        .onChange((value: string) => {
        })
      Button('完成')
        .onClick( () => {

        })
        .width('80%')
        .height('50vp')
        .margin({top: 10, left: 10, right: 10})
        .fontSize(25)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
    }
    .alignItems(HorizontalAlign.Center)
  }
}