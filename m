Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6439B2A4E0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfEYO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 10:26:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17575 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbfEYO0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 10:26:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8FC05363B4D22136E722;
        Sat, 25 May 2019 22:26:30 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 22:26:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clk: mmp: frac: Remove set but not used variable 'prev_rate'
Date:   Sat, 25 May 2019 22:25:35 +0800
Message-ID: <20190525142535.15040-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/clk/mmp/clk-frac.c: In function clk_factor_set_rate:
drivers/clk/mmp/clk-frac.c:81:16: warning: variable prev_rate set but not used [-Wunused-but-set-variable]

It's never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/mmp/clk-frac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index cb43d54735b0..90bf181f191a 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -78,11 +78,10 @@ static int clk_factor_set_rate(struct clk_hw *hw, unsigned long drate,
 	struct mmp_clk_factor_masks *masks = factor->masks;
 	int i;
 	unsigned long val;
-	unsigned long prev_rate, rate = 0;
+	unsigned long rate = 0;
 	unsigned long flags = 0;
 
 	for (i = 0; i < factor->ftbl_cnt; i++) {
-		prev_rate = rate;
 		rate = (((prate / 10000) * factor->ftbl[i].den) /
 			(factor->ftbl[i].num * factor->masks->factor)) * 10000;
 		if (rate > drate)
-- 
2.17.1


