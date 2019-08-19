Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E42395173
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 01:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfHSXEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 19:04:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41194 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbfHSXEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:04:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so2073390pfz.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iSQb8FgaCNaXcBii2QVIuOGP6f5h31ib3HlDrpYCUmw=;
        b=QrkgArX0B3Kj0xDaromy4qzCPe+ESlH2vc6lYT0aQG/b5Ry0WwjZjdbsZ+2UZG2x+K
         6y5q7KG4OqXaWU1fzhH3MC1bC4X7EXx9k4+4mg/KUqSCNUTajD7+ZwpcNxAdMgemgQG6
         HrZbhzgqJB0FXQnl3fgaYls9yl6fklO2aJeoMQw0Tb3DHoY7kIpqffUNL9lb8+RCYFqI
         KeGpBenrN2lyhF1tm7gOgiQiX5gZhfBXmgs6VhkwFK8JsSIdbxyAMuk79k2xQs0KAnsU
         2zH6Be8BqnNrPIhjfkK1rzSCdno/V0Snr8CURxDs/TjYeRL4h1JFn9KIsikc3nCB8HFo
         CIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iSQb8FgaCNaXcBii2QVIuOGP6f5h31ib3HlDrpYCUmw=;
        b=Gli8pAvU8RPuM88Krw680DHy/QIjWX5F/L9usLINIsJQbi7qYMlA23Sf9kXDyDzIRF
         +fLdGEZZcjBe/Fufcn8cStQMFOFTSRzjRzlI+arAb/o2vpSq4B7zzNf7g+Zq3ZGvXb4I
         RJdBdd2NTsz1xcdq6etXeDZ2LObeMshAg49Jp7ZhwlBty2TEZ4wkZYPbSJx6IbVkCjVX
         de2C0/qdgyTd0o1KIv26kZamunNEFc41RYNzgpoQDtfplQ9t6rU80h+gvg9aQMzTNv89
         YQpFyuQHzj85jj0spbHZk75Ae5w/DmkyGNK6XUhJ7OoVflw3wZwrxFhpfDFT2si9nhlD
         zGKg==
X-Gm-Message-State: APjAAAVIEjYrqORWgq6cN+/PM7cUT7jnWxBwvKLkqOLNAMum9kzzkYZY
        jA3gy7wSj0yhDzkglcemlbV7fILFxyY=
X-Google-Smtp-Source: APXvYqz0V0XOXIPeAq3o2S1YQkSrU0pipkFmKcruZgN4S03QshB4Zhd+fABk5Xoj6Ks7kaSVwW7BpA==
X-Received: by 2002:a63:505a:: with SMTP id q26mr21501966pgl.18.1566255839103;
        Mon, 19 Aug 2019 16:03:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:58 -0700 (PDT)
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
Subject: [PATCH v4 22/25] drm: kirin: Make driver_data variable non-global
Date:   Mon, 19 Aug 2019 23:03:18 +0000
Message-Id: <20190819230321.56480-23-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch changes the driver_data
value to not be a global variable. Instead the driver_data value
is accessed via the of_device_get_match_data() when needed.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 43 +++++++++++--------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 55c8dbb68be0..84215f9dc985 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -29,18 +29,9 @@
 
 #include "kirin_drm_drv.h"
 
-static struct kirin_drm_data *driver_data;
 
-static int kirin_drm_kms_cleanup(struct drm_device *dev)
-{
-	drm_kms_helper_poll_fini(dev);
-	driver_data->cleanup(to_platform_device(dev->dev));
-	drm_mode_config_cleanup(dev);
-
-	return 0;
-}
-
-static int kirin_drm_kms_init(struct drm_device *dev)
+static int kirin_drm_kms_init(struct drm_device *dev,
+				const struct kirin_drm_data *driver_data)
 {
 	int ret;
 
@@ -96,6 +87,21 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static int kirin_drm_kms_cleanup(struct drm_device *dev)
+{
+	const struct kirin_drm_data *driver_data;
+
+	drm_kms_helper_poll_fini(dev);
+
+	driver_data = of_device_get_match_data(dev->dev);
+	if (driver_data->cleanup)
+		driver_data->cleanup(to_platform_device(dev->dev));
+
+	drm_mode_config_cleanup(dev);
+
+	return 0;
+}
+
 static int kirin_drm_connectors_register(struct drm_device *dev)
 {
 	struct drm_connector *connector;
@@ -132,15 +138,21 @@ static int kirin_drm_connectors_register(struct drm_device *dev)
 
 static int kirin_drm_bind(struct device *dev)
 {
+	struct kirin_drm_data *driver_data;
 	struct drm_device *drm_dev;
 	int ret;
 
+	driver_data = (struct kirin_drm_data *)of_device_get_match_data(dev);
+	if (driver_data == NULL)
+		return -EINVAL;
+
 	drm_dev = drm_dev_alloc(driver_data->driver, dev);
 	if (IS_ERR(drm_dev))
 		return PTR_ERR(drm_dev);
 	dev_set_drvdata(dev, drm_dev);
 
-	ret = kirin_drm_kms_init(drm_dev);
+	/* display controller init */
+	ret = kirin_drm_kms_init(drm_dev, driver_data);
 	if (ret)
 		goto err_drm_dev_put;
 
@@ -190,12 +202,6 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	struct component_match *match = NULL;
 	struct device_node *remote;
 
-	driver_data = (struct kirin_drm_data *)of_device_get_match_data(dev);
-	if (!driver_data) {
-		DRM_ERROR("failed to get dt id data\n");
-		return -EINVAL;
-	}
-
 	remote = of_graph_get_remote_node(np, 0, 0);
 	if (!remote)
 		return -ENODEV;
@@ -209,7 +215,6 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 static int kirin_drm_platform_remove(struct platform_device *pdev)
 {
 	component_master_del(&pdev->dev, &kirin_drm_ops);
-	driver_data = NULL;
 	return 0;
 }
 
-- 
2.17.1

