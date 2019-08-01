Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4097D404
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 05:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfHADqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 23:46:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39386 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbfHADoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:44:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so31544537pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sbuPXH3VdFgx7EyiYaXP+7dzAxv9Alyn24o+MicDc3g=;
        b=PNeeTf6CHxZtmleLM42uzK+kmr5gR/nqDqqSxXjOubaNccBQf+PsluK79zu0fwrSK+
         YoHl+OQVP6HivC2BNict9dp1CyvV92P83bB6AWsTC3CVograuwWVb4kcT+hlEYaNy6wp
         Yg/bNu/6r4VSnp4z3mHIFpPe/vpNDSgp8eAFPSm7pvHCtjSSaluDT8aj4GyXeKcucv22
         b/HWFxXZrbLewuFpZLwasAJcrr/89VT07i0bFvV/kmgWDbyAlQZpk95AIWRCHzN/U6cg
         Y30/O1WPhktFVgstl5QrhZ1km8wStdhadRCk3VhyfPuerwjrQZ7GLJaeMMhq5xXAv976
         oF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sbuPXH3VdFgx7EyiYaXP+7dzAxv9Alyn24o+MicDc3g=;
        b=IDItsxxDbhK9i98QiE+IJdRi/o227ioTHn8xsfzovabm98M8F1Qq79TQ6b+pvY8Hik
         e1HbZwsevd2rMBJrhG3gqdGBnXjLqwsHQh/z4M8HVk63dpxV/5xIiv7PRF6BzuVsmiIi
         KjehuVoyqfw/oHnhCFl2ofa3DIqHvow4+ZoIYBUflHXH7UNKblaTntcMlZSiY3NOqlyI
         S1WmwKSzc4fRrbR2EJXbP9YkuKueez2JXyvUwefMkhL2gSiP79euUf7Q6ILTNZ9MXGv0
         HrDjWWOnJ8fv7Yz5TGukETf8Dl5SqmsyyaRlc8LkIqECD5rCRJ0IOhSxaIJHR+k22q+1
         kfIw==
X-Gm-Message-State: APjAAAUW5NzX2b8VJTDDrBF15VsOM2+9Im48NBr0OkG/lp5zJmAh9W6v
        tbHOfD763tTpiDOfJQZyVsfNlTyVjAk=
X-Google-Smtp-Source: APXvYqzmcmx5lYagz1N9Qyr8XCKv26OVvf3N44AMBU0z4Wll3KHYXMUEXbb/sT/a1R0ggUgnTgQ42w==
X-Received: by 2002:a17:902:2987:: with SMTP id h7mr29146186plb.37.1564631094884;
        Wed, 31 Jul 2019 20:44:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.44.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:44:54 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 06/26] drm: kirin: Remove out_format from ade_crtc
Date:   Thu,  1 Aug 2019 03:44:19 +0000
Message-Id: <20190801034439.98227-7-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch removes the out_format
field in the struct ade_crtc, which was only ever set to
LDI_OUT_RGB_888.

Thus this patch removes the field and instead directly uses
LDI_OUT_RGB_888.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 756aefd5bcff..73dff21bed6a 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -60,7 +60,6 @@ struct ade_crtc {
 	struct ade_hw_ctx *ctx;
 	struct work_struct display_reset_wq;
 	bool enable;
-	u32 out_format;
 };
 
 struct ade_plane {
@@ -383,11 +382,10 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void ade_display_enable(struct ade_crtc *acrtc)
+static void ade_display_enable(struct ade_hw_ctx *ctx)
 {
-	struct ade_hw_ctx *ctx = acrtc->ctx;
 	void __iomem *base = ctx->base;
-	u32 out_fmt = acrtc->out_format;
+	u32 out_fmt = LDI_OUT_RGB_888;
 
 	/* enable output overlay compositor */
 	writel(ADE_ENABLE, base + ADE_OVLYX_CTL(OUT_OVLY));
@@ -514,7 +512,7 @@ static void ade_crtc_atomic_enable(struct drm_crtc *crtc,
 	}
 
 	ade_set_medianoc_qos(ctx);
-	ade_display_enable(acrtc);
+	ade_display_enable(ctx);
 	ade_dump_regs(ctx->base);
 	drm_crtc_vblank_on(crtc);
 	acrtc->enable = true;
@@ -1024,7 +1022,6 @@ static int ade_drm_init(struct platform_device *pdev)
 	ctx = &ade->ctx;
 	acrtc = &ade->acrtc;
 	acrtc->ctx = ctx;
-	acrtc->out_format = LDI_OUT_RGB_888;
 
 	ret = ade_dts_parse(pdev, ctx);
 	if (ret)
-- 
2.17.1

