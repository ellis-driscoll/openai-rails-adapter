class Openai
  class << self
    OPENAI_API_KEY = ENV.fetch("OPENAI_API_KEY", nil).freeze
    DEFAULT_MAX_TOKENS = 16.freeze
    DEFAULT_TEMP = 0.6.freeze
    DEFAULT_TOP_P = 1.freeze
    DEFAULT_STOP = nil.freeze

    def complete(
      model: "text-davinci-003",
      prompt: nil,
      suffix: nil,
      logprobs: nil,
      echo: false,
      best_of: 1,
      max_tokens: DEFAULT_MAX_TOKENS,
      temperature: DEFAULT_TEMP,
      top_p: DEFAULT_TOP_P,
      n: 1, # rubocop:disable Naming/MethodParameterName
      stream: false,
      stop: DEFAULT_STOP,
      presence_penalty: 0,
      frequency_penalty: 0,
      logit_bias: {},
      user: ""
    )
      resp = HTTP.headers({
        "Content-Type": "application/json",
        "Authorization": "Bearer #{OPENAI_API_KEY}"
      }).post("https://api.openai.com/v1/completions", json: {
        model: model,
        prompt: prompt,
        suffix: suffix,
        logprobs: logprobs,
        echo: echo,
        best_of: best_of,
        max_tokens: max_tokens,
        temperature: temperature,
        top_p: top_p,
        n: n,
        stream: stream,
        stop: stop,
        presence_penalty: presence_penalty,
        frequency_penalty: frequency_penalty,
        logit_bias: logit_bias,
        user: user,
      })
      data = resp.parse.deep_symbolize_keys

      [data, resp.status]
    end

    def chat(
      model: "gpt-3.5-turbo",
      messages: [],
      max_tokens: DEFAULT_MAX_TOKENS,
      temperature: DEFAULT_TEMP,
      top_p: DEFAULT_TOP_P,
      n: 1, # rubocop:disable Naming/MethodParameterName
      stream: false,
      stop: DEFAULT_STOP,
      presence_penalty: 0,
      frequency_penalty: 0,
      logit_bias: {},
      user: ""
    )
      resp = HTTP.headers({
        "Content-Type": "application/json",
        "Authorization": "Bearer #{OPENAI_API_KEY}"
      }).post("https://api.openai.com/v1/chat/completions", json: {
        model: model,
        messages: messages,
        max_tokens: max_tokens,
        temperature: temperature,
        top_p: top_p,
        n: n,
        stream: stream,
        stop: stop,
        presence_penalty: presence_penalty,
        frequency_penalty: frequency_penalty,
        logit_bias: logit_bias,
        user: user,
      })

      data = resp.parse.deep_symbolize_keys

      [data, resp.status]
    end

    def edit(
      model: "text-davinci-edit-001",
      input: "",
      instruction: "",
      n: 1, # rubocop:disable Naming/MethodParameterName
      temperature: DEFAULT_TEMP,
      top_p: DEFAULT_TOP_P
    )
      resp = HTTP.headers({
        "Content-Type": "application/json",
        "Authorization": "Bearer #{OPENAI_API_KEY}"
      }).post("https://api.openai.com/v1/edits", json: {
        model: model,
        input: input,
        instruction: instruction,
        n: n,
        temperature: temperature,
        top_p: top_p,
      })

      data = resp.parse.deep_symbolize_keys

      [data, resp.status]
    end
  end
end
