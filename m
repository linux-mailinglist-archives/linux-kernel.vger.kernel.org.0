Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B471353B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 08:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgAIH3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 02:29:08 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:32994 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgAIH3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:29:08 -0500
Received: by mail-pj1-f68.google.com with SMTP id u63so672334pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 23:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eb7+4YTwZPIai1tsUX2MFyulW3TpuQQ3q3lzwkxFRow=;
        b=ej7W8jgc7Qi2towEQUvPZ+HLF2Kev1VG8RzMxUS5owrJ4eTxi+Kf8XMBBX1iBsQitC
         eMtse3kYPa4wXtk2TSBcfd623EMdWEZsk9Axr5HnIgKhJq6g/bsv/a13TdoLdyZ/A65g
         p27LdFxT3wMG4atcUFXFjF4Wx7gKd7Yo4MlIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eb7+4YTwZPIai1tsUX2MFyulW3TpuQQ3q3lzwkxFRow=;
        b=AvqNvvD7LS4pM8cGD7FuvFq4t/c6MsYTh4yNgPLjt1QXmPT2avFDSAkVOhk3NNJM2W
         vwUk8nt9xApckez+tEziYtfTwSy2X3bGSRUZquo+kVy5pe3Fe6RpPleKAYawY2oxiD6r
         q5rQqsvdMfoyvNQGm1g5OqkvwVYyNsdNc19IAC4mR77/ehfyS+K/dmH4TTyTiAzuYExc
         j4w/LS695HYrO7X0gl8esBNM1ji8ymcndRTWTwcT+t5BL/ym1+HqpcBA9f3/eOu6LsB1
         HjHFqOr8ZhYr3cvhmi9fMuVdWKUHQ41uzlMjVEXwdZOosIfF3lpJZiGaepj4HM4xN8or
         II/Q==
X-Gm-Message-State: APjAAAXoRHxyK2u/5vtPd1WXqVUOARARLvrX3/e8tVpmmsJWSvPDUIFi
        TpLgQjuvsKcH5WARewcu2rk6Rw==
X-Google-Smtp-Source: APXvYqxyorOub/tc3oX4xjM6D+1C5Oaw62atk5hhMqHpFC6EWGkz1ky0e/G5dlHrY0x2U1r+CwOnrQ==
X-Received: by 2002:a17:90a:9284:: with SMTP id n4mr3519891pjo.84.1578554947811;
        Wed, 08 Jan 2020 23:29:07 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id p16sm6485810pfq.184.2020.01.08.23.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 23:29:07 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: check for comp->funcs
Date:   Thu,  9 Jan 2020 15:29:00 +0800
Message-Id: <20200109072900.17988-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There might be some comp that doesn't have funcs, eg. hdmi-connector.
Check for comp->funcs otherwise there will be NULL pointer dereference
crash.

Fixes: bd3de8cd782b ("drm/mediatek: Add gamma property according to hardware capability")
Fixes: 7395eab077f9 ("drm/mediatek: Add ctm property support")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
This patch is based on mediatek's drm branch:
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-next-5.6

After
https://patchwork.freedesktop.org/patch/344477/?series=63328&rev=59,
there will also be funcs for hdmi-connector.
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index fb142fcfc353..7b392d6c71cc 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -808,11 +808,13 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 
 		mtk_crtc->ddp_comp[i] = comp;
 
-		if (comp->funcs->ctm_set)
-			has_ctm = true;
+		if (comp->funcs) {
+			if (comp->funcs->ctm_set)
+				has_ctm = true;
 
-		if (comp->funcs->gamma_set)
-			gamma_lut_size = MTK_LUT_SIZE;
+			if (comp->funcs->gamma_set)
+				gamma_lut_size = MTK_LUT_SIZE;
+		}
 	}
 
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
-- 
2.25.0.rc1.283.g88dfdc4193-goog

