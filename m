Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189356F445
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfGURI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 13:08:57 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:39858 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfGURI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 13:08:57 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d01 with ME
        id fV8q2000Q4n7eLC03V8rGm; Sun, 21 Jul 2019 19:08:55 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 19:08:55 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     david.kershner@unisys.com, gregkh@linuxfoundation.org,
        hariprasad.kelam@gmail.com, petrm@mellanox.com,
        davem@davemloft.net, jannh@google.com
Cc:     sparmaintainer@unisys.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: unisys: visornic: Update the description of 'poll_for_irq()'
Date:   Sun, 21 Jul 2019 19:08:24 +0200
Message-Id: <20190721170824.3412-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e99e88a9d2b06 ("treewide: setup_timer() -> timer_setup()") has
updated the parameters of 'poll_for_irq()' but not the comment above the
function.

Update the comment and fix a typo.
s/visronic/visornic/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/unisys/visornic/visornic_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
index 9d4f1dab0968..40dd573e73c3 100644
--- a/drivers/staging/unisys/visornic/visornic_main.c
+++ b/drivers/staging/unisys/visornic/visornic_main.c
@@ -1750,7 +1750,8 @@ static int visornic_poll(struct napi_struct *napi, int budget)
 }
 
 /* poll_for_irq	- checks the status of the response queue
- * @v: Void pointer to the visronic devdata struct.
+ * @t: pointer to the 'struct timer_list' from which we can retrieve the
+ *     the visornic devdata struct.
  *
  * Main function of the vnic_incoming thread. Periodically check the response
  * queue and drain it if needed.
-- 
2.20.1

