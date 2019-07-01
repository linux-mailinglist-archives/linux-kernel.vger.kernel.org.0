Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1B22EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 10:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfETIXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 04:23:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41945 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbfETIW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id m4so22531982edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0bTEF5xAXjjtD3WRRyxu8w7iJRGktyXqotRP83G5Cc=;
        b=Gk4MRvpMNEfVB2X+OOebAKyfX0in1mHPZ9BrDj1zyh/mFdNb3mH1zO+hzmyNRueWJc
         zOKL/wYTkD0sOt0RrnOsIjSqOko9qdc2CHrUAdkQDff6InAn7T6/6J+QU3xxnBe08sBi
         /qwOOjF1PAXAgBps2YI8r1Vp0kMRKg/17qap0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0bTEF5xAXjjtD3WRRyxu8w7iJRGktyXqotRP83G5Cc=;
        b=eXG9MIuoIy8LC1tdsBRqLnwm2vz+FbhjYcpCIS127Ss5kY597qMdG+4JoBeyEgQH9r
         NBZUo8p4y9ipizyD0geEtw/ti9W4n3JDrNgoUzrzBfEaaPY88Lbm973ruLI+GOf0xoAi
         TSvLphi0posnO+GhnZiLQohMkgHhtGS+5lnBHphWjMecjxxERBdB2NabhHRcx20BY8S5
         RWckdSBDhmtHW1MqitodrgQLYUF6sxA0D+SJwRrWqWn1GsfJNIiheOKX8q3B7PHgZIze
         UwKjdEnGzSdLfq6Ynd83a/SwWAIdCpWsfoUC+6Obm+lngOGL2WcV/uKbER1EnckqmLTc
         ydCA==
X-Gm-Message-State: APjAAAXBkdeumJF4d/QO4f40vfXtFlpQYFeOZeC8+gpi0cWkueDa630O
        K+KzhEae9jfDoR7usK1JqZ8PWELYnGM=
X-Google-Smtp-Source: APXvYqwEhuODT9HvDQ/LcQ4deagLmc07/7ACbdQuA0BgS1q7uFDeseO/NLUr+JD2J1kIL7LXR+cxxQ==
X-Received: by 2002:a50:9968:: with SMTP id l37mr73321916edb.143.1558340574981;
        Mon, 20 May 2019 01:22:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:54 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 28/33] fb: Flatten control flow in fb_set_var
Date:   Mon, 20 May 2019 10:22:11 +0200
Message-Id: <20190520082216.26273-29-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of wiring almost everything down to the very last line using
goto soup (but not consistently, where would the fun be otherwise)
drop out early when checks fail. This allows us to flatten the huge
indent levels to just 1.

Aside: If a driver doesn't set ->fb_check_var, then FB_ACTIVATE_NOW
does nothing. This bug exists ever since this code was extracted as a
common helper in 2002, hence I decided against fixing it. Everyone
just better have a fb_check_var to make sure things work correctly.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/video/fbdev/core/fbmem.c | 126 +++++++++++++++----------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 65a075ccac4a..cbd58ba8a59d 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -954,6 +954,9 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 {
 	int flags = info->flags;
 	int ret = 0;
+	u32 activate;
+	struct fb_var_screeninfo old_var;
+	struct fb_videomode mode;
 
 	if (var->activate & FB_ACTIVATE_INV_MODE) {
 		struct fb_videomode mode1, mode2;
@@ -970,87 +973,84 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 			fb_delete_videomode(&mode1, &info->modelist);
 
 
-		ret = (ret) ? -EINVAL : 0;
-		goto done;
+		return ret ? -EINVAL : 0;
 	}
 
-	if ((var->activate & FB_ACTIVATE_FORCE) ||
-	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
-		u32 activate = var->activate;
+	if (!(var->activate & FB_ACTIVATE_FORCE) &&
+	    !memcmp(&info->var, var, sizeof(struct fb_var_screeninfo)))
+		return 0;
 
-		/* When using FOURCC mode, make sure the red, green, blue and
-		 * transp fields are set to 0.
-		 */
-		if ((info->fix.capabilities & FB_CAP_FOURCC) &&
-		    var->grayscale > 1) {
-			if (var->red.offset     || var->green.offset    ||
-			    var->blue.offset    || var->transp.offset   ||
-			    var->red.length     || var->green.length    ||
-			    var->blue.length    || var->transp.length   ||
-			    var->red.msb_right  || var->green.msb_right ||
-			    var->blue.msb_right || var->transp.msb_right)
-				return -EINVAL;
-		}
+	activate = var->activate;
 
-		if (!info->fbops->fb_check_var) {
-			*var = info->var;
-			goto done;
-		}
+	/* When using FOURCC mode, make sure the red, green, blue and
+	 * transp fields are set to 0.
+	 */
+	if ((info->fix.capabilities & FB_CAP_FOURCC) &&
+	    var->grayscale > 1) {
+		if (var->red.offset     || var->green.offset    ||
+		    var->blue.offset    || var->transp.offset   ||
+		    var->red.length     || var->green.length    ||
+		    var->blue.length    || var->transp.length   ||
+		    var->red.msb_right  || var->green.msb_right ||
+		    var->blue.msb_right || var->transp.msb_right)
+			return -EINVAL;
+	}
+
+	if (!info->fbops->fb_check_var) {
+		*var = info->var;
+		return 0;
+	}
 
-		ret = info->fbops->fb_check_var(var, info);
+	ret = info->fbops->fb_check_var(var, info);
 
-		if (ret)
-			goto done;
+	if (ret)
+		return ret;
 
-		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
-			struct fb_var_screeninfo old_var;
-			struct fb_videomode mode;
+	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
+		return 0;
 
-			if (info->fbops->fb_get_caps) {
-				ret = fb_check_caps(info, var, activate);
+	if (info->fbops->fb_get_caps) {
+		ret = fb_check_caps(info, var, activate);
 
-				if (ret)
-					goto done;
-			}
+		if (ret)
+			return ret;
+	}
 
-			old_var = info->var;
-			info->var = *var;
+	old_var = info->var;
+	info->var = *var;
 
-			if (info->fbops->fb_set_par) {
-				ret = info->fbops->fb_set_par(info);
+	if (info->fbops->fb_set_par) {
+		ret = info->fbops->fb_set_par(info);
 
-				if (ret) {
-					info->var = old_var;
-					printk(KERN_WARNING "detected "
-						"fb_set_par error, "
-						"error code: %d\n", ret);
-					goto done;
-				}
-			}
+		if (ret) {
+			info->var = old_var;
+			printk(KERN_WARNING "detected "
+				"fb_set_par error, "
+				"error code: %d\n", ret);
+			return ret;
+		}
+	}
 
-			fb_pan_display(info, &info->var);
-			fb_set_cmap(&info->cmap, info);
-			fb_var_to_videomode(&mode, &info->var);
+	fb_pan_display(info, &info->var);
+	fb_set_cmap(&info->cmap, info);
+	fb_var_to_videomode(&mode, &info->var);
 
-			if (info->modelist.prev && info->modelist.next &&
-			    !list_empty(&info->modelist))
-				ret = fb_add_videomode(&mode, &info->modelist);
+	if (info->modelist.prev && info->modelist.next &&
+	    !list_empty(&info->modelist))
+		ret = fb_add_videomode(&mode, &info->modelist);
 
-			if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
-				struct fb_event event;
-				int evnt = (activate & FB_ACTIVATE_ALL) ?
-					FB_EVENT_MODE_CHANGE_ALL :
-					FB_EVENT_MODE_CHANGE;
+	if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
+		struct fb_event event;
+		int evnt = (activate & FB_ACTIVATE_ALL) ?
+			FB_EVENT_MODE_CHANGE_ALL :
+			FB_EVENT_MODE_CHANGE;
 
-				info->flags &= ~FBINFO_MISC_USEREVENT;
-				event.info = info;
-				event.data = &mode;
-				fb_notifier_call_chain(evnt, &event);
-			}
-		}
+		info->flags &= ~FBINFO_MISC_USEREVENT;
+		event.info = info;
+		event.data = &mode;
+		fb_notifier_call_chain(evnt, &event);
 	}
 
- done:
 	return ret;
 }
 EXPORT_SYMBOL(fb_set_var);
-- 
2.20.1

