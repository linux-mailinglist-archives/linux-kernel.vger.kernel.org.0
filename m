Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7EDB5DF79
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 10:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfGCIOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 04:14:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47062 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfGCIOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:14:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id i8so796118pgm.13;
        Wed, 03 Jul 2019 01:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMpnTuEF4VNlabdEsAMZ4XSxyFLWi8ZClVXNYx4KkpU=;
        b=qVZHkme6fvf8aglv3tkuK+jmDsuPAZVTAiDpb/GEFk76c/tx5ID7g6ByTtMgAAd9Wy
         pQkuun8ELlsVeAN9Tpy91FqesxZETKkrOTiohCo6pS37EJr+sp72i3hhHlked9/L8C4Q
         OL4qyRAlI6/REBifttko2nfSKwTajfSX6ublH/jkcQbOfbup9ri87A8eBNIzTPy9zgzJ
         NZp1qLWydzn35z98Ey/P6cN1AmMBbmsmg7ZRIjbL/GWfBdWlks0fq+6RdOP9ScyR4vwK
         1IU3PWKVYLZHLjqs98idwwe+5A+KueTA49n67gR4cyHNSoFTiFJpIxVcBGFHB62i50ch
         3EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMpnTuEF4VNlabdEsAMZ4XSxyFLWi8ZClVXNYx4KkpU=;
        b=F4cQo5fkV/a14UJ2AQuVu3AIAH/idK5s0xRof1zoglI3SXGl1Jf3Wnw1fbun/u72oB
         sWkJxeQu5p57v4EqUMd0l3ghEApxRX+6UbUL5BW7/TzlGCPnDRSWFQDjShWfK628VM2s
         zGp9XkLpk4elgiuOFDD9WFwmXlAuLvGEy+n3KpUAAFufA4LT1LAg//Z0SUt2Gyxy1S/K
         wRPXvCA/2V3eOolICha4yJa0BzF0r2AMT0qfyT31UPUE2RoPoJZIk3zyE0Cr7g8fS37a
         FiKCGNIiJ8Ntuxg4vWmV4trxh7oFAVcZdeZkPSJ3jfdN0Htgc2ieQj5Lofpbq+srlOhM
         PiFA==
X-Gm-Message-State: APjAAAVKvTNqOcjz1dVdALrf1Xg+LNyHT02SVuRcQSOH1OiUE8cp0qHe
        aeZjvuxCDrgQ9tIa9hvSDatAdGzPlaY=
X-Google-Smtp-Source: APXvYqy6ReGzaO65rzPd9ZNz3J4puHYREDfAlMBe6X+nugyhLMeATX/71BccuFBJHLXnXJQq7e2UZw==
X-Received: by 2002:a63:224a:: with SMTP id t10mr35544309pgm.289.1562141649226;
        Wed, 03 Jul 2019 01:14:09 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id d2sm1445306pgo.0.2019.07.03.01.14.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 01:14:08 -0700 (PDT)
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
Subject: [PATCH v4 09/16] crypto: caam - drop 64-bit only wr/rd_reg64()
Date:   Wed,  3 Jul 2019 01:13:20 -0700
Message-Id: <20190703081327.17505-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703081327.17505-1-andrew.smirnov@gmail.com>
References: <20190703081327.17505-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 32-bit of both wr_reg64 and rd_reg64 now use 64-bit IO helpers,
these functions should no longer be necessary. No functional change intended.

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
 drivers/crypto/caam/regs.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index afdc0d1aa338..fb494d14f262 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -138,24 +138,6 @@ static inline void clrsetbits_32(void __iomem *reg, u32 clear, u32 set)
  *    base + 0x0000 : least-significant 32 bits
  *    base + 0x0004 : most-significant 32 bits
  */
-#ifdef CONFIG_64BIT
-static inline void wr_reg64(void __iomem *reg, u64 data)
-{
-	if (caam_little_end)
-		iowrite64(data, reg);
-	else
-		iowrite64be(data, reg);
-}
-
-static inline u64 rd_reg64(void __iomem *reg)
-{
-	if (caam_little_end)
-		return ioread64(reg);
-	else
-		return ioread64be(reg);
-}
-
-#else /* CONFIG_64BIT */
 static inline void wr_reg64(void __iomem *reg, u64 data)
 {
 	if (caam_little_end) {
@@ -187,7 +169,6 @@ static inline u64 rd_reg64(void __iomem *reg)
 		return ioread64be(reg);
 	}
 }
-#endif /* CONFIG_64BIT  */
 
 static inline u64 cpu_to_caam_dma64(dma_addr_t value)
 {
-- 
2.21.0

