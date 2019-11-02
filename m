Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B802AECFA2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 17:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKBP76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 11:59:58 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:58225 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfKBP75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 11:59:57 -0400
Received: from localhost.localdomain ([93.22.36.232])
        by mwinf5d68 with ME
        id M3zt2100550WvJt033zux4; Sat, 02 Nov 2019 16:59:55 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Nov 2019 16:59:55 +0100
X-ME-IP: 93.22.36.232
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] staging: wfx: Fix a memory leak in 'wfx_upload_beacon'
Date:   Sat,  2 Nov 2019 16:59:45 +0100
Message-Id: <20191102155945.20205-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code is a no-op, because all it can do is 'dev_kfree_skb(NULL)'
Remove the test before 'dev_kfree_skb()'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
V2: remove the 'if(...)', 'dev_kfree_skb()' can handle NULL.
---
 drivers/staging/wfx/sta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index 688586e823c0..93f3739b5f3a 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -906,8 +906,7 @@ static int wfx_upload_beacon(struct wfx_vif *wvif)
 	wfx_fwd_probe_req(wvif, false);
 
 done:
-	if (!skb)
-		dev_kfree_skb(skb);
+	dev_kfree_skb(skb);
 	return ret;
 }
 
-- 
2.20.1

