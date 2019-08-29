Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1AABA2780
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 22:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfH2UAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 16:00:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39964 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfH2UAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:00:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id h3so2080447pls.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LnwOSHW+qkIfwX+CEo6pre2vAtIHSJHM7Ipb0uTKcN8=;
        b=ljvhUTB5kgie6mZn/Katfok8X2WrFwgXFmGKAsJBCEExxJK+Nxf6/5JnDHhk1LxGzy
         GYRAppVUeZ1sd1GoWZIlw7jgdNHty21ipU5Xwbsjv2pDu76zTUuu2M0TYKjBIGiG+5/U
         z01+UGUU35QOWpFRzt7fPcfbQ99aFBb2fmxT0/oIwQsg9/ldDduJhzRqeDTeL/2cT+fn
         xZEkAhbQh16HdO3N3dLit2heuBIRhD2aWB6bocU4JidBTKhPZUvGLVHHMbcSP5Om8Rkn
         fjF4IfC7pe9zuVYT61BgDPYNoG1OUc1oLDYMoO1xaeTde3LKzueqjrs2vOyE7CXBh8Pc
         jvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LnwOSHW+qkIfwX+CEo6pre2vAtIHSJHM7Ipb0uTKcN8=;
        b=joRug1EdC34Qk69nMtL1a3jtw1mgJspAXsmXppBagAssm8/ZHtcZ2gxr4Z3i7q3RYv
         q9HncXAGo8/MYjcYV0XUl+ndXVLjZCI072owmUzX9rimpPNqcaRYqTe6yFHpABXxNPt8
         PjgvMWKoaVmb18d/2pq6qg0J/7mp2EhaMyTeVsCVFpfyo2dLRtB8kLwJ3cE5WRaE96u4
         NcI/6P7PM1xKe4BSU1py9LHlDC11+hZh4KX4TAS5fOhubLCTcz6u79ZvhyXdo6x+sv14
         HYbS8GZ6f9GtvUGOIykGUbAijWlgHXRVmfCuCX/stZxCgB47adGXWY36e04OYwVA6VNl
         biIA==
X-Gm-Message-State: APjAAAVb82oCQTA1dAxgrDrbp4McdattkPqu1CpuuzQDRdq0ybimRW2v
        1SbLKFWGmOu6NbNtcvJk/mOPCw==
X-Google-Smtp-Source: APXvYqwdxPRjNZXc7J371kYMqpuaaLwSfZc+tGFJrILbQTyvwMq61GQBgGE76g8xmKy3HX0ZAhYEFg==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7mr12015218plp.245.1567108808730;
        Thu, 29 Aug 2019 13:00:08 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u7sm3053766pgr.94.2019.08.29.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 13:00:08 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie, jsarha@ti.com,
        tomi.valkeinen@ti.com, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [BACKPORT 4.19.y 3/3] drm/tilcdc: Register cpufreq notifier after we have initialized crtc
Date:   Thu, 29 Aug 2019 14:00:01 -0600
Message-Id: <20190829200001.17092-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190829200001.17092-1-mathieu.poirier@linaro.org>
References: <20190829200001.17092-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jyri Sarha <jsarha@ti.com>

commit 432973fd3a20102840d5f7e61af9f1a03c217a4c upstream

Register cpufreq notifier after we have initialized the crtc and
unregister it before we remove the ctrc. Receiving a cpufreq notify
without crtc causes a crash.

Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 34 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 0fb300d41a09..e1868776da25 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -184,6 +184,12 @@ static void tilcdc_fini(struct drm_device *dev)
 {
 	struct tilcdc_drm_private *priv = dev->dev_private;
 
+#ifdef CONFIG_CPU_FREQ
+	if (priv->freq_transition.notifier_call)
+		cpufreq_unregister_notifier(&priv->freq_transition,
+					    CPUFREQ_TRANSITION_NOTIFIER);
+#endif
+
 	if (priv->crtc)
 		tilcdc_crtc_shutdown(priv->crtc);
 
@@ -198,12 +204,6 @@ static void tilcdc_fini(struct drm_device *dev)
 	drm_mode_config_cleanup(dev);
 	tilcdc_remove_external_device(dev);
 
-#ifdef CONFIG_CPU_FREQ
-	if (priv->freq_transition.notifier_call)
-		cpufreq_unregister_notifier(&priv->freq_transition,
-					    CPUFREQ_TRANSITION_NOTIFIER);
-#endif
-
 	if (priv->clk)
 		clk_put(priv->clk);
 
@@ -274,17 +274,6 @@ static int tilcdc_init(struct drm_driver *ddrv, struct device *dev)
 		goto init_failed;
 	}
 
-#ifdef CONFIG_CPU_FREQ
-	priv->freq_transition.notifier_call = cpufreq_transition;
-	ret = cpufreq_register_notifier(&priv->freq_transition,
-			CPUFREQ_TRANSITION_NOTIFIER);
-	if (ret) {
-		dev_err(dev, "failed to register cpufreq notifier\n");
-		priv->freq_transition.notifier_call = NULL;
-		goto init_failed;
-	}
-#endif
-
 	if (of_property_read_u32(node, "max-bandwidth", &priv->max_bandwidth))
 		priv->max_bandwidth = TILCDC_DEFAULT_MAX_BANDWIDTH;
 
@@ -361,6 +350,17 @@ static int tilcdc_init(struct drm_driver *ddrv, struct device *dev)
 	}
 	modeset_init(ddev);
 
+#ifdef CONFIG_CPU_FREQ
+	priv->freq_transition.notifier_call = cpufreq_transition;
+	ret = cpufreq_register_notifier(&priv->freq_transition,
+			CPUFREQ_TRANSITION_NOTIFIER);
+	if (ret) {
+		dev_err(dev, "failed to register cpufreq notifier\n");
+		priv->freq_transition.notifier_call = NULL;
+		goto init_failed;
+	}
+#endif
+
 	if (priv->is_componentized) {
 		ret = component_bind_all(dev, ddev);
 		if (ret < 0)
-- 
2.17.1

