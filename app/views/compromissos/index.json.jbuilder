json.array!(@compromissos) do |compromisso|
  json.extract! compromisso, :id, :titulo, :descricao, :date
  json.url compromisso_url(compromisso, format: :json)
end
