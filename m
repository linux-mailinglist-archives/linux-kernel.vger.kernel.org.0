Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474F88DD72
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfHNSrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:47:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41440 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfHNSrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id 196so6932869pfz.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S7G+b/AKW3ZGIOc1Uy5hIvA+emi22Ls1Jq5SWNDVSjE=;
        b=Nc6VyDeLkp4MAbOVFgNDIEDfMdp0ijLVLpHeDJmme19KqUpqX+fHbwurSw04qnZLL6
         JCH6P0UQRYb7SFDeqHuj41hMixuWPJJFZq02BBnWJHH8Mli44qR+3YT9X8om9y3/SV30
         BMgRd0BMrno37eHclBWeNqb0d5vSye8FVTVoMxjuERMYuFKAlBvlkcpgmZ3N1wrXLVfR
         KmuQCmk7+BYlKXZkuwDxhTVdB1fqRdO1uSGNTOhgpJK8TebqflZTQdMHQ7UL/11w6CIv
         xLO2aOYiJXhRDZc5g5fR9CSuHMv3rSOmlK23rcUWy/cIHjKTlcRVmcojG7tgnCq8cnWb
         dLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S7G+b/AKW3ZGIOc1Uy5hIvA+emi22Ls1Jq5SWNDVSjE=;
        b=o4BfegdXhcKgOU2KppbRzjAkFzOXWsy5TQLSugwKHo9RUZKBKval4B0CioRT6yTMN3
         a+GHD0+Pk8gW8JCiaYrqk0HV/CXSQhw/abD8lJLurU0DrujSZkZCuzQ8S4ycVuwpU0du
         9UZSQTZSKJSGhSQTRAWfn/vMQJd+ZFvJ8aWbuQj7MJfouIeOb8DTyPk/KWTqlmUjIYZy
         3VvL5Hf0sWYzk+BI29dCNlvly9bRYd4FToPb5ykvI2j9R/NEEpkfXLwea8E+6/PTxKVq
         Jtmxm73MXlAPn8UKleM59GDvethj+U5+4CByMo/31ZLlEoWX2OonZs5+eZ0Bly8IDBe+
         RbRg==
X-Gm-Message-State: APjAAAV0Gs9D1W3bLXT/b7f+tyr/j4ID4CkGj2hCeffVJOgaAu4c8bfU
        PoU8L7MJS5+ujl/S/oDhhIf8pHrXTb8=
X-Google-Smtp-Source: APXvYqycFrgHQDs7Dh4+d+eohgA56r1m5xdvJK1utw9z5PlXMq5ucRmdbzs2NNCTGHKWQ0/rxxINJw==
X-Received: by 2002:a63:4823:: with SMTP id v35mr517107pga.138.1565808440616;
        Wed, 14 Aug 2019 11:47:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:19 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 09/26] drm: kirin: Dynamically allocate the hw_ctx
Date:   Wed, 14 Aug 2019 18:46:45 +0000
Message-Id: <20190814184702.54275-10-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch modifies the
initialization function to dynamically allocate the ade_hw_ctx
structure previously kept as part of struct ade_data.

This is done so that later we can have the hw_ctx point to
hardware revision specific ctx structures.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 39 ++++++++++++-------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index ee3dc3d0f738..ddcfe0c42d7c 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -72,7 +72,7 @@ struct kirin_plane {
 struct ade_data {
 	struct kirin_crtc crtc;
 	struct kirin_plane planes[ADE_CH_NUM];
-	struct ade_hw_ctx ctx;
+	struct ade_hw_ctx *hw_ctx;
 };
 
 /* ade-format info: */
@@ -951,55 +951,62 @@ static int ade_plane_init(struct drm_device *dev, struct kirin_plane *kplane,
 	return 0;
 }
 
-static int ade_dts_parse(struct platform_device *pdev, struct ade_hw_ctx *ctx)
+static void *ade_hw_ctx_alloc(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
+	struct ade_hw_ctx *ctx = NULL;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		DRM_ERROR("failed to alloc ade_hw_ctx\n");
+		return ERR_PTR(-ENOMEM);
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ctx->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ctx->base)) {
 		DRM_ERROR("failed to remap ade io base\n");
-		return  PTR_ERR(ctx->base);
+		return ERR_PTR(-EIO);
 	}
 
 	ctx->reset = devm_reset_control_get(dev, NULL);
 	if (IS_ERR(ctx->reset))
-		return PTR_ERR(ctx->reset);
+		return ERR_PTR(-ENODEV);
 
 	ctx->noc_regmap =
 		syscon_regmap_lookup_by_phandle(np, "hisilicon,noc-syscon");
 	if (IS_ERR(ctx->noc_regmap)) {
 		DRM_ERROR("failed to get noc regmap\n");
-		return PTR_ERR(ctx->noc_regmap);
+		return ERR_PTR(-ENODEV);
 	}
 
 	ctx->irq = platform_get_irq(pdev, 0);
 	if (ctx->irq < 0) {
 		DRM_ERROR("failed to get irq\n");
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	}
 
 	ctx->ade_core_clk = devm_clk_get(dev, "clk_ade_core");
 	if (IS_ERR(ctx->ade_core_clk)) {
 		DRM_ERROR("failed to parse clk ADE_CORE\n");
-		return PTR_ERR(ctx->ade_core_clk);
+		return ERR_PTR(-ENODEV);
 	}
 
 	ctx->media_noc_clk = devm_clk_get(dev, "clk_codec_jpeg");
 	if (IS_ERR(ctx->media_noc_clk)) {
 		DRM_ERROR("failed to parse clk CODEC_JPEG\n");
-		return PTR_ERR(ctx->media_noc_clk);
+		return ERR_PTR(-ENODEV);
 	}
 
 	ctx->ade_pix_clk = devm_clk_get(dev, "clk_ade_pix");
 	if (IS_ERR(ctx->ade_pix_clk)) {
 		DRM_ERROR("failed to parse clk ADE_PIX\n");
-		return PTR_ERR(ctx->ade_pix_clk);
+		return ERR_PTR(-ENODEV);
 	}
 
-	return 0;
+	return ctx;
 }
 
 static int ade_drm_init(struct platform_device *pdev)
@@ -1020,14 +1027,16 @@ static int ade_drm_init(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, ade);
 
-	ctx = &ade->ctx;
+	ctx = ade_hw_ctx_alloc(pdev);
+	if (IS_ERR(ctx)) {
+		DRM_ERROR("failed to initialize kirin_priv hw ctx\n");
+		return -EINVAL;
+	}
+	ade->hw_ctx = ctx;
+
 	kcrtc = &ade->crtc;
 	kcrtc->hw_ctx = ctx;
 
-	ret = ade_dts_parse(pdev, ctx);
-	if (ret)
-		return ret;
-
 	/*
 	 * plane init
 	 * TODO: Now only support primary plane, overlay planes
-- 
2.17.1

