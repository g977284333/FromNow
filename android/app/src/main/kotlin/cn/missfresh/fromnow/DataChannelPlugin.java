package cn.missfresh.fromnow;

import android.app.Activity;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * @ClassName: DataChannel
 * @Description: java类作用描述
 * @Author: cheng
 * @CreateDate: 2020/6/30 22:07
 * @UpdateUser: 更新者
 * @UpdateDate: 2020/6/30 22:07
 * @UpdateRemark: 更新内容
 * @Version: 1.0
 */
class DataChannelPlugin implements EventChannel.StreamHandler {
    public static String CHANNEL = "cn.fromnow.jump/plugin";

    static EventChannel channel;

    private Activity activity;

    private DataChannelPlugin(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new EventChannel(registrar.messenger(), CHANNEL);
        DataChannelPlugin instance = new DataChannelPlugin(registrar.activity());
        channel.setStreamHandler(instance);
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        // TODO: 2020/6/30  eventSink  to do something
    }

    @Override
    public void onCancel(Object o) {

    }
}
