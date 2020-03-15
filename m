Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82350185D53
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgCOOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 10:05:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41658 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgCOOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:05:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so6621776plr.8;
        Sun, 15 Mar 2020 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EzgbSC/nGvVa96Duy+/KhRex8dE6o4NHlTZlUHCa4rY=;
        b=gulO75FjV4z6JRItEK9qPFrimo69n/GQyqRPuhNwtevsD65uyHB9rKzM3+58znKVCb
         aQpRrm8bEmOdqAhh+KsK6rLCvfABRHpK/l5RrbFxCARahuKT+Rpc8LxrvPmLIrzWq1Wa
         sIYbJrLafUYEx2eUOvz8AdU+DX/gDOPhvdKVhQG/WfqCPpxNJJD4MS8at23+WmvzGR8B
         8QMsLbcMYRA4mCNb42sA1Q6Isbpz3yp0eTM3GjDjlpexVvwJqZqh56I2CAIcRo3pyeM8
         l88vl2TqNTmlaGQS58Jyienucrzl+upoLZ10BEEHFWaxwPv6wHCmf/J65yDZhTsJbiMZ
         YwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EzgbSC/nGvVa96Duy+/KhRex8dE6o4NHlTZlUHCa4rY=;
        b=cKfRt+apOO0Le8ctCB+k8VGOpH8h8JjnXmZZsHHfmgZFZL6yzTPsCaK0R3jKM/PLld
         eCozoubDnrBpltjCWfOSgdLcP03HhvgJNG4pkkPeibBQOidKdVTzTRl42UtWQH9UOKe/
         nicWSdbFAlYmajeOnGnGwBr0p5NCGTS0Nxz2ST5egbDz2Q022+VtZC9n8MmJjDZTgMYi
         QPpARa/C8Nze+dMt+YDE0JwRzZtfsmrll9JvfsbyDt/9GkxqXcwLxa/2/zJ9azRyhf2s
         R9mimLmLPJQTbJNfwbsR+omWi1lmGl08FyudMqNjnEaYeKy0sQrxXk5hQHeXjZGIhutl
         0GoA==
X-Gm-Message-State: ANhLgQ1ViAcn6nCoiCKG3YskFaVMWnJGqhcjw8dbTkt8AZCkFgpFJbw/
        3Gm2yoQ0GC5wB9isPqjGt9g=
X-Google-Smtp-Source: ADFU+vtkc1ElQE1NybgKcPOn4m30/m2Qbklh6owCTB582c2/6WOLouw43oNYMaEyqpbI1g2Ld34Opg==
X-Received: by 2002:a17:902:a518:: with SMTP id s24mr22480609plq.157.1584281137842;
        Sun, 15 Mar 2020 07:05:37 -0700 (PDT)
Received: from localhost (216.24.188.11.16clouds.com. [216.24.188.11])
        by smtp.gmail.com with ESMTPSA id g5sm13148388pfo.192.2020.03.15.07.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 07:05:37 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        jeffrey.t.kirsher@intel.com, hdegoede@redhat.com,
        treding@nvidia.com, tglx@linutronix.de, tomas.winkler@intel.com,
        suzuki.poulose@arm.com, sergei.shtylyov@cogentembedded.com,
        geert@linux-m68k.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v3 1/5] drivers: provide devm_platform_get_and_ioremap_resource()
Date:   Sun, 15 Mar 2020 22:05:21 +0800
Message-Id: <20200315140525.21780-2-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200315140525.21780-1-zhengdejin5@gmail.com>
References: <20200315140525.21780-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit "drivers: provide devm_platform_ioremap_resource()",
it was wrap platform_get_resource() and devm_ioremap_resource() as
single helper devm_platform_ioremap_resource(). but now, many drivers
still used platform_get_resource() and devm_ioremap_resource()
together in the kernel tree. The reason can not be replaced is they
still need use the resource variables obtained by platform_get_resource().
so provide this helper.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v2 -> v3:
	- rename the function to
	  devm_platform_get_and_ioremap_resource() by Sergei's suggestion.
	- make the last parameter res as optional by Geert's suggestion.

v1 -> v2:
	- No change.

 drivers/base/platform.c         | 22 ++++++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7fa654f1288b..9f6a78f79235 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -62,6 +62,28 @@ struct resource *platform_get_resource(struct platform_device *dev,
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
 #ifdef CONFIG_HAS_IOMEM
+/**
+ * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
+ *					    platform device and get resource
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource management
+ * @index: resource index
+ * @res: get the resource
+ */
+void __iomem *
+devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
+				unsigned int index, struct resource **res)
+{
+	struct resource *r;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	if (res)
+		*res = r;
+	return devm_ioremap_resource(&pdev->dev, r);
+}
+EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource);
+
 /**
  * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
  *				    device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 8e83c6ff140d..8aa6b448450f 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -55,6 +55,9 @@ extern struct device *
 platform_find_device_by_driver(struct device *start,
 			       const struct device_driver *drv);
 extern void __iomem *
+devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
+				unsigned int index, struct resource **res);
+extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
 extern void __iomem *
-- 
2.25.0

