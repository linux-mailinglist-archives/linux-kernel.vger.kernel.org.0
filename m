Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5050B293F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 10:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390413AbfEXI4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 04:56:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46804 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389980AbfEXIyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id f37so13271611edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Yo/Zer+8+iZGO3QV40bLkqCAAdgnz/HLbmfJGGYr+Q=;
        b=cFppgu9fnJ/2ig/l4HBHyobS0yHLQykJ8yLGQM9AAcNv7HUmalYinvJ0ZiHtjlY2DS
         0fWKpQ+q8hGL1X4DypWe1pT5oGssfAUU/K4r9Mh84vSzJDX1dgqpC4l7ktU0WNniBa9D
         GEyHmeVCWvTv+fG3oFfLaOaXdMDoJV9eJNWXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Yo/Zer+8+iZGO3QV40bLkqCAAdgnz/HLbmfJGGYr+Q=;
        b=boSLm3dqftm/28XmFhd94QxqzSl482yV/gaD86ayom906IhBuFjtMK3VEseuTO7sHV
         F+O3Y9vrPL3p7kCLO5Q0AWKBe+kxcG8QjAAaX93yGeBp6AMShrW/vhclig5FMjfrCTfH
         vVYbNpLnLpmSWGBSXZyGjSL4Q2GzSXgQLCrkdyFESm0gid5neSoweP1cl46p2oM1KVsO
         OIog52A+JRYnEkKB2HdiT9kNVWOL7ygFMeJFMr5fTCy3b64d3e642n1Jd4ssKrrZT0ak
         DlCpCkO99baqd0glIaTw8JPlLqxLD/cmgWSoPsdcWZCyUSnnXOnViafpk4TMj2/d5zc0
         byig==
X-Gm-Message-State: APjAAAU0pzat7gbG16dCdqNBr0dM6+oPrRAkSHWWLQ3etxiW6MWpbEPm
        g+XC3GyKb5unze3BZt3lxp+VO10J9kA=
X-Google-Smtp-Source: APXvYqyP+e+E2qU4Lv+BMo7M2voezqLCAoqOH/3CPIQ+j9xKGyjgD9b1iL7vXjKHs6owTje8UsWqqA==
X-Received: by 2002:a50:90dd:: with SMTP id d29mr102590308eda.127.1558688059374;
        Fri, 24 May 2019 01:54:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:18 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 13/33] fbdev: sysfs files can't disappear before the device is gone
Date:   Fri, 24 May 2019 10:53:34 +0200
Message-Id: <20190524085354.27411-14-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Which means lock_fb_info can never fail. Remove the error handling.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 44cca39f2b51..5f329278e55f 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -179,10 +179,7 @@ static ssize_t store_modes(struct device *device,
 		return -EINVAL;
 
 	console_lock();
-	if (!lock_fb_info(fb_info)) {
-		console_unlock();
-		return -ENODEV;
-	}
+	lock_fb_info(fb_info);
 
 	list_splice(&fb_info->modelist, &old_list);
 	fb_videomode_to_modelist((const struct fb_videomode *)buf, i,
@@ -409,10 +406,7 @@ static ssize_t store_fbstate(struct device *device,
 	state = simple_strtoul(buf, &last, 0);
 
 	console_lock();
-	if (!lock_fb_info(fb_info)) {
-		console_unlock();
-		return -ENODEV;
-	}
+	lock_fb_info(fb_info);
 
 	fb_set_suspend(fb_info, (int)state);
 
-- 
2.20.1

