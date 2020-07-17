package cn.missfresh.fromnow;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;

/**
 * @ClassName: ChannelActivity
 * @Description: java类作用描述
 * @Author: cheng
 * @CreateDate: 2020/6/30 21:48
 * @UpdateUser: 更新者
 * @UpdateDate: 2020/6/30 21:48
 * @UpdateRemark: 更新内容
 * @Version: 1.0
 */
class ChannelActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 注册原生交互
        JumpChannelPlugin.register(this.registrarFor(JumpChannelPlugin.CHANNEL));
        DataChannelPlugin.registerWith(this.registrarFor(DataChannelPlugin.CHANNEL));
        BasicMessageChanelPlugin.registerWith(this.getFlutterView());
    }
}
