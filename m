Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18AC251D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 16:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfEUOXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 10:23:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41578 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfEUOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:23:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so29660411edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3gXOlvlwJpwesLdU0wAdD0yVcQscPI1RKWlQt+svte8=;
        b=g6Zkc/dMLE5Boejgu8PEXQ+7QOwTTqousEgB/e+KN9uezhGHXV4C7M3mwALTnyUsVZ
         3oN70CAVtJZbn6iyWpezw0DBjDdx5iG04Kbd96QFMHc7FVeCzeE+AqNTcSstgrbvlNCk
         NyjYUe9P03iNTR8Inhi/rQAa5seslO2wnmMIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3gXOlvlwJpwesLdU0wAdD0yVcQscPI1RKWlQt+svte8=;
        b=QZ3Kn/MdLKCj46yxWmcb8yWPRT9tFnPdKFSvMEcEFbyJoQd4MWLvn8jEDTNBMjCFdf
         GIsOoVfYjTONuJMG7jfFwZp0X4Ly/UZQgJkKYrDeCRgpjughDHyA9sue3lWF4PSfnVHe
         UtnS9tnsBj005cjeqhNN4KT105ikOA/cdxRf2afJlPlIqoXfY8dRxr75b6ZmMu6pUGIC
         hgcrmIinxDF3Wa3jUHcV46Fg7H4wDoz8nfPInEBGc6SR26x5+P8TaYH8wQ5KKF0zZhaX
         AQm2g6a0WcExx573sY02bD3nu74BYmORbjPGhamyrQPKUMrUMrskUnDivvL6A1StOzF5
         PumA==
X-Gm-Message-State: APjAAAWmhJLqC1NeXurZCf/9aHw5GraUwqXvNJUJ0uZckDml2sZi3dYY
        4Hy4PGQH3rgB9YcNK2Y7xzoJtw==
X-Google-Smtp-Source: APXvYqy9ymxY3fIje99hwSr24R9iys+xHdJialvsImhQdV7ko64jootOFxP+Uar5GiWIF402KYBrrA==
X-Received: by 2002:a17:906:1fc4:: with SMTP id e4mr45550864ejt.81.1558448593084;
        Tue, 21 May 2019 07:23:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c49sm6427547eda.58.2019.05.21.07.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 07:23:12 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] fbcon: Remove fbcon_has_exited
Date:   Tue, 21 May 2019 16:23:04 +0200
Message-Id: <20190521142304.9652-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-10-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-10-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is unused code since

commit 6104c37094e729f3d4ce65797002112735d49cd1
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue Aug 1 17:32:07 2017 +0200

    fbcon: Make fbcon a built-time depency for fbdev

when fbcon was made a compile-time static dependency of fbdev. We
can't exit fbcon anymore without exiting fbdev first, which only works
if all fbdev drivers have unloaded already. Hence this is all dead
code.

v2: I missed that fbcon_exit is also called from con_deinit stuff, and
there fbcon_has_exited prevents double-cleanup. But we can fix that
by properly resetting con2fb_map[] to all -1, which is used everywhere
else to indicate "no fb_info allocate to this console". With that
change the double-cleanup (which resulted in a module refcount underflow,
among other things) is prevented.

Aside: con2fb_map is a signed char, so don't register more than 128 fb_info
or hilarity will ensue.

v3: CI showed me that I still didn't fully understand what's going on
here. The leaked references in con2fb_map have been used upon
rebinding the fb console in fbcon_init. It worked because fbdev
unregistering still cleaned out con2fb_map, and reset it to info_idx.
If the last fbdev driver unregistered, then it also reset info_idx,
and unregistered the fbcon driver.

Imo that's all a bit fragile, so let's keep the con2fb_map reset to
-1, and in fbcon_init pick info_idx if we're starting fresh. That
means unbinding and rebinding will cleanse the mapping, but why are
you doing that if you want to retain the mapping, so should be fine.

Also, I think info_idx == -1 is impossible in fbcon_init - we
unregister the fbcon in that case. So catch&warn about that.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/core/fbcon.c | 39 +++++---------------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5424051c8e1a..622d336cfc81 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -112,7 +112,6 @@ static int softback_lines;
 static int first_fb_vc;
 static int last_fb_vc = MAX_NR_CONSOLES - 1;
 static int fbcon_is_default = 1; 
-static int fbcon_has_exited;
 static int primary_device = -1;
 static int fbcon_has_console_bind;
 
@@ -1050,7 +1049,6 @@ static const char *fbcon_startup(void)
 		info->var.bits_per_pixel);
 
 	fbcon_add_cursor_timer(info);
-	fbcon_has_exited = 0;
 	return display_desc;
 }
 
@@ -1064,9 +1062,13 @@ static void fbcon_init(struct vc_data *vc, int init)
 	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
 	int cap, ret;
 
-	if (info_idx == -1 || info == NULL)
+	if (WARN_ON(info_idx == -1))
 	    return;
 
+	if (con2fb_map[vc->vc_num] == -1)
+		con2fb_map[vc->vc_num] = info_idx;
+
+	info = registered_fb[con2fb_map[vc->vc_num]];
 	cap = info->flags;
 
 	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
@@ -3336,14 +3338,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	struct fb_blit_caps *caps;
 	int idx, ret = 0;
 
-	/*
-	 * ignore all events except driver registration and deregistration
-	 * if fbcon is not active
-	 */
-	if (fbcon_has_exited && !(action == FB_EVENT_FB_REGISTERED ||
-				  action == FB_EVENT_FB_UNREGISTERED))
-		goto done;
-
 	switch(action) {
 	case FB_EVENT_SUSPEND:
 		fbcon_suspended(info);
@@ -3396,7 +3390,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		fbcon_remap_all(idx);
 		break;
 	}
-done:
 	return ret;
 }
 
@@ -3443,9 +3436,6 @@ static ssize_t store_rotate(struct device *device,
 	int rotate, idx;
 	char **last = NULL;
 
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3468,9 +3458,6 @@ static ssize_t store_rotate_all(struct device *device,
 	int rotate, idx;
 	char **last = NULL;
 
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3491,9 +3478,6 @@ static ssize_t show_rotate(struct device *device,
 	struct fb_info *info;
 	int rotate = 0, idx;
 
-	if (fbcon_has_exited)
-		return 0;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3514,9 +3498,6 @@ static ssize_t show_cursor_blink(struct device *device,
 	struct fbcon_ops *ops;
 	int idx, blink = -1;
 
-	if (fbcon_has_exited)
-		return 0;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3543,9 +3524,6 @@ static ssize_t store_cursor_blink(struct device *device,
 	int blink, idx;
 	char **last = NULL;
 
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3668,9 +3646,6 @@ static void fbcon_exit(void)
 	struct fb_info *info;
 	int i, j, mapped;
 
-	if (fbcon_has_exited)
-		return;
-
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 	if (deferred_takeover) {
 		dummycon_unregister_output_notifier(&fbcon_output_nb);
@@ -3695,7 +3670,7 @@ static void fbcon_exit(void)
 		for (j = first_fb_vc; j <= last_fb_vc; j++) {
 			if (con2fb_map[j] == i) {
 				mapped = 1;
-				break;
+				con2fb_map[j] = -1;
 			}
 		}
 
@@ -3718,8 +3693,6 @@ static void fbcon_exit(void)
 				info->queue.func = NULL;
 		}
 	}
-
-	fbcon_has_exited = 1;
 }
 
 void __init fb_console_init(void)
-- 
2.20.1

