--- 工具属性
tool={
  version="1.1",
}
appName="DisqusComment"--应用名称
packageName="id.lxs.disquscoment"--应用包名
debugActivity="com.androlua.LuaActivity"--运行Lua的Activity
key = "JXNB" --运行Lua时传入的key，用于校验

include={"project:app","project:androlua"}--导入，第一个为主程序
compileLua=true--编译Lua，nil为跟随全局
alignZip = nil --优化APK，nil为跟随全局