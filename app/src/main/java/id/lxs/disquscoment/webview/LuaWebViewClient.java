package id.lxs.disquscoment.webview;

import android.graphics.Bitmap;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class LuaWebViewClient extends WebViewClient {
    private LuaWebClient creator;

    public LuaWebViewClient(LuaWebClient creator) {
        this.creator = creator;
    }

    @Override
    public void onLoadResource(WebView view, String url) {
        super.onLoadResource(view, url);
        if (creator != null) {
            creator.onLoadResource(view, url);
        }
    }

    @Override
    public void onPageFinished(WebView view, String url) {
        super.onPageFinished(view, url);
        if (creator != null) {
            creator.onPageFinished(view, url);
        }
    }

    @Override
    public void onPageStarted(WebView view, String url, Bitmap favicon) {
        super.onPageStarted(view, url, favicon);
        if (creator != null) {
            creator.onPageStarted(view, url, favicon);
        }
    }

    @Override
    public void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) {
        super.onReceivedError(view, request, error);
        if (creator != null) {
            creator.onReceivedError(view, request, error);
        }
    }

    @Override
    public void onReceivedHttpError(
            WebView view, WebResourceRequest request, WebResourceResponse response) {
        super.onReceivedHttpError(view, request, response);
        if (creator != null) {
            creator.onReceivedHttpError(view, request, response);
        }
    }

    @Override
    public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
        if (creator != null) {
            creator.shouldOverrideUrlLoading(view, request);
        }
        return super.shouldOverrideUrlLoading(view, request);
    }
    
    @Override
    public boolean shouldOverrideUrlLoading(WebView view, String url) {
        if (creator != null) {
            creator.shouldOverrideUrlLoadingUrl(view, url);
        }
        return super.shouldOverrideUrlLoading(view, url);
    }
    
    @Override
    public android.webkit.WebResourceResponse shouldInterceptRequest(WebView view, String url) {
        if (creator != null) {
            creator.shouldInterceptRequestUrl(view, url);
        }
        return super.shouldInterceptRequest(view, url);
    }

    @Override
    public android.webkit.WebResourceResponse shouldInterceptRequest(
            WebView view, WebResourceRequest request) {
        if (creator != null) {
            creator.shouldInterceptRequest(view, request);
        }
        return super.shouldInterceptRequest(view, request);
    }

    @Override
    public void onReceivedError(WebView view, int errorCode, String description, String fallUrl) {
        super.onReceivedError(view, errorCode, description, fallUrl);
        if (creator != null) {
            creator.onReceivedErrorDetail(view, errorCode, description, fallUrl);
        }
    }

    public interface LuaWebClient {
        void onLoadResource(WebView view, String url);

        void onPageFinished(WebView view, String url);

        void onPageStarted(WebView view, String url, Bitmap favicon);

        void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error);

        void onReceivedErrorDetail(WebView view, int errorCode, String description, String fallUrl);

        void onReceivedHttpError(
                WebView view, WebResourceRequest request, WebResourceResponse response);
                
        void shouldOverrideUrlLoadingUrl(WebView view, String url);

        void shouldOverrideUrlLoading(WebView view, WebResourceRequest request);

        void shouldInterceptRequestUrl(WebView view, String url);

        void shouldInterceptRequest(WebView view, WebResourceRequest request);
    }
}
