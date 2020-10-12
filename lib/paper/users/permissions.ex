defimpl Paper.Permissions, for: Paper.User  do
  def can?(_, :create_article, _), do: true
end
