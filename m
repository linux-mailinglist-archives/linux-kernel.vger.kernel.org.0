Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D872EB154
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 14:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfJaNiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 09:38:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47910 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726728AbfJaNiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:38:19 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 46FF61E1E7AA8A3FFDB2;
        Thu, 31 Oct 2019 21:38:17 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Thu, 31 Oct 2019 21:38:08 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <zhongjiang@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: ux500: Remove redundant variable "status"
Date:   Thu, 31 Oct 2019 21:34:15 +0800
Message-ID: <1572528855-25990-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

local variable "status" is not used. hence it is safe to remove and
just return 0.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 sound/soc/ux500/ux500_msp_i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index a90e0d7..394d8b2 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -533,7 +533,6 @@ static void disable_msp_tx(struct ux500_msp *msp)
 static int disable_msp(struct ux500_msp *msp, unsigned int dir)
 {
 	u32 reg_val_GCR;
-	int status = 0;
 	unsigned int disable_tx, disable_rx;
 
 	reg_val_GCR = readl(msp->registers + MSP_GCR);
@@ -566,7 +565,7 @@ static int disable_msp(struct ux500_msp *msp, unsigned int dir)
 	else if (disable_rx)
 		disable_msp_rx(msp);
 
-	return status;
+	return 0;
 }
 
 int ux500_msp_i2s_trigger(struct ux500_msp *msp, int cmd, int direction)
-- 
1.7.12.4

