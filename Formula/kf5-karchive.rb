require_relative "../lib/cmake"

class Kf5Karchive < Formula
  desc "Process launcher to speed up launching KDE applications"
  homepage "https://api.kde.org/frameworks/karchive/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.111/karchive-5.111.0.tar.xz"
  head "https://invent.kde.org/frameworks/karchive.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Archive REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
