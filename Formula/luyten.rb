class Luyten < Formula
  desc "Java decompiler GUI for Procyon"
  homepage "https://deathmarine.github.io/Luyten/"
  url "https://github.com/deathmarine/Luyten/releases/download/v0.4.8/luyten-0.4.8.jar", :using => :nounzip
  sha256 "9aabb0afec05906b37b7015607ac3b1b2f736f461ddaa80836cef7fcf5437df8"

  head do
    url "https://github.com/deathmarine/Luyten.git"
    depends_on "maven" => :build
  end

  bottle :unneeded

  depends_on :java => "1.7+"

  def install
    if build.head?
      ENV.java_cache

      ver = `mvn org.apache.maven.plugins:maven-help-plugin:evaluate -Dexpression=project.version`.split.grep(/^\d+\.\d+\.\d+/).uniq.first
      system "mvn", "clean", "package"
      libexec.install "target/luyten-#{ver}.jar"
    else
      ver = version.to_s
      libexec.install "luyten-#{ver}.jar"
    end
    bin.write_jar_script libexec/"luyten-#{ver}.jar", "luyten"
  end

  test do
    assert File.exist?(bin/"luyten"), "I'm an untestable GUI app."
  end
end
