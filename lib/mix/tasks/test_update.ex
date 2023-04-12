defmodule Mix.Tasks.Test.Update do
  @moduledoc "Download canonical tests from CookLang specs and store them in project."
  @shortdoc @moduledoc

  use Mix.Task

  @tests_url "https://raw.githubusercontent.com/cooklang/spec/main/tests/canonical.yaml"

  @spec run(term) :: :ok
  def run(_) do
    Mix.Task.run("app.start")

    target_dir = Path.join([File.cwd!(), "priv"])
    target_file = Path.join([target_dir, "canonical.yaml"])

    File.mkdir_p!(target_dir)
    File.write!(target_file, download_canonical_tests!(), [:write])

    IO.puts("Canonical tests were updated successfully. Remember to run `mix test.build`!")
  rescue
    error in RuntimeError ->
      IO.puts("Error updating canonical tests: #{error.message}")
  end

  @spec download_canonical_tests! :: binary
  defp download_canonical_tests! do
    case HTTPoison.get(@tests_url) do
      {:ok, %{body: body}} ->
        body

      {:error, reason} ->
        raise reason
    end
  end
end
