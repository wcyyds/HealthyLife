import { camera } from '@kit.CameraKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct TorchPage {
  @State message: string = 'Hello World';

  build() {
    Column() {

      Button('打开手电筒', { stateEffect: true, type: ButtonType.Capsule })
        .width('80%')
        .height(40)
        .margin(20)
        .onClick(() => {
          camera.getCameraManager(getContext() as common.UIAbilityContext).setTorchMode(1);
        })
      Button('关闭手电筒', { stateEffect: true, type: ButtonType.Capsule })
        .width('80%')
        .height(40)
        .margin(20)
        .onClick(() => {
          camera.getCameraManager(getContext() as common.UIAbilityContext).setTorchMode(0);
        })
    }
    .height('100%')
    .width('100%')
  }
}

//TODO:检测设备手电筒功能是否可用,若不可用则弹出弹窗
function isTorchSupported(cameraManager: camera.CameraManager): boolean {
  let torchSupport: boolean = false;
  try {
    torchSupport = cameraManager.isTorchSupported();
  } catch (error) {
    let err = error as BusinessError;
    console.error('Failed to torch. errorCode = ' + err.code);
  }
  console.info('Returned with the torch support status:' + torchSupport);
  return torchSupport;
}


