package id.lxs.disquscoment.webview;

import android.os.Message;
import android.webkit.WebChromeClient;
import android.webkit.WebView;

public class LuaWebChromeClient extends WebChromeClient {

    private LuaChromeCreator creator;

    public LuaWebChromeClient(LuaChromeCreator creator) {
        this.creator = creator;
    }

    @Override
    public void onReceivedTitle(WebView view, String url) {
        super.onReceivedTitle(view, url);
        if (creator != null) {
            creator.onReceivedTitle(view, url);
        }
    }

    @Override
    public void onCloseWindow(WebView view) {
        super.onCloseWindow(view);
        if (creator != null) {
            creator.onCloseWindow(view);
        }
    }

    @Override
    public boolean onCreateWindow(WebView view, boolean arg1, boolean arg2, Message msg) {
         if (creator != null) {
            creator.onCreateWindow(view, arg1, arg2, msg);
        }
        return super.onCreateWindow(view, arg1, arg2, msg);
    }

    @Override
    public void onProgressChanged(WebView view, int progress) {
        super.onProgressChanged(view, progress);
        if (creator != null) {
            creator.onProgressChanged(view, progress);
        }
    }

    public interface LuaChromeCreator {
        void onReceivedTitle(WebView view, String url);

        void onCloseWindow(WebView view);

        void onCreateWindow(WebView view, boolean arg1, boolean arg2, Message msg);

        void onProgressChanged(WebView view, int progress);
    }
}
