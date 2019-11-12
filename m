Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8506AF8986
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 08:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKLHSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 02:18:36 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1792 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLHSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:18:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dca5ccb0000>; Mon, 11 Nov 2019 23:18:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Nov 2019 23:18:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Nov 2019 23:18:35 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 07:18:35 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 07:18:35 +0000
Received: from henryl-tu10x.nvidia.com (Not Verified[10.19.109.97]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dca5cca0001>; Mon, 11 Nov 2019 23:18:35 -0800
From:   Henry Lin <henryl@nvidia.com>
CC:     Henry Lin <henryl@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: xhci: only set D3hot for pci device
Date:   Tue, 12 Nov 2019 15:18:30 +0800
Message-ID: <20191112071831.1043-1-henryl@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573543115; bh=4YFauzFeS28mrBW+m+MC3Yqh22yBwd8ppo8M7Jb0IoM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=jbcsYfuI3mMwc+sOkFX07SgWsd0RiP5BkXjVdQenq4401f7/TKGL3Vjb+7n/kiv0O
         whU2dAwalTi3JTsOdvJrV4GP2WHhKSQuXfbwzoonpMLEbz9dx7HA4u4aqDHiECIaw1
         5O/MVJJKrFcYgozq2NT6gXaoZ5yEmyVUj03BKbnq/h/fl74zseNyls5XbDjbQ3y7Cj
         BzrOA1BZ3n276CNg2++p81ZkPP/PF8ERPUsgqtEThE3JgRgAh2TYV9JC4GblFVVIK3
         1e/h4fi3wH5HXVMW4ToxQ//bp1juyKNvK5Nsry8pQgsI0Ur8Jfr7rVeXkNonX8Tc9J
         svbPg00+zdsWQ==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci driver cannot call pci_set_power_state() on non-pci xhci host
controllers.

Signed-off-by: Henry Lin <henryl@nvidia.com>
---
 drivers/usb/host/xhci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6c17e3fe181a..1fc16763dcda 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -761,6 +761,8 @@ static void xhci_stop(struct usb_hcd *hcd)
 	mutex_unlock(&xhci->mutex);
 }
 
+extern struct device_type pci_dev_type;
+
 /*
  * Shutdown HC (not bus-specific)
  *
@@ -791,8 +793,12 @@ static void xhci_shutdown(struct usb_hcd *hcd)
 			readl(&xhci->op_regs->status));
 
 	/* Yet another workaround for spurious wakeups at shutdown with HSW */
-	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
-		pci_set_power_state(to_pci_dev(hcd->self.sysdev), PCI_D3hot);
+	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP) {
+		struct device *dev = hcd->self.sysdev;
+
+		if (dev->type == &pci_dev_type)
+			pci_set_power_state(to_pci_dev(dev), PCI_D3hot);
+	}
 }
 
 #ifdef CONFIG_PM
-- 
2.17.1

