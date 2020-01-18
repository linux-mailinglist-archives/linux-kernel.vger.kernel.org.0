Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F014152C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 01:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgARAZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 19:25:47 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39859 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbgARAZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 19:25:46 -0500
Received: by mail-pj1-f68.google.com with SMTP id e11so4075442pjt.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 16:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWxirRR7Wfy2+PcTI0hB09FZtOC8LZoqLVZIg5Rnm1w=;
        b=keR5G9uaZyDKFwyyJfHkvYRIfOR1MoqFTmzm6I/pcaGvIGLBRhvXtIXXMyq0QV+9ft
         mG3A66ewUhY6vWPdVRIY6lgW1+993WgUmn1NtpThipmkWt7gNeF4qtTABYABLNHYHsnG
         w/broOmqKVddFYyItFNPg/8rRgL28SYNRX6U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWxirRR7Wfy2+PcTI0hB09FZtOC8LZoqLVZIg5Rnm1w=;
        b=d7bNaRQee/+BS9tnmJfp/Phzqm13bM7nw9gpJwPrRefQyNjaQOr8nEDslsDIl6ruE8
         9bgMEYxbxiZfwzFkAhIF62+AaoiRa43/WeziSHI56UPfSNfujjjXf9Xx8SzXYvuuFTXM
         subsQ4y031fLbm3nBNty2PGRFdlUN570DMFA3zCCZKEkldZhGJMYh0BEA+3+0lWrjPBR
         Zqy3i/gl9f156fL++rYv3n912N3qR0qPD+fiK1I3Ny1OSmWJ3GPZ6pMNEjd+DapPabMm
         SgTw3OVTHTcm/Xoeep1SX/FET8aOfP0/7tSZCmeDxsMr3KHGCqJszcxvAwM9XYkILf20
         RR6g==
X-Gm-Message-State: APjAAAV8V1P1ruUwBfkVPV/shLC5ByXiBbhWF9g0KQf0dA3aQuDePOVj
        euk85dM41mzRuIiiI6VeVlPm3Q==
X-Google-Smtp-Source: APXvYqyAHHhOtcjeWVJpTuOw/QAHVhoZa9cf71t5ukErCzSzAwsv3H8gj+cnIHOhw9jc312u5c2ubQ==
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr9302343pjn.59.1579307146062;
        Fri, 17 Jan 2020 16:25:46 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 199sm32194947pfv.81.2020.01.17.16.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 16:25:45 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Evan Green <evgreen@chromium.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
Date:   Fri, 17 Jan 2020 16:25:30 -0800
Message-Id: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__pci_write_msi_msg() updates three registers in the device: address
high, address low, and data. On x86 systems, address low contains
CPU targeting info, and data contains the vector. The order of writes
is address, then data.

This is problematic if an interrupt comes in after address has
been written, but before data is updated, and both the SMP affinity
and target vector are being changed. In this case, the interrupt targets
the wrong vector on the new CPU.

This case is pretty easy to stumble into using xhci and CPU hotplugging.
Create a script that repeatedly targets interrupts at a set of cores and
then offlines those cores. Put some stress on USB, and then watch xhci
lose an interrupt and die.

Avoid this by disabling MSIs during the update.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
- Also mask msi-x interrupts during the update
- Restore the enable/mask bit to its previous value, rather than
unconditionally enabling interrupts


Bjorn,
I was unsure whether disabling MSIs temporarily is actually an okay
thing to do. I considered using the mask bit, but got the impression
that not all devices support the mask bit. Let me know if this going to
cause problems or there's a better way. I can include the repro
script I used to cause mayhem if needed.

---
 drivers/pci/msi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 6b43a5455c7af..bb21a7739fa2c 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -311,6 +311,7 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
+	u16 msgctl;
 
 	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
 		/* Don't touch the hardware now */
@@ -320,15 +321,25 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		if (!base)
 			goto skip;
 
+		pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
+				     &msgctl);
+
+		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
+				      msgctl | PCI_MSIX_FLAGS_MASKALL);
+
 		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
 		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
+		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
+				      msgctl);
+
 	} else {
 		int pos = dev->msi_cap;
-		u16 msgctl;
+		u16 enabled;
 
 		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
-		msgctl &= ~PCI_MSI_FLAGS_QSIZE;
+		enabled = msgctl & PCI_MSI_FLAGS_ENABLE;
+		msgctl &= ~(PCI_MSI_FLAGS_QSIZE | PCI_MSI_FLAGS_ENABLE);
 		msgctl |= entry->msi_attrib.multiple << 4;
 		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
 
@@ -343,6 +354,9 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
 					      msg->data);
 		}
+
+		msgctl |= enabled;
+		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
 	}
 
 skip:
-- 
2.24.1

