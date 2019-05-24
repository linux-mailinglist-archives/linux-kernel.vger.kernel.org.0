Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21326293D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 10:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389964AbfEXIy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 04:54:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35079 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389970AbfEXIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so13357294edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MAPnhxqw8kme2eR+AuVFsaR4pvfjpQV+5x2Qx7ASEQ8=;
        b=g5enIYA9/Sf7GfGnysfGpukptLtI9FO3uexJgB1nyWmwUQeQZpajlKLvC48gfEooCj
         UmYLR/n/r61sxtQ8j7c8JKeME1z94nt44Jw0zuML5JVBkPDW1qY+b4mIGIA2HnO2e4Yk
         g+hdRUhd1/FkxR+SROSkLv9GsKIT+fyVqJdQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MAPnhxqw8kme2eR+AuVFsaR4pvfjpQV+5x2Qx7ASEQ8=;
        b=TrZ0poW4tLGU2DMoqlld9D/+jxKrS76Tdz14SQNQQXD8k7eAKM/f7VRCAVEeJ9UkfF
         8n+o3RJtPxDtEfR1uWgudiLRb/rJxVhVFAE3ZaleSk5dBPqbA6M8NJvbiFQIxA4dD3Cj
         5gp/LjLlvZ3il+di/nd+wqqPXeTCSBHAjOzr9zI4b1z962tLJ5FGn7PqxFi+aIIqs0r+
         HyxPRm5YCPFywwm+ukQm3DvW4UAS/M2s9gcZzq7MOgLoRuIFagSjhC512mOSEFprKuoo
         8/Q2YhyhLYOEypDIYMtfy7SkMGc82CiRbnDGn/DaWgc1cVEoyuu6EAOrDpzwe06+a4Wv
         DhWQ==
X-Gm-Message-State: APjAAAUu4XAhTKJ84O5y7apOlI+woHJi4W1di1zThjJQrXR4NBoSb+J4
        O2rdQmGJTRHsPi54RDYNQnASv1Xfmws=
X-Google-Smtp-Source: APXvYqzYz34fK8/8X7Y/uPtf4olS4exJNIxPEIlqqQbxRTgl2/MAionDBwX0f6ASez9o9LStg7IXFQ==
X-Received: by 2002:a17:906:63c1:: with SMTP id u1mr19497792ejk.173.1558688058160;
        Fri, 24 May 2019 01:54:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:17 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 12/33] fbdev/omap: sysfs files can't disappear before the device is gone
Date:   Fri, 24 May 2019 10:53:33 +0200
Message-Id: <20190524085354.27411-13-daniel.vetter@ffwll.ch>
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
---
 .../video/fbdev/omap2/omapfb/omapfb-sysfs.c   | 21 +++++++------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
index 8087a009c54f..bd0d20283372 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
@@ -60,8 +60,7 @@ static ssize_t store_rotate_type(struct device *dev,
 	if (rot_type != OMAP_DSS_ROT_DMA && rot_type != OMAP_DSS_ROT_VRFB)
 		return -EINVAL;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 
 	r = 0;
 	if (rot_type == ofbi->rotation_type)
@@ -112,8 +111,7 @@ static ssize_t store_mirror(struct device *dev,
 	if (r)
 		return r;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 
 	ofbi->mirror = mirror;
 
@@ -149,8 +147,7 @@ static ssize_t show_overlays(struct device *dev,
 	ssize_t l = 0;
 	int t;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 	omapfb_lock(fbdev);
 
 	for (t = 0; t < ofbi->num_overlays; t++) {
@@ -208,8 +205,7 @@ static ssize_t store_overlays(struct device *dev, struct device_attribute *attr,
 	if (buf[len - 1] == '\n')
 		len = len - 1;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 	omapfb_lock(fbdev);
 
 	if (len > 0) {
@@ -340,8 +336,7 @@ static ssize_t show_overlays_rotate(struct device *dev,
 	ssize_t l = 0;
 	int t;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 
 	for (t = 0; t < ofbi->num_overlays; t++) {
 		l += snprintf(buf + l, PAGE_SIZE - l, "%s%d",
@@ -369,8 +364,7 @@ static ssize_t store_overlays_rotate(struct device *dev,
 	if (buf[len - 1] == '\n')
 		len = len - 1;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 
 	if (len > 0) {
 		char *p = (char *)buf;
@@ -453,8 +447,7 @@ static ssize_t store_size(struct device *dev, struct device_attribute *attr,
 
 	size = PAGE_ALIGN(size);
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 
 	if (display && display->driver->sync)
 		display->driver->sync(display);
-- 
2.20.1

