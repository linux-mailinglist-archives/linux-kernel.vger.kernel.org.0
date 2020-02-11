Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA9615944C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 17:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgBKQFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 11:05:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:46677 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgBKQFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:05:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 08:05:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="256514604"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2020 08:05:28 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: limit number of bytes in mei header.
Date:   Tue, 11 Feb 2020 18:05:22 +0200
Message-Id: <20200211160522.7562-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MEI message header provides only 9 bits for storing
the message size, limiting to 511.
In theory the host buffer (hbuf) can contain up to 1020 bytes
(limited by byte =  255 * 4)
With the current hardware and hbuf size 512, this is not a real issue,
but as hardening approach we enforce the limit.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c | 4 ++--
 drivers/misc/mei/hw.h     | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 1e3edbbacb1e..204d807e755b 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1585,7 +1585,7 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 		goto err;
 	}
 
-	hbuf_len = mei_slots2data(hbuf_slots);
+	hbuf_len = mei_slots2data(hbuf_slots) & MEI_MSG_MAX_LEN_MASK;
 	dr_slots = mei_dma_ring_empty_slots(dev);
 	dr_len = mei_slots2data(dr_slots);
 
@@ -1718,7 +1718,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 		goto out;
 	}
 
-	hbuf_len = mei_slots2data(hbuf_slots);
+	hbuf_len = mei_slots2data(hbuf_slots) & MEI_MSG_MAX_LEN_MASK;
 	dr_slots = mei_dma_ring_empty_slots(dev);
 	dr_len =  mei_slots2data(dr_slots);
 
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index d025a5f8317e..8231b6941adf 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -209,6 +209,9 @@ struct mei_msg_hdr {
 	u32 extension[0];
 } __packed;
 
+/* The length is up to 9 bits */
+#define MEI_MSG_MAX_LEN_MASK GENMASK(9, 0)
+
 #define MEI_MSG_HDR_MAX 2
 
 struct mei_bus_message {
-- 
2.21.1

