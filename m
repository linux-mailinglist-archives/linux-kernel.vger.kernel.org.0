Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00F22578F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 20:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfEUS3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 14:29:39 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52498 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfEUS3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:29:38 -0400
Received: by mail-it1-f196.google.com with SMTP id t184so6751114itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5lq45XSqNE2uFvBFuFvCqHdT2kO9oK+DRuyIon8Em/o=;
        b=qHKNNvOIgeJJ6MWa9m9U9cs1EZ36EM2S8XRIDU7PCmVfkhWLYb2Gy2ndNaFR6BpCjl
         HdJIohQoJYeMcYgR+uBaydZTu/9uhgqbkoOWBXNl2hPdXdzz4tEj/TYaycwjnZWslF3v
         vjIs+OioZN1Nq39eE1zi5NgCJWlQO3M8GGW/Q0EOACe1UFrNXJPumEDaNoh8D8OoHFiN
         izpXChELzvDAmQBpFtcCkdq4/32a9WUJADUy6pMEQgojKioUatKtVvxAO7YN1BQLjNGR
         5+kqwdFWtMgY8cmc4FX2aowuPehkFZL3JDhc/z3TQ5rdE4PK9U31w8dntjd1+oPIeojA
         YlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5lq45XSqNE2uFvBFuFvCqHdT2kO9oK+DRuyIon8Em/o=;
        b=tu1qtbujdRdV84wRjK8ck6Qeh0P+P0GYfqwFmdmkX1dR8gll/AgADaLYxMJVAitfEP
         XGPYOa3ydgwbi6shRVvLtkqviJzmeePI46pbB/5oGhJrrmRA51IB7KWFHsoEG85UqTbv
         Pon8T69YqNGoRgu5XqhXVSk5S/XwdT7bcgToDD+HCv8WBtDmNJPJ8EYHN2itjNt3b5oa
         sgfYGqSlrTux9YQWfa1g7wH0Ev/ZXcUpi6AZNnkJgNEBRAAF9LIzeuX/Yz15dnFzNuT4
         p+TFec2Vb8q2gsPzOcwzmo+YxKXklbcp2iwLHqUNwVk38zgsvFsuGL+/70WBhnoFdMcq
         E97w==
X-Gm-Message-State: APjAAAWzxGsd6z1yooD7jSFHU/xvvL30hSQnTQzp5GMiuWZZd7uRcspW
        c8jzZghHU8wQhvZprvr2sN0=
X-Google-Smtp-Source: APXvYqwp5ZsSzocAb69f4Wj1mmfZ5BRXGnHm2J4cclyR6Jp2LRUTYyQos7tDQCUPyHQNoHChRXI1DQ==
X-Received: by 2002:a24:af1a:: with SMTP id t26mr5523437ite.55.1558463377841;
        Tue, 21 May 2019 11:29:37 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id v134sm1598920ita.16.2019.05.21.11.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 11:29:37 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: fieldbus: arcx-anybus: change custom -> mmio regmap
Date:   Tue, 21 May 2019 14:29:32 -0400
Message-Id: <20190521182932.13502-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arcx-anybus's registers are accessed via a memory-mapped
IO region. A regmap associated with this region is created
using custom reg_read() / reg_write() callbacks.

However, an abstraction which creates a memory-mapped IO
region backed regmap already exists: devm_regmap_init_mmio().

Replace the custom regmap with the existing kernel abstraction.
As a pleasant side-effect, sparse warnings now disappear.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 .../staging/fieldbus/anybuss/arcx-anybus.c    | 44 ++++++-------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
index a167fb68e355..2ecffa42e561 100644
--- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
+++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
@@ -111,49 +111,31 @@ static void export_reset_1(struct device *dev, bool assert)
  * at a time for now.
  */
 
-static int read_reg_bus(void *context, unsigned int reg,
-			unsigned int *val)
-{
-	void __iomem *base = context;
-
-	*val = readb(base + reg);
-	return 0;
-}
-
-static int write_reg_bus(void *context, unsigned int reg,
-			 unsigned int val)
-{
-	void __iomem *base = context;
-
-	writeb(val, base + reg);
-	return 0;
-}
+static const struct regmap_config arcx_regmap_cfg = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = 0x7ff,
+	.use_single_read = true,
+	.use_single_write = true,
+	/*
+	 * single-byte parallel bus accesses are atomic, so don't
+	 * require any synchronization.
+	 */
+	.disable_locking = true,
+};
 
 static struct regmap *create_parallel_regmap(struct platform_device *pdev,
 					     int idx)
 {
-	struct regmap_config regmap_cfg = {
-		.reg_bits = 11,
-		.val_bits = 8,
-		/*
-		 * single-byte parallel bus accesses are atomic, so don't
-		 * require any synchronization.
-		 */
-		.disable_locking = true,
-		.reg_read = read_reg_bus,
-		.reg_write = write_reg_bus,
-	};
 	struct resource *res;
 	void __iomem *base;
 	struct device *dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, idx + 1);
-	if (resource_size(res) < (1 << regmap_cfg.reg_bits))
-		return ERR_PTR(-EINVAL);
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return ERR_CAST(base);
-	return devm_regmap_init(dev, NULL, base, &regmap_cfg);
+	return devm_regmap_init_mmio(dev, base, &arcx_regmap_cfg);
 }
 
 static struct anybuss_host *
-- 
2.17.1

