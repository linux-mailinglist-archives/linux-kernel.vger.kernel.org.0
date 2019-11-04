Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6288CED8C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 06:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfKDFw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 00:52:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58474 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfKDFw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 00:52:27 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iRVHs-00032u-IX; Mon, 04 Nov 2019 05:52:25 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] xhci: Increase STS_HALT timeout in xhci_suspend()
Date:   Mon,  4 Nov 2019 13:52:17 +0800
Message-Id: <20191104055217.10475-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently observed failed xHCI suspend attempt on AMD Raven Ridge
system:
kernel: xhci_hcd 0000:04:00.4: WARN: xHC CMD_RUN timeout
kernel: PM: suspend_common(): xhci_pci_suspend+0x0/0xd0 returns -110
kernel: PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -110
kernel: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x150 returns -110
kernel: PM: Device 0000:04:00.4 failed to suspend async: error -110

Similar to commit ac343366846a ("xhci: Increase STS_SAVE timeout in
xhci_suspend()") we also need to increase the HALT timeout to make it be
able to suspend again.

Fixes: f7fac17ca925 ("xhci: Convert xhci_handshake() to use readl_poll_timeout_atomic()")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6c17e3fe181a..53720c41891a 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -973,7 +973,7 @@ static bool xhci_pending_portevent(struct xhci_hcd *xhci)
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 {
 	int			rc = 0;
-	unsigned int		delay = XHCI_MAX_HALT_USEC;
+	unsigned int		delay = XHCI_MAX_HALT_USEC * 2;
 	struct usb_hcd		*hcd = xhci_to_hcd(xhci);
 	u32			command;
 	u32			res;
-- 
2.17.1

