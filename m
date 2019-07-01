Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560F54ABB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 22:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfFRUZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 16:25:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41734 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfFRUZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:25:18 -0400
Received: by mail-qk1-f196.google.com with SMTP id c11so9461157qkk.8;
        Tue, 18 Jun 2019 13:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROhAZdjghgD9JnUb16HH81QOQPe1FAQVI0H2SO92WTo=;
        b=T+c0IJF40dM9g5jSe1uufJlsNkIzi77noCE9YvdRgmqi9tG0FAu7HaseaKPKDBo7Px
         dGtG/lhDZW/RXHft/KLI/MRiv6iNGVtoC83603houA+TelUn5v9dONjbP2yog7r3RQRY
         UO+rtzTnVqORoFHe+/5OcZv0M27JQCsjyb9uF/c4hJ9QPeTcwOgldnePKMJp9/trrfKt
         mj7sw3q8ZTw3pyi335SXE5Mi2WXQKRcjbxnyxPA5aozGUMrwstTLoq5rDGQl1O25iN8O
         MuQYrnb54tftAJ7Vqt8FzlsrH0t5LZdFrJncc9ZGm3OdCAffyIe5uzaFUZtY9wqRc5SC
         lsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROhAZdjghgD9JnUb16HH81QOQPe1FAQVI0H2SO92WTo=;
        b=Cfm/QmLndFod9p94oxHPkiqcrEBx0inxLQ5BBT13qXbFAm5UorjW92jeBgZ89spfSm
         9RVE5k52dHspukjNVg9X5NroNC2cFdqYH9irjgjdaQfeWt9VpKXhr1ru1xOs1e3sRUwf
         IjZKNrP6Fkwztt2nxjrtemUKeuAbsijeOCfkN6rx0gSQ4bKDNNjjSrOqvTvrQ0IryqJA
         1MIdesfHL8Bh9kuw4fn4o1HnL0Kq38QOXzJV8iVlUFzj/zMnXOGicfRwZa592fLuYAxO
         Lmmrxh3z9PFk7gVOYq5xKXBpRtlYp58gvDEDG+5DzvwAPLsLYB56PEkHUiUKnfTtOgAE
         uiRA==
X-Gm-Message-State: APjAAAU66lvrpkim4bXJu0rwOYYVvpWHKrhXBJkIBt1TiBXzqw2hI6LY
        vpDxEJuvOzC/3GuCQC2Fqr4=
X-Google-Smtp-Source: APXvYqy+2GJNZLbc49UZDN4V+1jnd4V3xuD4H3nTEeXXD9SRUZ0uRvp/Yify3qa7ZM9dr2t9nx041g==
X-Received: by 2002:a05:620a:1387:: with SMTP id k7mr41250832qki.129.1560889517194;
        Tue, 18 Jun 2019 13:25:17 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id a21sm9979064qkg.47.2019.06.18.13.25.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 13:25:16 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jayant Shekhar <jshekhar@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/msm/dpu: Integrate interconnect API in MDSS
Date:   Tue, 18 Jun 2019 13:24:10 -0700
Message-Id: <20190618202425.15259-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618202425.15259-1-robdclark@gmail.com>
References: <20190618202425.15259-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayant Shekhar <jshekhar@codeaurora.org>

The interconnect framework is designed to provide a
standard kernel interface to control the settings of
the interconnects on a SoC.

The interconnect API uses a consumer/provider-based model,
where the providers are the interconnect buses and the
consumers could be various drivers.

MDSS is one of the interconnect consumers which uses the
interconnect APIs to get the path between endpoints and
set its bandwidth requirement for the given interconnected
path.

Changes in v2:
	- Remove error log and unnecessary check (Jordan Crouse)

Changes in v3:
	- Code clean involving variable name change, removal
	  of extra paranthesis and variables (Matthias Kaehlcke)

Changes in v4:
	- Add comments, spacings, tabs, proper port name
	  and icc macro (Georgi Djakov)

Changes in v5:
	- Commit text and parenthesis alignment (Georgi Djakov)

Changes in v6:
	- Change to new icc_set API's (Doug Anderson)

Changes in v7:
	- Fixed a typo

Changes in v8:
	- Handle the of_icc_get() returning NULL case.  In practice
	  icc_set_bw() will gracefully handle the case of a NULL path,
	  but it's probably best for clarity to keep num_paths=0 in
	  this case.

Signed-off-by: Sravanthi Kollukuduru <skolluku@codeaurora.org>
Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 49 ++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index 7316b4ab1b85..b1d0437ac7b6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -4,11 +4,15 @@
  */
 
 #include "dpu_kms.h"
+#include <linux/interconnect.h>
 
 #define to_dpu_mdss(x) container_of(x, struct dpu_mdss, base)
 
 #define HW_INTR_STATUS			0x0010
 
+/* Max BW defined in KBps */
+#define MAX_BW				6800000
+
 struct dpu_irq_controller {
 	unsigned long enabled_mask;
 	struct irq_domain *domain;
@@ -21,8 +25,30 @@ struct dpu_mdss {
 	u32 hwversion;
 	struct dss_module_power mp;
 	struct dpu_irq_controller irq_controller;
+	struct icc_path *path[2];
+	u32 num_paths;
 };
 
+static int dpu_mdss_parse_data_bus_icc_path(struct drm_device *dev,
+						struct dpu_mdss *dpu_mdss)
+{
+	struct icc_path *path0 = of_icc_get(dev->dev, "mdp0-mem");
+	struct icc_path *path1 = of_icc_get(dev->dev, "mdp1-mem");
+
+	if (IS_ERR_OR_NULL(path0))
+		return PTR_ERR_OR_ZERO(path0);
+
+	dpu_mdss->path[0] = path0;
+	dpu_mdss->num_paths = 1;
+
+	if (!IS_ERR_OR_NULL(path1)) {
+		dpu_mdss->path[1] = path1;
+		dpu_mdss->num_paths++;
+	}
+
+	return 0;
+}
+
 static void dpu_mdss_irq(struct irq_desc *desc)
 {
 	struct dpu_mdss *dpu_mdss = irq_desc_get_handler_data(desc);
@@ -134,7 +160,11 @@ static int dpu_mdss_enable(struct msm_mdss *mdss)
 {
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
-	int ret;
+	int ret, i;
+	u64 avg_bw = dpu_mdss->num_paths ? MAX_BW / dpu_mdss->num_paths : 0;
+
+	for (i = 0; i < dpu_mdss->num_paths; i++)
+		icc_set_bw(dpu_mdss->path[i], avg_bw, kBps_to_icc(MAX_BW));
 
 	ret = msm_dss_enable_clk(mp->clk_config, mp->num_clk, true);
 	if (ret)
@@ -147,12 +177,15 @@ static int dpu_mdss_disable(struct msm_mdss *mdss)
 {
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
-	int ret;
+	int ret, i;
 
 	ret = msm_dss_enable_clk(mp->clk_config, mp->num_clk, false);
 	if (ret)
 		DPU_ERROR("clock disable failed, ret:%d\n", ret);
 
+	for (i = 0; i < dpu_mdss->num_paths; i++)
+		icc_set_bw(dpu_mdss->path[i], 0, 0);
+
 	return ret;
 }
 
@@ -163,6 +196,7 @@ static void dpu_mdss_destroy(struct drm_device *dev)
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(priv->mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
 	int irq;
+	int i;
 
 	pm_runtime_suspend(dev->dev);
 	pm_runtime_disable(dev->dev);
@@ -172,6 +206,9 @@ static void dpu_mdss_destroy(struct drm_device *dev)
 	msm_dss_put_clk(mp->clk_config, mp->num_clk);
 	devm_kfree(&pdev->dev, mp->clk_config);
 
+	for (i = 0; i < dpu_mdss->num_paths; i++)
+		icc_put(dpu_mdss->path[i]);
+
 	if (dpu_mdss->mmio)
 		devm_iounmap(&pdev->dev, dpu_mdss->mmio);
 	dpu_mdss->mmio = NULL;
@@ -211,6 +248,10 @@ int dpu_mdss_init(struct drm_device *dev)
 	}
 	dpu_mdss->mmio_len = resource_size(res);
 
+	ret = dpu_mdss_parse_data_bus_icc_path(dev, dpu_mdss);
+	if (ret)
+		return ret;
+
 	mp = &dpu_mdss->mp;
 	ret = msm_dss_parse_clock(pdev, mp);
 	if (ret) {
@@ -232,14 +273,14 @@ int dpu_mdss_init(struct drm_device *dev)
 	irq_set_chained_handler_and_data(irq, dpu_mdss_irq,
 					 dpu_mdss);
 
+	priv->mdss = &dpu_mdss->base;
+
 	pm_runtime_enable(dev->dev);
 
 	pm_runtime_get_sync(dev->dev);
 	dpu_mdss->hwversion = readl_relaxed(dpu_mdss->mmio);
 	pm_runtime_put_sync(dev->dev);
 
-	priv->mdss = &dpu_mdss->base;
-
 	return ret;
 
 irq_error:
-- 
2.20.1

