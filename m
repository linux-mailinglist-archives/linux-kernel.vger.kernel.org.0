Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BABF89E39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfHLMZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 08:25:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728464AbfHLMZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:25:12 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3FD46459B3490B51E00F;
        Mon, 12 Aug 2019 20:25:10 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 12 Aug 2019 20:25:03 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <sunke32@huawei.com>, <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] nbd: add a missed nbd_config_put() in nbd_xmit_timeout()
Date:   Mon, 12 Aug 2019 20:31:26 +0800
Message-ID: <1565613086-13776-1-git-send-email-sunke32@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When try to get the lock failed, before return, execute the
nbd_config_put() to decrease the nbd->config_refs.

If the nbd->config_refs is added but not decreased. Then will not
execute nbd_clear_sock() in nbd_config_put(). bd->task_setup will
not be cleared away. Finally, print"Device being setup by another
task" in nbd_add_sock() and nbd device can not be reused.

Fixes: 8f3ea35929a0 ("nbd: handle unexpected replies better")
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 drivers/block/nbd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e21d2de..a69a90a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -357,8 +357,10 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	}
 	config = nbd->config;
 
-	if (!mutex_trylock(&cmd->lock))
+	if (!mutex_trylock(&cmd->lock)) {
+		nbd_config_put(nbd);
 		return BLK_EH_RESET_TIMER;
+	}
 
 	if (config->num_connections > 1) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
-- 
2.7.4

