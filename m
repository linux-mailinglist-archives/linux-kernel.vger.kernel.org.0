Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C876575A87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 00:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfGYWTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 18:19:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43384 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfGYWTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:19:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so16939922pld.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fkQr8KOslonbKlTQUlxHcW0SDWSAq6G6dYt76az0Euo=;
        b=BxTd+Mq8DDlvZfySa7oB1wsL32KYMn9TQUJjJCdGruGdTTKSFUhdFmWcGZAj3MzgjL
         uH/Pywr11SI12qWyTVX/FDB6Vo2FGRH8GmXCO7AFjlOGjvk8TC2ML+TbSoVo2nFXpzEh
         veHGaw9P3N9+zOM86eHdLvF+VdVdnf96Y9z1ebmDS/pXzDO5WCrNREp4uyqhRty3WCpm
         Zn/SEP/gZnCzSs34VF1P2XZKZCH+oKWJGrQE8fmtax3pbeQwzQrEdOgAff/xD2rdotdH
         mNjPx0OGKbl8rgSs1lbMifu+H4kO/m0dbu0Yl606CXgw5/WxwihNO99yjIS2z3tu5DTg
         J9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fkQr8KOslonbKlTQUlxHcW0SDWSAq6G6dYt76az0Euo=;
        b=hmcH6t/QYTtkegYk7++cPUc5heHMjJbtE6vGLTlOz6uPz0jTXUOLn5faeFXZzwfRff
         6nfM2kI1lvzM78X7Mi3qE7uXcJNmkwt1qzuPBbnfQMDXTIZehU9hbJ1O5qrim5I0I4Rn
         6w05CNzx2j8pUNfFM07Zdi0Zb6WaDmbuWZPCsD+VLpaDwtrNi+u7y5ZZCRR/gZI4vWmT
         xtzf0dKlHxUM4rsCpSq9bU3BrW3Of0ZFYPgumH1SsH0VPivPeXtb2lItHdfvA1jvag6l
         q9OpwCqmYmuwkRT+6XklA5FNm4Cz+Mq7J0XoLJstc1tlKbeNvSe16Y7yng4Jtpk6qpT3
         OSeA==
X-Gm-Message-State: APjAAAWBsAPPXh0Z/1oGslXntRA980TtsSXRoV4UXid4rm5a4ASiqsoT
        zu/9IRJdW/Yhb4Zq4A34pl+QYCNNg61rig==
X-Google-Smtp-Source: APXvYqx6htv/ZtSKKbk/Mwym9XT+maC1eUu2ulFPMEKMSIVq4qmwhcmWMXeu4x7QxCQv2D0olD9N0Q==
X-Received: by 2002:a17:902:e282:: with SMTP id cf2mr94194405plb.301.1564093149644;
        Thu, 25 Jul 2019 15:19:09 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id r12sm28050317pgb.73.2019.07.25.15.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:19:09 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 03/15] drivers: thermal: tsens: Add __func__ identifier to debug statements
Date:   Fri, 26 Jul 2019 03:48:38 +0530
Message-Id: <0f2027f458f8b7f17acb024cf47082052f416805.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing the function name when enabling debugging makes logs easier to
read.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 8 ++++----
 drivers/thermal/qcom/tsens.c        | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c037bdf92c66..7437bfe196e5 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -42,8 +42,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 
 	for (i = 0; i < priv->num_sensors; i++) {
 		dev_dbg(priv->dev,
-			"sensor%d - data_point1:%#x data_point2:%#x\n",
-			i, p1[i], p2[i]);
+			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
+			__func__, i, p1[i], p2[i]);
 
 		priv->sensor[i].slope = SLOPE_DEFAULT;
 		if (mode == TWO_PT_CALIB) {
@@ -60,7 +60,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
 				(CAL_DEGC_PT1 *
 				priv->sensor[i].slope);
-		dev_dbg(priv->dev, "offset:%d\n", priv->sensor[i].offset);
+		dev_dbg(priv->dev, "%s: offset:%d\n", __func__, priv->sensor[i].offset);
 	}
 }
 
@@ -209,7 +209,7 @@ int __init init_common(struct tsens_priv *priv)
 	if (ret)
 		goto err_put_device;
 	if (!enabled) {
-		dev_err(dev, "tsens device is not enabled\n");
+		dev_err(dev, "%s: device not enabled\n", __func__);
 		ret = -ENODEV;
 		goto err_put_device;
 	}
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 542a7f8c3d96..06c6bbd69a1a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -127,7 +127,7 @@ static int tsens_probe(struct platform_device *pdev)
 		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
 
 	if (num_sensors <= 0) {
-		dev_err(dev, "invalid number of sensors\n");
+		dev_err(dev, "%s: invalid number of sensors\n", __func__);
 		return -EINVAL;
 	}
 
@@ -156,7 +156,7 @@ static int tsens_probe(struct platform_device *pdev)
 
 	ret = priv->ops->init(priv);
 	if (ret < 0) {
-		dev_err(dev, "tsens init failed\n");
+		dev_err(dev, "%s: init failed\n", __func__);
 		return ret;
 	}
 
@@ -164,7 +164,7 @@ static int tsens_probe(struct platform_device *pdev)
 		ret = priv->ops->calibrate(priv);
 		if (ret < 0) {
 			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "tsens calibration failed\n");
+				dev_err(dev, "%s: calibration failed\n", __func__);
 			return ret;
 		}
 	}
-- 
2.17.1

