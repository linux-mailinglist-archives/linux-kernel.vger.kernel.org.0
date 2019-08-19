Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B3295178
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 01:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfHSXEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 19:04:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36013 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbfHSXDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so2039671pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vrHDYLfRzW5R44jwvLTf4dm77QaWrtDgYKn2YYHQH74=;
        b=hSGKNYO20P3K6l7pCXNj+pRg4nPwis1eXt5blYJpY4Pd13rBJxlfZTBY5XeZNveOE+
         UcI48q7qMofFEOXAAOZoMTBUVL1fA+w7wfU1eqWtUKUJZBNCrcd7Zv3xO7a0fjAeQM8o
         lWnLzpArAfeKekGoWf6srmyDA6wJ6rA05TyFCfTHQuJIrMrmDyQNkni6WiDiwle2rpgy
         sulinAi95dgsly+ty24sKVkF/i+cg35Eg3UDSxUZJ/C7DidqUt45YE07fFPYvTAq3WGM
         B5TS8kZZ/VIHarvElRbNRm2cCB5zoDGm64umt2zRUhhveN+LWBnJbfrbBNYl5vBj3Ccr
         NbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vrHDYLfRzW5R44jwvLTf4dm77QaWrtDgYKn2YYHQH74=;
        b=AQibftJj3FJXyvvhi9LjAD5OMZkdrQ7bqyD3oFcDr3CkNNpFVGYPgXYuCuHtR5U4MS
         v0L4GUyk7WxGdVMhEgSFkzoXTw2fAuv0LrIYGJjd8xdz9GXaKOeCuDltbJ4cUZujdVNT
         qTd+ZOjdsZth3+lJ3f/xrDQhhVAAQD2nu0sWg6w5Gx+69VTENOeuwHT/nNDPw9xTa+PF
         K80ZwumkkaEaCZhMsjP4tlJknnBuvX9eVH7x7DU7Q28RykS+G+47wmo7WET7Nivgc7Cd
         in785MQW5u2HK+Q5LHuy7GIN1coE1oPovch41TSxX6D7MVK4GGBL8Kz4OexapkqJDyJq
         pfUw==
X-Gm-Message-State: APjAAAXOLKAkRA4S/Mz29+fYB16wlqEWkhPscCGV05o0Zp26AD7F91nA
        lUTIk1sWFPQsouu28I30cyc2a059KZM=
X-Google-Smtp-Source: APXvYqxzysdkjNcO7urFjZ0W6hmbyN9GcPsmBs4XhQGHnyTxroGdpknUNGowoOf2aKbvYT+2chRN4Q==
X-Received: by 2002:a17:90a:d58c:: with SMTP id v12mr22893267pju.7.1566255822491;
        Mon, 19 Aug 2019 16:03:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:41 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v4 11/25] drm: kirin: Move kirin_crtc, kirin_plane, kirin_format to kirin_drm_drv.h
Date:   Mon, 19 Aug 2019 23:03:07 +0000
Message-Id: <20190819230321.56480-12-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves some shared
structures and helpers to the common kirin_drm_drv.h

These structures will later used by both kirin620 and
future kirin960 driver

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 27 ++-----------------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   | 24 +++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 191ee59f68b6..d3088d374f8b 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -38,12 +38,6 @@
 #define OUT_OVLY	ADE_OVLY2 /* output overlay compositor */
 #define ADE_DEBUG	1
 
-#define to_kirin_crtc(crtc) \
-	container_of(crtc, struct kirin_crtc, base)
-
-#define to_kirin_plane(plane) \
-	container_of(plane, struct kirin_plane, base)
-
 
 struct ade_hw_ctx {
 	void __iomem  *base;
@@ -59,18 +53,6 @@ struct ade_hw_ctx {
 	struct drm_crtc *crtc;
 };
 
-struct kirin_crtc {
-	struct drm_crtc base;
-	void *hw_ctx;
-	bool enable;
-};
-
-struct kirin_plane {
-	struct drm_plane base;
-	void *hw_ctx;
-	u32 ch;
-};
-
 struct ade_data {
 	struct kirin_crtc crtc;
 	struct kirin_plane planes[ADE_CH_NUM];
@@ -78,12 +60,7 @@ struct ade_data {
 };
 
 /* ade-format info: */
-struct ade_format {
-	u32 pixel_format;
-	enum ade_fb_format ade_format;
-};
-
-static const struct ade_format ade_formats[] = {
+static const struct kirin_format ade_formats[] = {
 	/* 16bpp RGB: */
 	{ DRM_FORMAT_RGB565, ADE_RGB_565 },
 	{ DRM_FORMAT_BGR565, ADE_BGR_565 },
@@ -127,7 +104,7 @@ static u32 ade_get_format(u32 pixel_format)
 
 	for (i = 0; i < ARRAY_SIZE(ade_formats); i++)
 		if (ade_formats[i].pixel_format == pixel_format)
-			return ade_formats[i].ade_format;
+			return ade_formats[i].hw_format;
 
 	/* not found */
 	DRM_ERROR("Not found pixel format!!fourcc_format= %d\n",
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 22d1291668cd..d47cbb427979 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -9,6 +9,30 @@
 
 #define MAX_CRTC	2
 
+#define to_kirin_crtc(crtc) \
+	container_of(crtc, struct kirin_crtc, base)
+
+#define to_kirin_plane(plane) \
+	container_of(plane, struct kirin_plane, base)
+
+/* kirin-format translate table */
+struct kirin_format {
+	u32 pixel_format;
+	u32 hw_format;
+};
+
+struct kirin_crtc {
+	struct drm_crtc base;
+	void *hw_ctx;
+	bool enable;
+};
+
+struct kirin_plane {
+	struct drm_plane base;
+	void *hw_ctx;
+	u32 ch;
+};
+
 /* display controller init/cleanup ops */
 struct kirin_dc_ops {
 	int (*init)(struct platform_device *pdev);
-- 
2.17.1

