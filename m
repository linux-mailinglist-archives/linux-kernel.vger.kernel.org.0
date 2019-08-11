Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B94890A6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHKIXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Aug 2019 04:23:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43628 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKIXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 04:23:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so463954pfn.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wo4/uRiHIALFdqkgpwktSoLWl4QtwkIFB23okqQapww=;
        b=RYEuc9J/vOST/W8tZzIQFZNhcC0yZxjak4y3HFNOKsVzosFaj1j7+3cCSOlDO6aLob
         zYwcRhY0EbmDXngqblcVApgs6Ies9CuaXAimU1RXSz+M1rMSmXKtL7bnCwF2cOQ3Cod5
         eTnRFr5flDU+XlSS2jM7wFNzqOBCNMIH8WXHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wo4/uRiHIALFdqkgpwktSoLWl4QtwkIFB23okqQapww=;
        b=RfN+YxT4q0a4EMKBE+IabWfzrQq+mrKgeW5lQSLLQBTxeBDnHoCL9ch58t01VpwCyp
         Z2QELx6yF7uWLwLPuaWHIWn6wy3z0aKHGnzRE2D7CcxwJug7qoYRkUbAvkhLpRjUjaiW
         Mu5fubJEp4hf7RNoJuu5jNaa/on1W1E2e1DFsn1oTpBzIM/tcv8GlCAQUGrkldjeUbmn
         xztvL0dWkw0PyYTp/yJ9DmFSb3nGLeaXwqAFZprQJ3FHFj2718nz1ZijBpncojVduVRn
         9H4Pu9/iNbXCDirOTTL0kPSgmu1viGa1q34XVpy+27BU88Md5enOP8X7s7B9Mjrsdpu5
         hthQ==
X-Gm-Message-State: APjAAAXMTAcq1rH82PDQgCA7v2RoZwG9njbIacyQfXMbcftVRCmYF1DU
        bRLmXtryyqMplQc1Jm2iXgtZDg==
X-Google-Smtp-Source: APXvYqymMdyFVk+KzTCVYi2Yr41UUABkv/0v1F5H5bRd/n3h6adkpBkfYEJXBbx789agxpQrjrHTlQ==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr18096468pjn.134.1565511788520;
        Sun, 11 Aug 2019 01:23:08 -0700 (PDT)
Received: from ikjn-glaptop.roam.corp.google.com (36-224-206-174.dynamic-ip.hinet.net. [36.224.206.174])
        by smtp.gmail.com with ESMTPSA id d14sm122742498pfo.154.2019.08.11.01.23.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 01:23:08 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] xhci: fix memleak on setup address fails.
Date:   Sun, 11 Aug 2019 16:22:59 +0800
Message-Id: <20190811082259.48176-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xhci re-enables a slot on transaction error in set_address using
xhci_disable_slot() + xhci_alloc_dev().

But in this case, xhci_alloc_dev() creates debugfs entries upon an
existing device without cleaning up old entries, thus memory leaks.

So this patch simply moves calling xhci_debugfs_free_dev() from
xhci_free_dev() to xhci_disable_slot().

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/usb/host/xhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 03d1e552769b..c24c5bf9ef9c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3814,7 +3814,6 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 		virt_dev->eps[i].ep_state &= ~EP_STOP_CMD_PENDING;
 		del_timer_sync(&virt_dev->eps[i].stop_cmd_timer);
 	}
-	xhci_debugfs_remove_slot(xhci, udev->slot_id);
 	virt_dev->udev = NULL;
 	ret = xhci_disable_slot(xhci, udev->slot_id);
 	if (ret)
@@ -3832,6 +3831,8 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
 	if (!command)
 		return -ENOMEM;
 
+	xhci_debugfs_remove_slot(xhci, slot_id);
+
 	spin_lock_irqsave(&xhci->lock, flags);
 	/* Don't disable the slot if the host controller is dead. */
 	state = readl(&xhci->op_regs->status);
-- 
2.23.0.rc1.153.gdeed80330f-goog

