Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2EE95165
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 01:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfHSXDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 19:03:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36010 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfHSXDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so2039608pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Jq6l1FXpLUKi4y0ukkZjfUNLVxrsbhJoVkVUyhyG+Y=;
        b=KmcmVW5o6nlWHLv5N441j5ii+RJTTMgVMXvLq2wCJoJXBsnG12O8XAireGrEqi1Hq/
         lFRMcr9k0p3AOU6lVpGDyqJfbp68NIA4/9RgeypfClUu2WoJUcW2cH8R4BC8tNsv1IXh
         jPhS+KP/uNOeu5VaEVIyRJiq3mcGqT0PLX5hKUSI3+jHDkkf+vw805WswK7LltHxitRB
         Xa5Z00HvWzZZW9ruhK5uz6MD695mc1zN7+U0PnEkiJDYBmdjJyQs2GOSSfIphnE6oqK6
         dmMFMWXT4BPaOy6bLDV0tPUqTfB8/LSuBO25NVUfEZzmpwSIyFWA+Mhx1ddaDgDE3/1o
         wrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Jq6l1FXpLUKi4y0ukkZjfUNLVxrsbhJoVkVUyhyG+Y=;
        b=dCI4QtVJox+7SzP3MyDSANshAL/1mEkuCecBCeUwiPXIB2UyH6I5HWRDSa02hEyyCc
         l3bDXsQYh17F9s+j2QkeCQr2YOqUiV43s5hhzxzFls99qEBt8HR+W03+0Y6yMRmV9Qky
         Lll7ZZTbdmeOKjdh08BjTA2WUEt08DHnaw61YKJt/hMdD74oWZDLTDCJmShg5YZtUD2l
         rIybfTeJNyk9sZqBM4NMC0MDQpcy2KY/a5wK3UL2R+W7NNTkaNCh1vKIcZA9TN6Co+eJ
         as+cwK/KDGrX4UIqN7es9PiUT0Cfje4/Q+22GJIyWsKVJf7wBnY14RSbpybXrscBpGWx
         oWEA==
X-Gm-Message-State: APjAAAXyYGjKIeUM8G65sg8Kq2tXg5kkTPQBLgBE2BT7Dz2RigVgAmzX
        kus9rA9EUEBDwlRzNAjGvbPKhnQYo3Q=
X-Google-Smtp-Source: APXvYqyssV7Yl36O/h3piEFBGll2PogOEaA6fDHOBNyofENn2V/AyPUh8Qfxll3ZysECErjqMdjx/Q==
X-Received: by 2002:a65:50c8:: with SMTP id s8mr21967673pgp.339.1566255818787;
        Mon, 19 Aug 2019 16:03:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:37 -0700 (PDT)
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
Subject: [PATCH v4 09/25] drm: kirin: Move request irq handle in ade hw ctx alloc
Date:   Mon, 19 Aug 2019 23:03:05 +0000
Message-Id: <20190819230321.56480-10-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch modifies the
initialization routines so the devm_request_irq() function
is called as part of the allocation function.

This will be needed in the future when we will have different
allocation functions to allocate hardware specific hw_ctx
structures, which will setup the vblank irq differently.

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
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index ecb507985fea..8f50115a22d8 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -54,6 +54,8 @@ struct ade_hw_ctx {
 	struct reset_control *reset;
 	bool power_on;
 	int irq;
+
+	struct drm_crtc *crtc;
 };
 
 struct kirin_crtc {
@@ -358,9 +360,9 @@ static void drm_underflow_wq(struct work_struct *work)
 
 static irqreturn_t ade_irq_handler(int irq, void *data)
 {
-	struct kirin_crtc *kcrtc = data;
-	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
-	struct drm_crtc *crtc = &kcrtc->base;
+	struct ade_hw_ctx *ctx = data;
+	struct drm_crtc *crtc = ctx->crtc;
+	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
 	void __iomem *base = ctx->base;
 	u32 status;
 
@@ -951,12 +953,14 @@ static int ade_plane_init(struct drm_device *dev, struct kirin_plane *kplane,
 	return 0;
 }
 
-static void *ade_hw_ctx_alloc(struct platform_device *pdev)
+static void *ade_hw_ctx_alloc(struct platform_device *pdev,
+							  struct drm_crtc *crtc)
 {
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct ade_hw_ctx *ctx = NULL;
+	int ret;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx) {
@@ -1006,6 +1010,14 @@ static void *ade_hw_ctx_alloc(struct platform_device *pdev)
 		return ERR_PTR(-ENODEV);
 	}
 
+	/* vblank irq init */
+	ret = devm_request_irq(dev, ctx->irq, ade_irq_handler,
+			       IRQF_SHARED, dev->driver->name, ctx);
+	if (ret)
+		return ERR_PTR(-EIO);
+
+	ctx->crtc = crtc;
+
 	return ctx;
 }
 
@@ -1027,7 +1039,7 @@ static int ade_drm_init(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, ade);
 
-	ctx = ade_hw_ctx_alloc(pdev);
+	ctx = ade_hw_ctx_alloc(pdev, &ade->crtc.base);
 	if (IS_ERR(ctx)) {
 		DRM_ERROR("failed to initialize kirin_priv hw ctx\n");
 		return -EINVAL;
@@ -1059,15 +1071,8 @@ static int ade_drm_init(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* vblank irq init */
-	ret = devm_request_irq(dev->dev, ctx->irq, ade_irq_handler,
-			       IRQF_SHARED, dev->driver->name, kcrtc);
-
 	INIT_WORK(&kcrtc->display_reset_wq, drm_underflow_wq);
 
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
-- 
2.17.1

