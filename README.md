# openai-rails-adapter
Simple Ruby on Rails adapter for OpenAI API

## Usage
A simple service that uses the adapter:
```
class Openai::Completion
  def initialize(prompt)
    @p = prompt
  end
  
  def execute
    response = Openai.complete(
      prompt: @p
      max_tokens: 100
    )
    
    response[0][:choices][0][:text]
  end
end
```

Calling the service with the prompt "Hello, world!"
```
Openai::Completion.new("Hello, world!").execute
```
