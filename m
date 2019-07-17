Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53C56BF03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfGQPZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 11:25:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44767 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfGQPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:25:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so11325833pgl.11;
        Wed, 17 Jul 2019 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E8M9KHyXwUEtFUyzJoarpboyeyNZ234MBzkiPCu7LgU=;
        b=n/n+DW0taP8/HfeX4rPsPKG2wVzWmOztrUf1yTrdJAgRnCQJTEE/+TvvkriIq2LKln
         mRD74523p00BpOw0mEZj3SwSNXGGWkh9/mwwX115X6ggxYLWa8ijT4PgLSPPQOYIOO3I
         xzwl/C4kIxmiP+Yj2u4ITtRd6dzNXxsYK1C7lVIhUf9+QkBPpjxmRKAZ0v2OFsqrhdR6
         SqHYr4DGewnqBmARyyYwx3PsspDCAQXVsjoS37h39p2/NeTNCLZlkljkRWgPxgFh52OJ
         78vWWRPdwmxC0K2RKDRl8c8EITWIARWjPNuc/gkMhb3svFjMO0DFLbI+x6vagF7EbTNk
         k1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E8M9KHyXwUEtFUyzJoarpboyeyNZ234MBzkiPCu7LgU=;
        b=L4wnpWxJMch2byo0dErfT3OY8K+NShXMrJlxQyMVete40UadYOFcHFrFCyrAE9SeOx
         5u+T0z7cDl1vRRqPdLHhD1xTrcZ8wxcZCv1iUO41/s7nnkvyCTGI0RfaaOKfc5F9nu6v
         gfsazFbjqo3vf6a4py/pcc99HVVtmTjrQxsZxW//Zbc46Ch8ZKwQZw2TnDu53FXtNdbh
         1kNTnMhQ9bisiO6I2A3fFjRSTL0O/oHQ4GwH2Ag9K9+Zlrv/qS7x5N8dDx8LL8QMFdv7
         zbbT268fmMyT4FxV9QKiNN8ZqgQ5e+qa0dAeFXbj9ZZMCk2qlFBVRi6D6sUjsRJ2d2Es
         wMGg==
X-Gm-Message-State: APjAAAU+3ajvzYutz9ecvy9hfAeDuyZwQP6dTAs0pNgB+d2DlP0KlC7k
        udDiFhcU3tBfx0Tg3vNN2iMBuRc0
X-Google-Smtp-Source: APXvYqw2YEpJNPIX81qCLdEx9tmqo9nHz4BtRiuhX9dj2fM/KOX/e3nrAlZTyPeLiAXLMbPpTEYnYw==
X-Received: by 2002:a63:6d8d:: with SMTP id i135mr41329413pgc.303.1563377119725;
        Wed, 17 Jul 2019 08:25:19 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id l1sm33771386pfl.9.2019.07.17.08.25.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 08:25:19 -0700 (PDT)
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
Subject: [PATCH v6 05/14] crytpo: caam - make use of iowrite64*_hi_lo in wr_reg64
Date:   Wed, 17 Jul 2019 08:24:49 -0700
Message-Id: <20190717152458.22337-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717152458.22337-1-andrew.smirnov@gmail.com>
References: <20190717152458.22337-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to unify 64 and 32 bit implementations of
wr_reg64, let's convert it to use helpers from
<linux/io-64-nonatomic-hi-lo.h> first. Here are the steps of the
transformation:

1. Inline wr_reg32 helpers:

	if (!caam_imx && caam_little_end) {
		if (caam_little_end) {
			iowrite32(data >> 32, (u32 __iomem *)(reg) + 1);
			iowrite32(data, (u32 __iomem *)(reg));
		} else {
			iowrite32be(data >> 32, (u32 __iomem *)(reg) + 1);
			iowrite32be(data, (u32 __iomem *)(reg));
		}
	} else {
		if (caam_little_end) {
			iowrite32(data >> 32, (u32 __iomem *)(reg));
			iowrite32(data, (u32 __iomem *)(reg) + 1);
		} else {
			iowrite32be(data >> 32, (u32 __iomem *)(reg));
			iowrite32be(data, (u32 __iomem *)(reg) + 1);
		}
	}

2. Transfrom the conditionals such that the check for
'caam_little_end' is at the top level:

	if (caam_little_end) {
		if (!caam_imx) {
			iowrite32(data >> 32, (u32 __iomem *)(reg) + 1);
			iowrite32(data, (u32 __iomem *)(reg));
		} else {
			iowrite32(data >> 32, (u32 __iomem *)(reg));
			iowrite32(data, (u32 __iomem *)(reg) + 1);
		}
	} else {
		iowrite32be(data >> 32, (u32 __iomem *)(reg));
		iowrite32be(data, (u32 __iomem *)(reg) + 1);
	}

3. Invert the check for !caam_imx:

	if (caam_little_end) {
		if (caam_imx) {
			iowrite32(data >> 32, (u32 __iomem *)(reg));
			iowrite32(data, (u32 __iomem *)(reg) + 1);
		} else {
			iowrite32(data >> 32, (u32 __iomem *)(reg) + 1);
			iowrite32(data, (u32 __iomem *)(reg));
		}
	} else {
		iowrite32be(data >> 32, (u32 __iomem *)(reg));
		iowrite32be(data, (u32 __iomem *)(reg) + 1);
	}

4. Make use of iowrite64* helpers from <linux/io-64-nonatomic-hi-lo.h>

	if (caam_little_end) {
		if (caam_imx) {
			iowrite32(data >> 32, (u32 __iomem *)(reg));
			iowrite32(data, (u32 __iomem *)(reg) + 1);
		} else {
			iowrite64(data, reg);
		}
	} else {
		iowrite64be(data, reg);
	}

No functional change intended.

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
 drivers/crypto/caam/regs.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 8591914d5c51..6e8352ac0d92 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 
 /*
  * Architecture-specific register access methods
@@ -157,12 +158,15 @@ static inline u64 rd_reg64(void __iomem *reg)
 #else /* CONFIG_64BIT */
 static inline void wr_reg64(void __iomem *reg, u64 data)
 {
-	if (!caam_imx && caam_little_end) {
-		wr_reg32((u32 __iomem *)(reg) + 1, data >> 32);
-		wr_reg32((u32 __iomem *)(reg), data);
+	if (caam_little_end) {
+		if (caam_imx) {
+			iowrite32(data >> 32, (u32 __iomem *)(reg));
+			iowrite32(data, (u32 __iomem *)(reg) + 1);
+		} else {
+			iowrite64(data, reg);
+		}
 	} else {
-		wr_reg32((u32 __iomem *)(reg), data >> 32);
-		wr_reg32((u32 __iomem *)(reg) + 1, data);
+		iowrite64be(data, reg);
 	}
 }
 
-- 
2.21.0

