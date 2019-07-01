Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA7A293D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 10:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390134AbfEXIyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 04:54:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43601 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390042AbfEXIy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so9959104edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MsMckDsaIqnD4KrjektoSrtdcXW7brAmEcL0yv2AeQE=;
        b=Yk9Dy+6XzvOQQSvaeMbCRIim+Torm0BC9ukCEKBvDpi8mVFuZtyPzIE7yMbST9dfUZ
         5WuyhhHquzqq9HX+MNeOrXXPVPVzjKcA91QUixVAO8T+rsOyyzhiSzAkD6kvRG+/CFTx
         xeh3uh2vWoEBahW5Dw5zvP1fNZ2SCTKZ8NA1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsMckDsaIqnD4KrjektoSrtdcXW7brAmEcL0yv2AeQE=;
        b=IBS4qwAusiq0MmVa9oZAjAVh8+5nWXov5sF4bfHXEnqTFaNz+vlHF4V0oqxJIhwXph
         +zWf9ra5f6uOOLYWlYadNwtUuCEf5q0jxkri3z278mA4q0vspbSr+SdbtFvHqMVa1CPw
         3+ToxfGPFPItZo/Gtxb0B+QXKSAmo9NyFORI5I03E6BLDaeX1choGgvYIrAyKcb0Eich
         oFajMr8D/BlxnxyVCeDrreLEAeR2wmBtXtaR8dh2hY1vsC6blKdVByzwhbluB0BqQt+n
         UT2gz7HSYtt0ApBEtaVLNUTsKz/34fSiTOZlh1chitQkn+hbdXHMcq9NzFL8sc0gG2ZE
         rnAA==
X-Gm-Message-State: APjAAAWcox5UJvCOEUV+w1FO/gzDZJRuAdZ0hnN8YQOup40yStZxCSVI
        qGquYr8yGt7UTA2tq8roj05Q71exc7E=
X-Google-Smtp-Source: APXvYqyMxU7qUVQTCqbtG6PoQ2XI/ssDC7It8sHeod2GyIPK9cJ5Cir1tkf908701unGKapk8KiBCA==
X-Received: by 2002:a50:8866:: with SMTP id c35mr1110008edc.35.1558688064330;
        Fri, 24 May 2019 01:54:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:23 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 17/33] fbcon: call fbcon_fb_bind directly
Date:   Fri, 24 May 2019 10:53:38 +0200
Message-Id: <20190524085354.27411-18-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also remove the error return value. That's all errors for either
driver bugs (trying to unbind something that isn't bound), or errors
of the new driver that will take over.

There's nothing the outgoing driver can do about this anyway, so
switch over to void.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Peter Rosin <peda@axentia.se>
Cc: Kees Cook <keescook@chromium.org>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcon.c | 24 +++++++-----------------
 drivers/video/fbdev/core/fbmem.c |  7 ++-----
 include/linux/fb.h               |  2 --
 include/linux/fbcon.h            |  2 ++
 4 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c3353db35adc..f114b4c88796 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3046,7 +3046,7 @@ static int fbcon_mode_deleted(struct fb_info *info,
 }
 
 #ifdef CONFIG_VT_HW_CONSOLE_BINDING
-static int fbcon_unbind(void)
+static void fbcon_unbind(void)
 {
 	int ret;
 
@@ -3055,25 +3055,21 @@ static int fbcon_unbind(void)
 
 	if (!ret)
 		fbcon_has_console_bind = 0;
-
-	return ret;
 }
 #else
-static inline int fbcon_unbind(void)
-{
-	return -EINVAL;
-}
+static inline void fbcon_unbind(void) {}
 #endif /* CONFIG_VT_HW_CONSOLE_BINDING */
 
 /* called with console_lock held */
-static int fbcon_fb_unbind(int idx)
+void fbcon_fb_unbind(struct fb_info *info)
 {
 	int i, new_idx = -1, ret = 0;
+	int idx = info->node;
 
 	WARN_CONSOLE_UNLOCKED();
 
 	if (!fbcon_has_console_bind)
-		return 0;
+		return;
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] != idx &&
@@ -3106,15 +3102,13 @@ static int fbcon_fb_unbind(int idx)
 								     idx, 0);
 					if (ret) {
 						con2fb_map[i] = idx;
-						return ret;
+						return;
 					}
 				}
 			}
 		}
-		ret = fbcon_unbind();
+		fbcon_unbind();
 	}
-
-	return ret;
 }
 
 /* called with console_lock held */
@@ -3352,10 +3346,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		mode = event->data;
 		ret = fbcon_mode_deleted(info, mode);
 		break;
-	case FB_EVENT_FB_UNBIND:
-		idx = info->node;
-		ret = fbcon_fb_unbind(idx);
-		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
 		/* called with console lock held */
 		con2fb = event->data;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d73762324ca2..f3fc2e5b193c 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1716,8 +1716,6 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 
 static int unbind_console(struct fb_info *fb_info)
 {
-	struct fb_event event;
-	int ret;
 	int i = fb_info->node;
 
 	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
@@ -1725,12 +1723,11 @@ static int unbind_console(struct fb_info *fb_info)
 
 	console_lock();
 	lock_fb_info(fb_info);
-	event.info = fb_info;
-	ret = fb_notifier_call_chain(FB_EVENT_FB_UNBIND, &event);
+	fbcon_fb_unbind(fb_info);
 	unlock_fb_info(fb_info);
 	console_unlock();
 
-	return ret;
+	return 0;
 }
 
 static int __unlink_framebuffer(struct fb_info *fb_info);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index aa8f18163151..b6ce041d9e13 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -158,8 +158,6 @@ struct fb_cursor_user {
 #define FB_EVENT_CONBLANK               0x0C
 /*      Get drawing requirements        */
 #define FB_EVENT_GET_REQ                0x0D
-/*      Unbind from the console if possible */
-#define FB_EVENT_FB_UNBIND              0x0E
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 94a71e9e1257..38d44fdb6d14 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -6,11 +6,13 @@ void __init fb_console_init(void);
 void __exit fb_console_exit(void);
 int fbcon_fb_registered(struct fb_info *info);
 void fbcon_fb_unregistered(struct fb_info *info);
+void fbcon_fb_unbind(struct fb_info *info);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
 static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
 static inline void fbcon_fb_unregistered(struct fb_info *info) {}
+static inline void fbcon_fb_unbind(struct fb_info *info) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

