// 定义 Usage 类，用于存储使用情况信息
class Usage {
  prompt_tokens: number = 0;
  completion_tokens: number = 0;
  total_tokens: number = 0;
  prompt_tokens_details: null = null
}

// 定义 ChoiceMessage 类，用于存储消息信息
class ChoiceMessage {
  role: string = "";
  content: string = "";
}

// 定义 Choice 类，用于存储选择信息
class Choice {
  message: ChoiceMessage = new ChoiceMessage();
  finish_reason: string = "";
  index: number = 0;
  logprobs: null = null;
}

// 定义 WenXinReturn 类，用于存储整体返回信息
export class WenXinReturn {
  choices: Choice[] = [];
  object: string = "";
  usage: Usage = new Usage();
  created: number = 0;
  system_fingerprint: null = null;
  model: string = "";
  id: string = "";
}


export class MsgOutput {
  content: string = ""
}

export class MsgInput {
  id: string = ""
  role: string = ""
  content: string = ""
}