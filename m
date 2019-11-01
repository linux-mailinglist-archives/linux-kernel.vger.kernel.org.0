Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7015DEC769
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 18:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfKARWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 13:22:04 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:17620 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKARWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:22:04 -0400
Received: from localhost.localdomain ([93.22.132.57])
        by mwinf5d40 with ME
        id LhMz210031ETPpp03hMzam; Fri, 01 Nov 2019 18:22:00 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 01 Nov 2019 18:22:00 +0100
X-ME-IP: 93.22.132.57
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: wfx: Fix a memory leak in 'wfx_upload_beacon'
Date:   Fri,  1 Nov 2019 18:21:51 +0100
Message-Id: <20191101172151.14295-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code is a no-op, because all it can do is 'dev_kfree_skb(NULL)'
Revert the test to free skb, if not NULL.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is purely speculative.

The 'if  (...)' could also be removed completely if we refactor the code
and return directly at the beginning of the function.
Or the 'return -ENOMEM' should be 'err = -ENOMEM; goto done;' in order to
avoid a mixup of goto and direct return.
---
 drivers/staging/wfx/sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index 688586e823c0..e14da8dce388 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -906,7 +906,7 @@ static int wfx_upload_beacon(struct wfx_vif *wvif)
 	wfx_fwd_probe_req(wvif, false);
 
 done:
-	if (!skb)
+	if (skb)
 		dev_kfree_skb(skb);
 	return ret;
 }
-- 
2.20.1

