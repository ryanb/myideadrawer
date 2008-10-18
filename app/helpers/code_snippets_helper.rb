module CodeSnippetsHelper
  def coderay(snippet)
    CodeRay.scan(snippet.content.rstrip, snippet.language.downcase).div(:css => :class)
  end
end
