package cn.missfresh.fromnow;

import android.app.Activity;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StringCodec;
import io.flutter.view.FlutterView;

/**
 * @ClassName: BasicMessageChanelPlugin
 * @Description: java类作用描述
 * @Author: cheng
 * @CreateDate: 2020/6/30 22:16
 * @UpdateUser: 更新者
 * @UpdateDate: 2020/6/30 22:16
 * @UpdateRemark: 更新内容
 * @Version: 1.0
 */
class BasicMessageChanelPlugin implements BasicMessageChannel.MessageHandler<String> {
    public static String CHANNEL = "cn.fromnow.basicmsg/plugin";
    private Activity activity;

    private BasicMessageChannel<String> messageChannel;

    static BasicMessageChanelPlugin registerWith(FlutterView flutterView) {
        return new BasicMessageChanelPlugin(flutterView);
    }

    private BasicMessageChanelPlugin(FlutterView flutterView) {
        this.activity = (Activity) flutterView.getContext();
        this.messageChannel = new BasicMessageChannel<>(flutterView, CHANNEL, StringCodec.INSTANCE);
        messageChannel.setMessageHandler(this);
    }


    @Override
    public void onMessage(String s, BasicMessageChannel.Reply<String> reply) {
        reply.reply("BasicMessageChannelPlugin收到：" + s);
    }

    void send(String str, BasicMessageChannel.Reply<String> reply) {
        messageChannel.send(str, reply);
    }
}
