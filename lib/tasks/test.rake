namespace :test do
  desc "Run tests/commands that are run on CI .github/workflows/ci.yml. Run `rubocop -A` to auto-correct Rubocop offenses."

  task :ci do
    sh "bin/brakeman --no-pager"
    sh "bin/importmap audit"
    sh "bin/rubocop -f github"
    sh "bin/rails db:test:prepare spec spec:system"
  end
end
