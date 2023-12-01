defmodule AOCCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import AOCCase
      setup :load_files
    end
  end

  def load_files(%{day: day, part: part})do
    path = Path.join([
      :code.priv_dir(:aoc_2023),
      "#{day}_#{part}.txt"
    ])

    %{input: File.read!(path)}
  end

  def load_files(_) do
    :ok
  end
end
