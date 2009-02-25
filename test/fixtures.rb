require "dm-sweatshop"
require "integrity"

include DataMapper::Sweatshop::Unique

module Integrity
  module Fixtures

    DataMapper.setup(:default, "sqlite3::memory:")
    DataMapper.auto_migrate!

    Integrity::Project.fixture do
      { :name       => (name = unique { /\w+/.gen }),
        :uri        => "git://github.com/#{/\w+/.gen}/#{name}.git",
        :branch     => ["master", "test-refactoring", "lh-34"].pick,
        :command    => ["rake", "make", "ant -buildfile test.xml"].pick,
        :public     => [true, false].pick,
        :building   => [true, false].pick }
    end

    Integrity::Commit.fixture do
      project = Integrity::Project.first || Integrity::Project.gen

      { :identifier =>   Digest::SHA1.hexdigest(/[:paragraph:]/.gen),
        :message =>      /[:sentence:]/.gen,
        :author =>       /\w+ \w+ <\w+@example.org>/.gen,
        :committed_at => unique {|i| Time.mktime(2008, 12, 15, 18, (59 - i) % 60) },
        :project_id =>   project.id }
    end

    Integrity::Build.fixture do
      commit = Integrity::Commit.first || Integrity::Commit.gen

      { :output       => /[:paragraph:]/.gen,
        :successful   => true,
        :started_at   => unique {|i| Time.mktime(2008, 12, 15, 18, i % 60) },
        :created_at   => unique {|i| Time.mktime(2008, 12, 15, 18, i % 60) },
        :completed_at => unique {|i| Time.mktime(2008, 12, 15, 18, i % 60) },
        :commit_id    => commit.id }
    end

    Integrity::Build.fixture(:successful) do
      Integrity::Build.generate_attributes.update(:successful => true)
    end
  end
end
