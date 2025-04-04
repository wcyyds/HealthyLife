import { geoLocationManager } from '@kit.LocationKit';
import { promptAction } from '@kit.ArkUI';
import HttpGet from './HttpGet';
import WeatherItem from '../model/weathermodel/WeatherItem';
import City from '../model/weathermodel/City';


class Location{
  latitude:number
  longitude:number

  constructor(latitude: number, longitude: number) {
    this.latitude = latitude;
    this.longitude = longitude;
  }
}

class LocationUtil {
  async getCurrentLocation(): Promise<Location> {
    let loc:Location = new Location(0,0)
    let request: geoLocationManager.SingleLocationRequest = {
      locatingPriority:  0x502,
      locatingTimeoutMs: 10000
    };
     await geoLocationManager.getCurrentLocation(request).then((location: geoLocationManager.Location) => {
      console.log('wcy '+'current location: ' + JSON.stringify(location));
       loc = new Location(location.latitude, location.longitude)
     }).catch((err: Error) => {
      promptAction.showToast({
        message: JSON.stringify(err),
        duration: 2000
      });
       console.log('wcy '+'current location   err: ' + JSON.stringify(err));
    });
    return loc
  }

  async getCityInfoFromCoordinates(latitude: number, longitude: number): Promise<City<WeatherItem>> {
    let TheCity:City<WeatherItem> = new City<WeatherItem>('','')
    const location = `${longitude.toFixed(2)},${latitude.toFixed(2)}`

    await HttpGet.searchCity(location).then( city => {
      if( city.length > 0){
        TheCity = city.shift()!
      }

    })
    return TheCity
  }

  async getCurrentCityInfo(): Promise<City<WeatherItem>> {
    try {
      const location:Location = await this.getCurrentLocation();
      return await this.getCityInfoFromCoordinates(location.latitude, location.longitude);
    } catch (error) {
      console.error('wcy'+'Failed to get current city info:', error);
      throw new Error(error)
    }
  }

  geolocationOn(locationChange: (location: geoLocationManager.Location) => void): void {
    let requestInfo: geoLocationManager.LocationRequest = {
      'priority': 0x203,
      'scenario': 0x300,
      'timeInterval': 0,
      'distanceInterval': 0,
      'maxAccuracy': 0
    }
    try {
      geoLocationManager.on('locationChange', requestInfo, locationChange);
    } catch (err) {
      console.error("locationChange error:" + JSON.stringify(err));
    }
  }

  geolocationOff(): void {
    geoLocationManager.off('locationChange');
  }

}

let locationUtil = new LocationUtil()
export default locationUtil as LocationUtil