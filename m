Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32580F73B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 13:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKKMUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 07:20:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48016 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKMUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:20:20 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iU8fx-0008Et-PF; Mon, 11 Nov 2019 12:20:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] xen/gntdev: remove redundant non-zero check on ret
Date:   Mon, 11 Nov 2019 12:20:09 +0000
Message-Id: <20191111122009.67789-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The non-zero check on ret is always going to be false because
ret was initialized as zero and the only place it is set to
non-zero contains a return path before the non-zero check. Hence
the check is redundant and can be removed.

Addresses-Coverity: ("Logically dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/xen/gntdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 10cc5e9e612a..07d80b176118 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -524,11 +524,6 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 	}
 #endif
 
-	if (ret) {
-		kfree(priv);
-		return ret;
-	}
-
 	flip->private_data = priv;
 #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
 	priv->dma_dev = gntdev_miscdev.this_device;
-- 
2.20.1

