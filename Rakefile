#!/usr/bin/env rake

require "ans-releaser"

class ReleaseTask
  include Ans::Releaser::GemTask

  def gem_host
    "gem.ans-web.co.jp"
  end
  def gem_root
    "/var/www/gem/public"
  end
end

ReleaseTask.new.build_release_tasks
