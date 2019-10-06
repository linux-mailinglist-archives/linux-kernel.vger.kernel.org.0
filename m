Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A51ECCEC2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 07:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfJFFjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 01:39:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36198 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfJFFjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 01:39:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id j11so5183092plk.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 22:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Td3fuKxaZXUNRUL4lHP0H/YwhwCuhVUYKfFBUtY39ao=;
        b=Xlf4SwJ/UUpArrEBuv2q1lJ6fn6ngckU4dU6VQwgyIknmlyuLoTxir6vza5SnMdgya
         6L3q9t4Y0CDGCnaDx+MkM+maYPVTN7HPJbEnVvbR9fhHKt1BlvRx7LiPyNiEkaw8rug4
         Y63rUInxA96AfaYRE6S0bdkNTKBB8hl6T3DVsPbZK/8zPI4+ZSQ8swdRLTteCmBXinvH
         qg11ObRctXssuyhNu5+uu69TBXT5GC+PyUqG7zonqlwuRnKhFgCVst+U0Z8YV/lVltAc
         6NLx5hoLgpeHjB4Q9ZdqLaCRuDSF9MTjX/m6ylu7cm20OsaHRyN2aCf/Q8IsO/0LTNt3
         DayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Td3fuKxaZXUNRUL4lHP0H/YwhwCuhVUYKfFBUtY39ao=;
        b=n1blnxgZ8YybDCMVdDZckruJRKlGv8Ri3AKzBgZIMcOLa3XANB5SzRtUgZWq+00Bfs
         9WsoxlRFFGtbrGmdODCqgcqCn6oFtGI1FuitlIUEZtSUjeg+JDXS6ukRTSaW8AOAdZ1Y
         d3jEx26ilIh0yXmgnyvWz1SYQyi7suiuecU074Iz2AurWYPbfXD0KJjIDrZ6s2j/QD3y
         /m4o49Vy/e2Faq5oTLlheXSVvrWWMupomllmh7Zx1Ho2Asrr4a+bSZSd+Soz2cEt0WVm
         TKl1nHKc+XD2zVtSQDDLolMVsX6VObR9YnqGWH6+jJHy0m1LBxQqAReuV1XxGGRjDy3P
         qnjw==
X-Gm-Message-State: APjAAAXPBXBg4UnuyBwmOvwUzS8GUw4s23a/+HDxZK+13JyilgUh4wWt
        6LmfBaODeyzyL0cNjbjgGl6PQg==
X-Google-Smtp-Source: APXvYqzRvjgidKEx2Zc/pDIDjgvUy2QRhxqUBolQw4ccAIVPxh1mAjK2Mj0uZ4jzUmj3UKAs11rnew==
X-Received: by 2002:a17:902:7244:: with SMTP id c4mr7596599pll.178.1570340379584;
        Sat, 05 Oct 2019 22:39:39 -0700 (PDT)
Received: from debian-brgl.local (50-255-47-209-static.hfc.comcastbusiness.net. [50.255.47.209])
        by smtp.gmail.com with ESMTPSA id q30sm10019320pja.18.2019.10.05.22.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 22:39:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 2/8] lib: devres: prepare devm_ioremap_resource() for more variants
Date:   Sun,  6 Oct 2019 07:39:10 +0200
Message-Id: <20191006053916.8849-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006053916.8849-1-brgl@bgdev.pl>
References: <20191006053916.8849-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to add the write-combined variant of devm_ioremap_resource().
Let's first implement __devm_ioremap_resource() which takes
an additional argument type. The types are the same as for
__devm_ioremap(). The existing devm_ioremap_resource() now simply
calls __devm_ioremap_resource() with regular DEVM_IOREMAP type.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 lib/devres.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index 6a0e9bd6524a..a14c727128c1 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -114,25 +114,9 @@ void devm_iounmap(struct device *dev, void __iomem *addr)
 }
 EXPORT_SYMBOL(devm_iounmap);
 
-/**
- * devm_ioremap_resource() - check, request region, and ioremap resource
- * @dev: generic device to handle the resource for
- * @res: resource to be handled
- *
- * Checks that a resource is a valid memory region, requests the memory
- * region and ioremaps it. All operations are managed and will be undone
- * on driver detach.
- *
- * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
- * on failure. Usage example:
- *
- *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
- *	base = devm_ioremap_resource(&pdev->dev, res);
- *	if (IS_ERR(base))
- *		return PTR_ERR(base);
- */
-void __iomem *devm_ioremap_resource(struct device *dev,
-				    const struct resource *res)
+static void __iomem *
+__devm_ioremap_resource(struct device *dev, const struct resource *res,
+			enum devm_ioremap_type type)
 {
 	resource_size_t size;
 	void __iomem *dest_ptr;
@@ -151,7 +135,7 @@ void __iomem *devm_ioremap_resource(struct device *dev,
 		return IOMEM_ERR_PTR(-EBUSY);
 	}
 
-	dest_ptr = devm_ioremap(dev, res->start, size);
+	dest_ptr = __devm_ioremap(dev, res->start, size, type);
 	if (!dest_ptr) {
 		dev_err(dev, "ioremap failed for resource %pR\n", res);
 		devm_release_mem_region(dev, res->start, size);
@@ -160,6 +144,29 @@ void __iomem *devm_ioremap_resource(struct device *dev,
 
 	return dest_ptr;
 }
+
+/**
+ * devm_ioremap_resource() - check, request region, and ioremap resource
+ * @dev: generic device to handle the resource for
+ * @res: resource to be handled
+ *
+ * Checks that a resource is a valid memory region, requests the memory
+ * region and ioremaps it. All operations are managed and will be undone
+ * on driver detach.
+ *
+ * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure. Usage example:
+ *
+ *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+ *	base = devm_ioremap_resource(&pdev->dev, res);
+ *	if (IS_ERR(base))
+ *		return PTR_ERR(base);
+ */
+void __iomem *devm_ioremap_resource(struct device *dev,
+				    const struct resource *res)
+{
+	return __devm_ioremap_resource(dev, res, DEVM_IOREMAP);
+}
 EXPORT_SYMBOL(devm_ioremap_resource);
 
 /*
-- 
2.23.0

