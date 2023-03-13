# openai-rails-adapter
A simple Ruby on Rails adapter for OpenAI API.

## Dependancies
* `http` gem
* `dotenv-rails` gem
* An OpenAI API key, added to your .env file(s) as `OPENAI_API_KEY`

## Response Format
An array containing the payload (a json object) and status of the HTTP response.

Example response from the Openai.complete() method:
```
[
  {
    :id=>"cmpl-6tU0z5agAEvcQsB1A0PE6dxSrDKcd",
    :object=>"text_completion",
    :created=>1678681437,
    :model=>"text-davinci-003",
    :choices=>[
      {
        :text=>"\n\nMy name is Maureen and I'm excited to learn more about coding",
        :index=>0,
        :logprobs=>nil,
        :finish_reason=>"length"
      }
    ],
    :usage=>{
      :prompt_tokens=>4,
      :completion_tokens=>16,
      :total_tokens=>20
    }
  },
  #<HTTP::Response::Status 200 OK>
]
```

## Example Console Command
To call the API with the prompt "Hello, world!" and return only the text of the first completion:
```
Openai.complete(prompt: "Hello, world!")[0][:choices][0][:text]
```

## Example Service
A simple service that uses the adapter:
```
class Openai::Example
  def initialize(prompt)
    @p = prompt
  end
  
  def execute
    response = Openai.complete(
      prompt: @p
    )
    
    response[0][:choices][0][:text]
  end
end
```

Calling the service with the prompt "Hello, world!"
```
Openai::Example.new("Hello, world!").execute
```
