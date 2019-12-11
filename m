Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0911A611
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 09:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfLKIly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 03:41:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34376 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfLKIlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:41:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so10442185pgf.1;
        Wed, 11 Dec 2019 00:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZX5iKFff+zirWsLntEazM/Rbpxnzs9FOJJrz4dQumzc=;
        b=MHUO4UkuzYpZA3AHVcHQwjQ3qiK8LGCGbQkoMcg3lJKv3tAaP6BMTBg2Ib/qK37dA+
         c5L/hXucjHUBEbtVwOTLq2DQQa2FHXO/lLHOBXi2jFqtXNji3CbRH5LR06+kRCcZKoPb
         GUgDODlN0gIhiXK6mD4bUE3SSJC0TO6NI3a0MtgQO7kizMf3g7EC9QXW6eoQSU5/GdYi
         hMvTTgzME/upt+wwKZFcGXQBixnooyz3ez9ipRTbX5T0OX43dsafvRPYbeKrg3GKvDHO
         hL/fLVDdRs1/KxdVK8O537Rzi0mWV21RQX9bTUJiHBNg9/dj1AGb73qQB6PPnUDTGxIC
         XJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZX5iKFff+zirWsLntEazM/Rbpxnzs9FOJJrz4dQumzc=;
        b=bz+6QP7XDAmwqrj795Ui45oAT4JKofupzvXYe7RXCwR1hA1kgb5ynzccA2004WdKnC
         a6fwfkjaSghW++iMv7S3cz7YFKc34oYqh8KX4UwumoBNoyOSg+AvFvhLj3LEkQ8p8Ccw
         54o5+95HJkiPZi22NVMaCHHNw4IcfX76MRuucfB/hff2i6YdH2+P9dzUspVTbKcYezGF
         4gvX2N0Dizy/MZU0NO5KIV7J2BdImoDeNgXLYPAxGbdhkUr7cusgMmowcQAEgdEirgf7
         CXtvcSWbnax5n+jZ7vvtFj5CvKU16oN68hWNHTYScsoMmMEl9duPq3UdwuTD8tZtASJr
         E9kw==
X-Gm-Message-State: APjAAAXtRe0c4Llnal+GOPpBIMSOI8zAOjjtc3ZWUn/E71IgTvbNIEJV
        I/w0S2B9eISKJqERbTmjkm56xjvN
X-Google-Smtp-Source: APXvYqzO1zopMC7CKJPCqQkkW+wGdyMfN7a2pPRNe/6FbBn7+WTgfsNCmI+0BrTqx7nTq9HCJuuNtQ==
X-Received: by 2002:a62:b402:: with SMTP id h2mr2447717pfn.55.1576053711611;
        Wed, 11 Dec 2019 00:41:51 -0800 (PST)
Received: from localhost.localdomain ([103.51.73.137])
        by smtp.gmail.com with ESMTPSA id e16sm1806233pgk.77.2019.12.11.00.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 00:41:51 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCHv1 3/3] crypto: amlogic: Add new compatible string for amlogic GXBB SoC
Date:   Wed, 11 Dec 2019 08:41:12 +0000
Message-Id: <20191211084112.971-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211084112.971-1-linux.amoon@gmail.com>
References: <20191211084112.971-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string to support the cryto controller
for Amlogic GXBB SoC.

Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index fa05fce1c0de..9859ab023e23 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -311,6 +311,7 @@ static int meson_crypto_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id meson_crypto_of_match_table[] = {
+	{ .compatible = "amlogic,gxbb-crypto", },
 	{ .compatible = "amlogic,gxl-crypto", },
 	{}
 };
-- 
2.24.0

