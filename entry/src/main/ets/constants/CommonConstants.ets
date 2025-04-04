import { Permissions } from "@kit.AbilityKit";

export class CommonConstants{
  static readonly RDB_NAME: string = 'Weather.db'

  static readonly CITY_INFO: string = 'myCityPreferences'

  static readonly TOPIC_HEIGHT: number = 56

  static readonly THOUSANDTH_15: string = '1.5%'; // ‘1.5%’
  static readonly THOUSANDTH_12: string = '2.2%'; // ‘2.2%’
  static readonly THOUSANDTH_33: string = '3.3%'; // ‘3.3%’
  static readonly THOUSANDTH_50: string = '5%'; // ‘5%’
  static readonly THOUSANDTH_66: string = '6.6%'; // ‘6.6%’
  static readonly THOUSANDTH_80: string = '8%'; // ‘8%’
  static readonly THOUSANDTH_100: string = '10%'; // ‘10%’
  static readonly THOUSANDTH_120: string = '12%'; // ‘12%’
  static readonly THOUSANDTH_160: string = '16%'; // ‘16%’
  static readonly THOUSANDTH_400: string = '40%'; // ‘40%’
  static readonly THOUSANDTH_420: string = '42%'; // ‘42%’
  static readonly THOUSANDTH_500: string = '50%'; // ‘50%’
  static readonly THOUSANDTH_560: string = '56%'; // ‘56%’
  static readonly THOUSANDTH_800: string = '80%'; // ‘80%’
  static readonly THOUSANDTH_830: string = '83%'; // ‘83%’
  static readonly THOUSANDTH_880: string = '88%'; // ‘88%’
  static readonly THOUSANDTH_900: string = '90%'; // ‘90%’
  static readonly THOUSANDTH_940: string = '94%'; // ‘90%’
  static readonly THOUSANDTH_1000: string = '100%'; // ‘100%’

  static readonly DEFAULT_2: number = 2;

  static readonly DEFAULT_6: number = 6;

  static readonly DEFAULT_8: number = 8;

  static readonly DEFAULT_12: number = 12;

  static readonly DEFAULT_10: number = 10;

  static readonly DEFAULT_16: number = 16;

  static readonly DEFAULT_18: number = 18;

  static readonly DEFAULT_20: number = 20;

  static readonly DEFAULT_24: number = 24;

  static readonly DEFAULT_28: number = 28;

  static readonly DEFAULT_32: number = 32;

  static readonly DEFAULT_48: number = 48;

  static readonly DEFAULT_56: number = 56;

  static readonly DEFAULT_60: number = 60;

  static readonly DEFAULT_100: number = 100;

  static readonly DEFAULT_180: number = 180;

  // fontWeight
  static readonly FONT_WEIGHT_400: number = 400;

  static readonly FONT_WEIGHT_500: number = 500;

  static readonly FONT_WEIGHT_600: number = 600;

  static readonly FONT_WEIGHT_700: number = 700;

  static readonly FONT_WEIGHT_900: number = 900;

  /**
   * The request permission.
   */
  static readonly REQUEST_PERMISSIONS: Array<Permissions> = ['ohos.permission.ACTIVITY_MOTION',
    'ohos.permission.APPROXIMATELY_LOCATION',
    'ohos.permission.LOCATION'];

  /**
   * The data storage file name.
   */
  static readonly FILE_NAME: string = '/myStore';

  /**
   * The service name.
   */
  static readonly SERVICE_NAME: string = '.ServiceAbility';

  /**
   * The notification title.
   */
  static readonly NOTIFICATION_TITLE: string = 'Current location:';

  /**
   * The event id of service.
   */
  static readonly EVENT_SERVICE_ID: number = 2;

  /**
   * The notification id.
   */
  static readonly NOTIFICATION_ID: number = 1;

  /**
   * The interval time.
   */
  static readonly INTERVAL_TIME: number = 5000;

  /**
   * One hundred.
   */
  static readonly ONE_HUNDRED: number = 100;

  /**
   * Location priority.
   */
  static readonly LOCATION_PRIORITY: number = 0x203;

  /**
   * Location scenario.
   */
  static readonly LOCATION_SCENARIO: number = 0x300;

  /**
   * Location time interval.
   */
  static readonly LOCATION_TIME_INTERVAL: number = 0;

  /**
   * Location distance interval.
   */
  static readonly LOCATION_DISTANCE_INTERVAL: number = 0;

  /**
   * Location max accuracy.
   */
  static readonly LOCATION_MAX_ACCURACY: number = 0;

  /**
   * Want for get steps and location data.
   */
  static readonly WAIT: string = 'The target step count or current position is empty. Please try again later.';

  /**
   *The is status is false.
   */
  static readonly FALSE: string = 'false';

  /**
   * The is status is true.
   */
  static readonly TRUE: string = 'true';

  /**
   * The mac line.
   */
  static readonly MAX_LINE: number = 1;

  /**
   * The divider stroke width.
   */
  static readonly DIVIDER_STROKE_WIDTH: number = 0.5;

  /**
   * The offset dx.
   */
  static readonly OFFSET_DX: number = 0;

  /**
   * The offset dy.
   */
  static readonly OFFSET_DY: number = -12;

  /**
   * The percent sign.
   */
  static readonly PERCENT_SIGN: string = '%';

  /**
   * The progress border radius.
   */
  static readonly PROGRESS_BORDER_RADIUS: number = 100;

  /**
   * The progress stroke width.
   */
  static readonly PROGRESS_STROKE_WIDTH: number = 20;

  /**
   * The progress scale count.
   */
  static readonly PROGRESS_SCALE_COUNT: number = 100;

  /**
   * The progress scale width.
   */
  static readonly PROGRESS_SCALE_WIDTH: number = 30;

  /**
   * The progress total.
   */
  static readonly PROGRESS_TOTAL: number = 100;

  /**
   * The small font weight.
   */
  static readonly SMALL_FONT_WEIGHT: number = 400;

  /**
   * The big font weight.
   */
  static readonly BIG_FONT_WEIGHT: number = 500;

  /**
   * The initialization value.
   */
  static readonly INITIALIZATION_VALUE: string = '0';

  /**
   * The old steps value key.
   */
  static readonly OLD_STEPS: string = 'OLD_STEPS';

  /**
   * The old steps value key.
   */
  static readonly STEP_GOAL: string = 'STEP_GOAL';

  /**
   * The old steps value key.
   */
  static readonly START_POSITION: string = 'START_POSITION';

  /**
   * The current steps tag.
   */
  static readonly CURRENT_STEPS: string = 'CURRENT_STEPS';

  /**
   * The progress value tag.
   */
  static readonly PROGRESS_VALUE_TAG: string = 'PROGRESS_VALUE';

  /**
   * The is start tag.
   */
  static readonly IS_START: string = 'IS_START';

  /**
   * The percent of text input dialog width.
   */
  static readonly DIALOG_WIDTH: string = '93%'

  /**
   * The percent of text input divider width width.
   */
  static readonly DIVIDER_WIDTH: string = '90%';

  /**
   * The percent of current situation width.
   */
  static readonly SITUATION_WIDTH: string = '93%';

  /**
   * The percent of full width.
   */
  static readonly FULL_WIDTH: string = '100%';

  /**
   * The percent of full height.
   */
  static readonly FULL_HEIGHT: string = '100%';
  /**
   * The interval of sensor.
   */
  static readonly SENSOR_INTERVAL: number = 10000000;

}