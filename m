Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8657C142358
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 07:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgATGe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 01:34:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgATGeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 01:34:25 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4DC9D7ACF38E0BE79970;
        Mon, 20 Jan 2020 14:34:23 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 Jan 2020
 14:34:13 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <b.zolnierkie@samsung.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH V2] video: remove set but not used variable 'mach64RefFreq'
Date:   Mon, 20 Jan 2020 14:33:27 +0800
Message-ID: <20200120063327.43548-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/aty/mach64_gx.c: In function ‘aty_var_to_pll_8398’:
drivers/video/fbdev/aty/mach64_gx.c:621:36: warning: variable
‘mach64RefFreq’ set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
changes in V2:
 Fix the mistake that definition of 'mach64MinFreq' and 'mach64MaxFreq'
 was removed.

 drivers/video/fbdev/aty/mach64_gx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/mach64_gx.c b/drivers/video/fbdev/aty/mach64_gx.c
index 27cb65fa2ba2..9c37e28fb78b 100644
--- a/drivers/video/fbdev/aty/mach64_gx.c
+++ b/drivers/video/fbdev/aty/mach64_gx.c
@@ -618,14 +618,13 @@ static int aty_var_to_pll_8398(const struct fb_info *info, u32 vclk_per,
 	u32 mhz100;		/* in 0.01 MHz */
 	u32 program_bits;
 	/* u32 post_divider; */
-	u32 mach64MinFreq, mach64MaxFreq, mach64RefFreq;
+	u32 mach64MinFreq, mach64MaxFreq;
 	u16 m, n, k = 0, save_m, save_n, twoToKth;
 
 	/* Calculate the programming word */
 	mhz100 = 100000000 / vclk_per;
 	mach64MinFreq = MIN_FREQ_2595;
 	mach64MaxFreq = MAX_FREQ_2595;
-	mach64RefFreq = REF_FREQ_2595;	/* 14.32 MHz */
 
 	save_m = 0;
 	save_n = 0;
-- 
2.17.2

