Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1225FD79A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 17:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfJOPV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 11:21:59 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52000 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732659AbfJOPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:21:59 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKOe0-0006E0-Nb; Tue, 15 Oct 2019 16:21:52 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKOe0-0000UU-9v; Tue, 15 Oct 2019 16:21:52 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: fix __le32/__le64 accessors in debugfs code
Date:   Tue, 15 Oct 2019 16:21:50 +0100
Message-Id: <20191015152150.1840-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like some of the xhci debug code is passing
u32 to functions directly from __le32/__le64 fields. Fix
this by using le{32,64}_to_cpu() on these to fix the
following sparse warnings;

drivers/usb/host/xhci-debugfs.c:205:62: warning: incorrect type in argument 1 (different base types)
drivers/usb/host/xhci-debugfs.c:205:62:    expected unsigned int [usertype] field0
drivers/usb/host/xhci-debugfs.c:205:62:    got restricted __le32
drivers/usb/host/xhci-debugfs.c:206:62: warning: incorrect type in argument 2 (different base types)
drivers/usb/host/xhci-debugfs.c:206:62:    expected unsigned int [usertype] field1
drivers/usb/host/xhci-debugfs.c:206:62:    got restricted __le32
drivers/usb/host/xhci-debugfs.c:207:62: warning: incorrect type in argument 3 (different base types)
drivers/usb/host/xhci-debugfs.c:207:62:    expected unsigned int [usertype] field2
drivers/usb/host/xhci-debugfs.c:207:62:    got restricted __le32
drivers/usb/host/xhci-debugfs.c:208:62: warning: incorrect type in argument 4 (different base types)
drivers/usb/host/xhci-debugfs.c:208:62:    expected unsigned int [usertype] field3
drivers/usb/host/xhci-debugfs.c:208:62:    got restricted __le32
drivers/usb/host/xhci-debugfs.c:266:53: warning: incorrect type in argument 1 (different base types)
drivers/usb/host/xhci-debugfs.c:266:53:    expected unsigned int [usertype] info
drivers/usb/host/xhci-debugfs.c:266:53:    got restricted __le32 [usertype] dev_info
drivers/usb/host/xhci-debugfs.c:267:53: warning: incorrect type in argument 2 (different base types)
drivers/usb/host/xhci-debugfs.c:267:53:    expected unsigned int [usertype] info2
drivers/usb/host/xhci-debugfs.c:267:53:    got restricted __le32 [usertype] dev_info2
drivers/usb/host/xhci-debugfs.c:268:53: warning: incorrect type in argument 3 (different base types)
drivers/usb/host/xhci-debugfs.c:268:53:    expected unsigned int [usertype] tt_info
drivers/usb/host/xhci-debugfs.c:268:53:    got restricted __le32 [usertype] tt_info
drivers/usb/host/xhci-debugfs.c:269:53: warning: incorrect type in argument 4 (different base types)
drivers/usb/host/xhci-debugfs.c:269:53:    expected unsigned int [usertype] state
drivers/usb/host/xhci-debugfs.c:269:53:    got restricted __le32 [usertype] dev_state
drivers/usb/host/xhci-debugfs.c:289:57: warning: incorrect type in argument 1 (different base types)
drivers/usb/host/xhci-debugfs.c:289:57:    expected unsigned int [usertype] info
drivers/usb/host/xhci-debugfs.c:289:57:    got restricted __le32 [usertype] ep_info
drivers/usb/host/xhci-debugfs.c:290:57: warning: incorrect type in argument 2 (different base types)
drivers/usb/host/xhci-debugfs.c:290:57:    expected unsigned int [usertype] info2
drivers/usb/host/xhci-debugfs.c:290:57:    got restricted __le32 [usertype] ep_info2
drivers/usb/host/xhci-debugfs.c:291:57: warning: incorrect type in argument 3 (different base types)
drivers/usb/host/xhci-debugfs.c:291:57:    expected unsigned long long [usertype] deq
drivers/usb/host/xhci-debugfs.c:291:57:    got restricted __le64 [usertype] deq
drivers/usb/host/xhci-debugfs.c:292:57: warning: incorrect type in argument 4 (different base types)
drivers/usb/host/xhci-debugfs.c:292:57:    expected unsigned int [usertype] tx_info
drivers/usb/host/xhci-debugfs.c:292:57:    got restricted __le32 [usertype] tx_info

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
.. (open list)
---
 drivers/usb/host/xhci-debugfs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 7ba6afc7ef23..76c3f29562d2 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -202,10 +202,10 @@ static void xhci_ring_dump_segment(struct seq_file *s,
 		trb = &seg->trbs[i];
 		dma = seg->dma + i * sizeof(*trb);
 		seq_printf(s, "%pad: %s\n", &dma,
-			   xhci_decode_trb(trb->generic.field[0],
-					   trb->generic.field[1],
-					   trb->generic.field[2],
-					   trb->generic.field[3]));
+			   xhci_decode_trb(le32_to_cpu(trb->generic.field[0]),
+					   le32_to_cpu(trb->generic.field[1]),
+					   le32_to_cpu(trb->generic.field[2]),
+					   le32_to_cpu(trb->generic.field[3])));
 	}
 }
 
@@ -263,10 +263,10 @@ static int xhci_slot_context_show(struct seq_file *s, void *unused)
 	xhci = hcd_to_xhci(bus_to_hcd(dev->udev->bus));
 	slot_ctx = xhci_get_slot_ctx(xhci, dev->out_ctx);
 	seq_printf(s, "%pad: %s\n", &dev->out_ctx->dma,
-		   xhci_decode_slot_context(slot_ctx->dev_info,
-					    slot_ctx->dev_info2,
-					    slot_ctx->tt_info,
-					    slot_ctx->dev_state));
+		   xhci_decode_slot_context(le32_to_cpu(slot_ctx->dev_info),
+					    le32_to_cpu(slot_ctx->dev_info2),
+					    le32_to_cpu(slot_ctx->tt_info),
+					    le32_to_cpu(slot_ctx->dev_state)));
 
 	return 0;
 }
@@ -286,10 +286,10 @@ static int xhci_endpoint_context_show(struct seq_file *s, void *unused)
 		ep_ctx = xhci_get_ep_ctx(xhci, dev->out_ctx, dci);
 		dma = dev->out_ctx->dma + dci * CTX_SIZE(xhci->hcc_params);
 		seq_printf(s, "%pad: %s\n", &dma,
-			   xhci_decode_ep_context(ep_ctx->ep_info,
-						  ep_ctx->ep_info2,
-						  ep_ctx->deq,
-						  ep_ctx->tx_info));
+			   xhci_decode_ep_context(le32_to_cpu(ep_ctx->ep_info),
+						  le32_to_cpu(ep_ctx->ep_info2),
+						  le64_to_cpu(ep_ctx->deq),
+						  le32_to_cpu(ep_ctx->tx_info)));
 	}
 
 	return 0;
-- 
2.23.0

