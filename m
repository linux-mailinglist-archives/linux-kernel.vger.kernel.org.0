Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604C669C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 22:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbfGOUUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 16:20:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33613 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbfGOUT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:19:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so8846722plo.0;
        Mon, 15 Jul 2019 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HCmJmyzmQT4Pt6JaXDG9/uRNYLrXoyYw1jAGneb5HzY=;
        b=IG0eJCAewoTOUUun5M223/wriO6b/gqFNT4s5JM0mJa0WMVKNrVZuOqL3Vgi7KSJrw
         nMf/PpaIILxsdr0egGzS4cVomYL71GQll6c5diQUMXMWb/8kVrRW0YK5I0cJJTSYa9Em
         5cotH+WKbXrnjzUC+joeRCF7rw1ikvZExSbkYeVGmSUpeR1cWAjkSEqnh/EOMhdsLa2a
         r0rYezOJkHQosNrsKAhjGpEeIgz9zEYNfYP6hZa2va7TON3spuM/EHjRODT1dm7LVtry
         HsLlHUQe9/Ieu5xo066q8aefcaIlytdl9LR3oyboS7hV7dKLMp88yvu6jd33Zua6h5+X
         4HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HCmJmyzmQT4Pt6JaXDG9/uRNYLrXoyYw1jAGneb5HzY=;
        b=tOMg5ieJAWutYuEinykiqArUFmcM4p7U2Grbem7b9o4Iif8l84qAtlgqv1073X/2g+
         wZR49mU4K4p2+Orna4jIgG9OrmNMhOdqowxNQsf0BSvRfE/EdyAFtFJR92k9JdtfpwO+
         CxqBnCdnqNuH5ReaZa3X5GGSZ0flS5R9z0DsSrqGL8ExdXzt06s6/h8KBwL4F0QTKLDf
         goE8wTsjJ+F/4iP8EjkjnRM3Iq9HLZzugrP77sAZNn8ASdEPHuguXD5Q5PHVZxLPV9DJ
         9h8/9WFe6lfDnVMmb3nTy6y/02YA1SSUUlQtYH71wk9Fq60LU2djcochh8MbggPuJ5B9
         UEbg==
X-Gm-Message-State: APjAAAUQSfgd+1/igvY1SddudJSu8JKX1ThMLa0wC/uRI3Yte7XSrtr5
        smE1qSxeEU9AC2MwPmPKUTg8nWBs
X-Google-Smtp-Source: APXvYqzuZFmnL21xc52ZR0xZ1bcEaMitMJRytGnBbBqVRgJOi1ZXa2aW9OfTase4gHR+xcTL8irvXQ==
X-Received: by 2002:a17:902:2808:: with SMTP id e8mr29329615plb.317.1563221997173;
        Mon, 15 Jul 2019 13:19:57 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id h1sm22730534pfg.55.2019.07.15.13.19.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:19:56 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Spencer <christopher.spencer@sea.co.uk>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/14] crypto: caam - use ioread64*_hi_lo in rd_reg64
Date:   Mon, 15 Jul 2019 13:19:34 -0700
Message-Id: <20190715201942.17309-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715201942.17309-1-andrew.smirnov@gmail.com>
References: <20190715201942.17309-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the same transformation logic as outlined in previous commit
converting wr_reg64, convert rd_reg64 to use helpers from
<linux/io-64-nonatomic-hi-lo.h> first. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Spencer <christopher.spencer@sea.co.uk>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/regs.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 6e8352ac0d92..afdc0d1aa338 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -172,12 +172,20 @@ static inline void wr_reg64(void __iomem *reg, u64 data)
 
 static inline u64 rd_reg64(void __iomem *reg)
 {
-	if (!caam_imx && caam_little_end)
-		return ((u64)rd_reg32((u32 __iomem *)(reg) + 1) << 32 |
-			(u64)rd_reg32((u32 __iomem *)(reg)));
+	if (caam_little_end) {
+		if (caam_imx) {
+			u32 low, high;
 
-	return ((u64)rd_reg32((u32 __iomem *)(reg)) << 32 |
-		(u64)rd_reg32((u32 __iomem *)(reg) + 1));
+			high = ioread32(reg);
+			low  = ioread32(reg + sizeof(u32));
+
+			return low + ((u64)high << 32);
+		} else {
+			return ioread64(reg);
+		}
+	} else {
+		return ioread64be(reg);
+	}
 }
 #endif /* CONFIG_64BIT  */
 
-- 
2.21.0

