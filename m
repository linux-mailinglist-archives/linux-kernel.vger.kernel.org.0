Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA29111021D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 17:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfLCQYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 11:24:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44126 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:24:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id az9so1875482plb.11;
        Tue, 03 Dec 2019 08:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ye7dpKDp7c5nhDFHYrYwoNCltp5b0VIIhD0V9njG2jg=;
        b=p2xayIVDR8VXD4oMykwZwyNU0XuQ/9vir9vzE4D8504bMMkWh/l1EChrdFGXcs/Sxd
         yeJFFA13DMP5/p5BTEILcVR+zI02rmB49GjPBBIoRj9/eyLec8WDR4HABZAuiSp+nBrL
         bu+tnhfMJV1s3dUMaLF9dloe+uMVb3mdWwnfSTdji2DR8WFBjZIqAvNa7eMTa1XYOqPm
         Bipt37yGSvzoocJNXGFWaxWahd0H4C1K3M7OFNDnOYqjZ5WSGMj5AQdKUPhzCB8tcGmO
         1lLBFMcDjPC/CiTRTFi2vV1HE4AcdTYCr1MmmuJMxlgly8AwVMLIu+/+QvVlKDs5jYgq
         yNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ye7dpKDp7c5nhDFHYrYwoNCltp5b0VIIhD0V9njG2jg=;
        b=CTo9QAocOQ38ri6ZxcCjQVRLh4eVoSZ3dIfshOMhlNDh8HucG0L3Tqq4Br8quB8H5V
         1YkGMpsL01GJqjOOwS6UBtjQQzHh8GnoEwiL6fa7oceyUFcDOPdMF1wXyZmgePXdaaQt
         p0klQqvk2BL22YXHFPO5EE3J/m3zIc1+nNaIbTxQWdFdykxhFiXpttj+sZ1k9EeRFVUe
         /xF5/hDAF7CyOQTv+EucSY+DYD0RP0yWmjUdRCiIGl7gVsJJpiakRWzd76ZPT3TaWISy
         aIa/POPXGFLK1uwZSGwybYBTjs/2Knn98iOA7uIQ7k7psupzdCzrWn0UZzhM0kILl3w/
         5AAQ==
X-Gm-Message-State: APjAAAW4QLtyv69yO0v/Hq7Gz4kKOA/E/iV7RF9yVNUS6Y+3Y8kg9Wu0
        fXBDvienfApAosQYUO4+ISE98QL+vJA=
X-Google-Smtp-Source: APXvYqwTj83DAV20Cji+JQUkWRyCXDZoGWLweGGhVGTbm44zBN9PipFeMIjv7a9AL5tnffdXi+o5mw==
X-Received: by 2002:a17:902:24e:: with SMTP id 72mr5649202plc.287.1575390254329;
        Tue, 03 Dec 2019 08:24:14 -0800 (PST)
Received: from localhost.hsd1.wa.comcast.net ([2601:602:847f:811f:babe:8e8d:b27e:e6d7])
        by smtp.gmail.com with ESMTPSA id g10sm4052093pgh.35.2019.12.03.08.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:24:13 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] crypto: caam - allocate RNG instantiation descriptor with GFP_DMA
Date:   Tue,  3 Dec 2019 08:23:54 -0800
Message-Id: <20191203162357.21942-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203162357.21942-1-andrew.smirnov@gmail.com>
References: <20191203162357.21942-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be consistent with the rest of the codebase and use GFP_DMA when
allocating memory for a CAAM JR descriptor.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Tested-by: Chris Healy <cphealy@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index d7c3c3805693..c99a6a3b22de 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -193,7 +193,7 @@ static int deinstantiate_rng(struct device *ctrldev, int state_handle_mask)
 	u32 *desc, status;
 	int sh_idx, ret = 0;
 
-	desc = kmalloc(CAAM_CMD_SZ * 3, GFP_KERNEL);
+	desc = kmalloc(CAAM_CMD_SZ * 3, GFP_KERNEL | GFP_DMA);
 	if (!desc)
 		return -ENOMEM;
 
@@ -270,7 +270,7 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 	int ret = 0, sh_idx;
 
 	ctrl = (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
-	desc = kmalloc(CAAM_CMD_SZ * 7, GFP_KERNEL);
+	desc = kmalloc(CAAM_CMD_SZ * 7, GFP_KERNEL | GFP_DMA);
 	if (!desc)
 		return -ENOMEM;
 
-- 
2.21.0

