require 'minitest'
require 'glut'
require 'rbconfig'

class GlutTest < Minitest::Test
  IS_OS_X = RbConfig::CONFIG['host_os'] =~ /darwin/

  def test_initialize
    Glut.glutInit
    Glut.glutInitDisplayMode Glut::GLUT_RGBA
    Glut.glutInitWindowSize 512, 512

    may_not_exist do
      Glut.glutInitContextVersion 4, 3
    end

    may_not_exist do
      Glut.glutInitContextProfile Glut::GLUT_3_2_CORE_PROFILE
    end
    #Glut.glutExit
  end

  if IS_OS_X
    # Wrapper for OS X.  Some methods just don't exist on OS X, but they do
    # exist in freeglut on all Linux (I *think*), so lets allow OS X versions
    # of methods to raise NotImplementedError, but other OS must implement.
    def may_not_exist
      yield
    rescue NotImplementedError
    end
  else
    def may_not_exist
      yield
    end
  end
end
