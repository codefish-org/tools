class PagesController < ApplicationController
  def home

  end

  def base64
    if request.post?
      @text = params["text"]
      @base64 = params["base64"]
      mode = params["commit"]

      begin
        if mode == "Encode"
          @base64 = Base64.encode64(@text)
        elsif mode == "Encode (strict)"
          @base64 = Base64.strict_encode64(@text)
        end
      rescue ArgumentError => e
        @base64 = e.message
      end

      begin
        if mode == "Decode"
          @text = Base64.decode64(@base64)
        elsif mode == "Decode (strict)"
          @text = Base64.strict_decode64(@base64)
        end
      rescue ArgumentError => e
        @text = e.message
      end
    end
  end
end
