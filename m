Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4F090381
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfHPN5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 09:57:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727205AbfHPN5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:57:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2E397723C8739735988E;
        Fri, 16 Aug 2019 21:57:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 16 Aug 2019
 21:57:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <allison@lohutok.net>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clk: st: clkgen-pll: remove unused variable 'st_pll3200c32_407_a0'
Date:   Fri, 16 Aug 2019 21:55:23 +0800
Message-ID: <20190816135523.73520-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clk/st/clkgen-pll.c:64:37: warning:
 st_pll3200c32_407_a0 defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/st/clkgen-pll.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index d8a688b..c3952f2 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -61,19 +61,6 @@ static const struct clk_ops stm_pll3200c32_ops;
 static const struct clk_ops stm_pll3200c32_a9_ops;
 static const struct clk_ops stm_pll4600c28_ops;
 
-static const struct clkgen_pll_data st_pll3200c32_407_a0 = {
-	/* 407 A0 */
-	.pdn_status	= CLKGEN_FIELD(0x2a0,	0x1,			8),
-	.pdn_ctrl	= CLKGEN_FIELD(0x2a0,	0x1,			8),
-	.locked_status	= CLKGEN_FIELD(0x2a0,	0x1,			24),
-	.ndiv		= CLKGEN_FIELD(0x2a4,	C32_NDIV_MASK,		16),
-	.idf		= CLKGEN_FIELD(0x2a4,	C32_IDF_MASK,		0x0),
-	.num_odfs = 1,
-	.odf		= { CLKGEN_FIELD(0x2b4, C32_ODF_MASK,		0) },
-	.odf_gate	= { CLKGEN_FIELD(0x2b4,	0x1,			6) },
-	.ops		= &stm_pll3200c32_ops,
-};
-
 static const struct clkgen_pll_data st_pll3200c32_cx_0 = {
 	/* 407 C0 PLL0 */
 	.pdn_status	= CLKGEN_FIELD(0x2a0,	0x1,			8),
-- 
2.7.4


