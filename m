Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3073018123D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 08:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgCKHpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 03:45:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:45:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5261AC22;
        Wed, 11 Mar 2020 07:45:14 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: bcm-pdc: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:45:13 +0100
Message-Id: <20200311074513.8464-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/mailbox/bcm-pdc-mailbox.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index fcb3b18a0678..c10a9318a4b7 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -436,33 +436,33 @@ static ssize_t pdc_debugfs_read(struct file *filp, char __user *ubuf,
 
 	pdcs = filp->private_data;
 	out_offset = 0;
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "SPU %u stats:\n", pdcs->pdc_idx);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "PDC requests....................%u\n",
 			       pdcs->pdc_requests);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "PDC responses...................%u\n",
 			       pdcs->pdc_replies);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Tx not done.....................%u\n",
 			       pdcs->last_tx_not_done);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Tx ring full....................%u\n",
 			       pdcs->tx_ring_full);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Rx ring full....................%u\n",
 			       pdcs->rx_ring_full);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Tx desc write fail. Ring full...%u\n",
 			       pdcs->txnobuf);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Rx desc write fail. Ring full...%u\n",
 			       pdcs->rxnobuf);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Receive overflow................%u\n",
 			       pdcs->rx_oflow);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Num frags in rx ring............%u\n",
 			       NRXDACTIVE(pdcs->rxin, pdcs->last_rx_curr,
 					  pdcs->nrxpost));
-- 
2.16.4

