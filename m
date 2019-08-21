Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138F4973CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 09:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfHUHqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 03:46:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42010 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbfHUHqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:46:12 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9760FDF27863EA7C08B9;
        Wed, 21 Aug 2019 15:46:10 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 15:46:02 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <leoyang.li@nxp.com>, <roy.pledge@nxp.com>,
        <linuxppc-dev@lists.ozlabs.org>, <madalin.bucur@nxp.com>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] soc/fsl/qbman: fix return value error in bm_shutdown_pool()
Date:   Wed, 21 Aug 2019 16:06:49 +0800
Message-ID: <20190821080649.34133-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0505d00c8dba ("soc/fsl/qbman: Cleanup buffer pools if BMan was
initialized prior to bootup") defined a new variable to store the return
error, but forgot to return this value at the end of the function.

Fixes: 0505d00c8dba ("soc/fsl/qbman: Cleanup buffer pools if BMan was initialized prior to bootup")
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/soc/fsl/qbman/bman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index f4fb527d8301..c5dd026fe889 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -660,7 +660,7 @@ int bm_shutdown_pool(u32 bpid)
 	}
 done:
 	put_affine_portal();
-	return 0;
+	return err;
 }
 
 struct gen_pool *bm_bpalloc;
-- 
2.17.2

