package cn.missfresh.fromnow;

import android.app.Activity;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * @ClassName: NativeChannel
 * @Description: java类作用描述
 * @Author: cheng
 * @CreateDate: 2020/6/30 21:38
 * @UpdateUser: 更新者
 * @UpdateDate: 2020/6/30 21:38
 * @UpdateRemark: 更新内容
 * @Version: 1.0
 */
class JumpChannelPlugin implements MethodChannel.MethodCallHandler {
    public static String CHANNEL = "cn.fromnow.jump/plugin";
    private Activity mActivity;
    static MethodChannel sMethodChannel;

    public JumpChannelPlugin(Activity activity) {
        mActivity = activity;
    }

    public static void register(PluginRegistry.Registrar registrar) {
        sMethodChannel = new MethodChannel(registrar.messenger(), CHANNEL);
        JumpChannelPlugin channel = new JumpChannelPlugin(registrar.activity());
        sMethodChannel.setMethodCallHandler(channel);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        if (methodCall.method.equals("----")) {
            // TODO: 2020/6/30
        }
    }
}
