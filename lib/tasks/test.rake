namespace :test do
  desc "Run tests/commands that are run on CI .github/workflows/ci.yml"

  task :ci do
    sh "bin/brakeman --no-pager"
    sh "bin/importmap audit"
    sh "bin/rubocop -f github"
    sh "bin/rails db:test:prepare spec spec:system"
  end
end
