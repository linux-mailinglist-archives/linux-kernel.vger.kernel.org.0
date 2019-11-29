Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A96D10D0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 04:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfK2Dhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 22:37:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbfK2Dhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 22:37:40 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5F1338584C3E47A3F3DE;
        Fri, 29 Nov 2019 11:37:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Fri, 29 Nov 2019 11:37:31 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] clk: bm1800: Remove set but not used variable 'fref'
Date:   Fri, 29 Nov 2019 03:35:34 +0000
Message-ID: <20191129033534.188257-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/clk/clk-bm1880.c: In function 'bm1880_pll_rate_calc':
drivers/clk/clk-bm1880.c:477:13: warning:
 variable 'fref' set but not used [-Wunused-but-set-variable]

It is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/clk-bm1880.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk-bm1880.c b/drivers/clk/clk-bm1880.c
index 4cd175afce9b..e6d6599d310a 100644
--- a/drivers/clk/clk-bm1880.c
+++ b/drivers/clk/clk-bm1880.c
@@ -474,11 +474,10 @@ static struct bm1880_composite_clock bm1880_composite_clks[] = {
 static unsigned long bm1880_pll_rate_calc(u32 regval, unsigned long parent_rate)
 {
 	u64 numerator;
-	u32 fbdiv, fref, refdiv;
+	u32 fbdiv, refdiv;
 	u32 postdiv1, postdiv2, denominator;
 
 	fbdiv = (regval >> 16) & 0xfff;
-	fref = parent_rate;
 	refdiv = regval & 0x1f;
 	postdiv1 = (regval >> 8) & 0x7;
 	postdiv2 = (regval >> 12) & 0x7;



