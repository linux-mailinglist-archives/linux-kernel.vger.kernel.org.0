Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA4177C232
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfGaMvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:51:48 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:24892 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729131AbfGaMvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:51:47 -0400
Received: from localhost.localdomain ([176.167.121.156])
        by mwinf5d70 with ME
        id jQrk2000S3NZnML03QrlSX; Wed, 31 Jul 2019 14:51:46 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 31 Jul 2019 14:51:46 +0200
X-ME-IP: 176.167.121.156
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] usb: xhci: dbc: Simplify error handling in 'xhci_dbc_alloc_requests()'
Date:   Wed, 31 Jul 2019 14:51:50 +0200
Message-Id: <1593f29b4f9350b2034f20dda60de57409b12965.1564577335.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564577335.git.christophe.jaillet@wanadoo.fr>
References: <cover.1564577335.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the 'kmalloc()' fails, we need to undo the previous
'dbc_alloc_request()' call.

Because of the more similar function name, it is more logical to use
'dbc_free_request()' instead of 'xhci_dbc_free_req()'.

Both are equivalent here because:
 static void xhci_dbc_free_req(struct dbc_ep *dep, struct dbc_request *req)
 {
 	kfree(req->buf);
 	dbc_free_request(dep, req);
 }
and 'req->buf' is known to be NULL at this point

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/host/xhci-dbgtty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index aff79ff5aba4..845939f8a0b8 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -146,7 +146,7 @@ xhci_dbc_alloc_requests(struct dbc_ep *dep, struct list_head *head,
 		req->length = DBC_MAX_PACKET;
 		req->buf = kmalloc(req->length, GFP_KERNEL);
 		if (!req->buf) {
-			xhci_dbc_free_req(dep, req);
+			dbc_free_request(dep, req);
 			break;
 		}
 
-- 
2.20.1

