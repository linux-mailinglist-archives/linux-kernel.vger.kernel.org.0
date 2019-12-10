Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3721191FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 21:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLJUcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 15:32:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38373 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfLJUb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:31:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so9218081pgm.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A/c6zfJJrS1aJG6jppJ0JzwIndi82aE8y6QtCeoxQ60=;
        b=ZAYfknH6apyPpWisMZWD70J3/OlrrCxL8Gh8/H0vPzjcTwa5tGgqHcYy2JVjItrRlE
         HgLOw5DCSVcvah5RcNdf3oe6e4IQDYBwUv0wWY2Xz/7VSCVA4GyKr+MNpJM+1i1UDZHI
         HKn0BVkKXSCLrzHouzcAJnc88a4mmWfbOlaCUW85oFrpkr/FN2IdJBT8jQ0Tu3pocy9s
         bnmk/+CyaxZ3ialSyXrxMz0v3kBfjQEmU1wnqIiLfqpMKxpJRUkSatqtySwPBwbGlGHC
         nWYkMpwEeAukZIommkVhTY9d18JnyedDOlyr9gOrIY5sTsIJI7qTNv0gCP7sr4vNG0BX
         RLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A/c6zfJJrS1aJG6jppJ0JzwIndi82aE8y6QtCeoxQ60=;
        b=oJogbrht9ywM/dL/1hYzsqh62M9aWPOhFIbUAgoajFQm91HJzv3xe5uY1rLlbVU0e9
         7tTQAeyXfRTzcoYXOJ4tTS5h8m4FAPkHNTbGQXmDtWNhaXOqZno0HZaBTQpErS6iWbK9
         UW4+/4JApSuKZuPfmwS/XC9zBgNr93QyzSQkQmTB5JOA6ZIVCUTj0Vp6d3Z5rgbfj/GC
         MhUcuH/1iz6uJ2tSFBnYT+RHRqpfadBksGaEzwH6fOXz22CizIuQOcAdthxR64tFLItJ
         uqpnyeuYo/vK0V3OgckBx6jAa3B1g0A6hA7BjcjGzZ87mnTMNdsv7kVHhFewlINsStN2
         SQfw==
X-Gm-Message-State: APjAAAVrXomgdmxcrYOKwU7ZLMgRxN4T9GxCFUA8V1wM0WYGIEu0SgPk
        nbonVFPIy06hWXZI0yoOaQg=
X-Google-Smtp-Source: APXvYqxO+Ov5pF1gQ2GamItsgHb3CUFTQBD50B8GhuwcFzTJa7s5DAfFUIqgmWSuNZzVvQYauh6GPg==
X-Received: by 2002:a63:4723:: with SMTP id u35mr25740960pga.194.1576009918720;
        Tue, 10 Dec 2019 12:31:58 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id b22sm1931250pfd.63.2019.12.10.12.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 12:31:58 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        srinivas.kandagatla@linaro.org, vz@mleia.com, khilman@baylibre.com,
        mripard@kernel.org, wens@csie.org,
        andriy.shevchenko@linux.intel.com, mchehab+samsung@kernel.org,
        mans@mansr.com, treding@nvidia.com, suzuki.poulose@arm.com,
        bgolaszewski@baylibre.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/5] nvmem: sunxi_sid: convert to devm_platform_ioremap_resource
Date:   Tue, 10 Dec 2019 20:31:46 +0000
Message-Id: <20191210203149.7115-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210203149.7115-1-tiny.windzz@gmail.com>
References: <20191210203149.7115-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/sunxi_sid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index e26ef1bbf198..c54adf60b155 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -112,7 +112,6 @@ static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
 static int sunxi_sid_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct nvmem_config *nvmem_cfg;
 	struct nvmem_device *nvmem;
 	struct sunxi_sid *sid;
@@ -129,8 +128,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 		return -EINVAL;
 	sid->value_offset = cfg->value_offset;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sid->base = devm_ioremap_resource(dev, res);
+	sid->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sid->base))
 		return PTR_ERR(sid->base);
 
-- 
2.17.1

