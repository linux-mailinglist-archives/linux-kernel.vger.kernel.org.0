Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FD611017A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 16:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLCPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 10:43:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42591 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLCPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:43:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id i5so1830812pgj.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 07:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0yrezSoKQkZrqqXO+MRmZeqhnUphohMCxV+BQiWKsKQ=;
        b=pCf1Kw4Gks8fNDyj/+JVoEQ1ETlg4fbVm+wqjBiURZIpG2huqsFqho2YSno4wx0Zad
         Tw8btFUTbqavHf+LPIvr8HdOYaQtScGWoqorzP31k7EoK1ykZZs5/wKY8n1mmlrzAuoW
         owNY23LECGp2aTOCO1PeVYDD+RNSpXEMy9KCW3uX+D6WuwUfO+F8fbrYRVLb2Pb2iTaT
         1RrO/dMaGqXb9lY+Hy/jh4GPCbXteD0gItgtVGzgcwqx52e3u1PSMtSGjcaoyX5cLLNK
         K1xVC9C85pMx4O43Keie03f8mn0cps+Bh7cnT+jBsdx97EkLkWtcfDYbENavcZuwpRa0
         HN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0yrezSoKQkZrqqXO+MRmZeqhnUphohMCxV+BQiWKsKQ=;
        b=ktAmxw/b9iJ7zpkG/N5vyd0T4uQUA8833/A+/9ipycqedBjyuTm4sZJgcPvH1KWTV7
         aaCJ11ea0+MXy1MEP4qcHq8EwGbzBQyRV+jSf2XpC1VVPc7CNiksEhBoutrxlFQMx7aY
         +uCpC7DWDk1YXnhiqQxf278vtDQ9pdacxooX1A94L6xdS8SqoEACoBFEJ/tirviPpKzV
         o8sCW9jH3u7JhQYKHyvKuh1VJ5m7eRSqqpm4QIirO1q9bXEmTKrg+UDAa4bO6fryx10q
         7JTZGEYLaix8aks8n+/Y7KiLmU9GlZ/be9glQRsCR7i/xKmCeAxTMjasEw/YsQDcXLeJ
         L23Q==
X-Gm-Message-State: APjAAAVpySZ/s796s6+x6/XolesyBWV2zjiLjpgtjcxrPUYKtoumqBwg
        k2DSmaeOu014R/NY0U6XP7zphw==
X-Google-Smtp-Source: APXvYqy0h4ohq131IAQX2BVAHLY9hISqN0ZddcWAJ7wET//NltDdx5JTsU1Ve5Xzc2ejNLz5DzaUJg==
X-Received: by 2002:a62:5103:: with SMTP id f3mr5589159pfb.184.1575387836057;
        Tue, 03 Dec 2019 07:43:56 -0800 (PST)
Received: from [10.83.42.232] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e11sm3953969pgh.54.2019.12.03.07.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 07:43:55 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v6 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <910070E3-7964-4549-B77F-EC7FC6144503@arista.com>
Date:   Tue, 3 Dec 2019 15:43:53 +0000
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
References: <910070E3-7964-4549-B77F-EC7FC6144503@arista.com>
To:     linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_add_dma_alias can now be used to create a dma alias for a range of
devfns.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/pci.c    | 22 +++++++++++++++++-----
 drivers/pci/quirks.c | 14 +++++++-------
 include/linux/pci.h  |  2 +-
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d3c83248f3ce..dbb01aceafda 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5857,7 +5857,8 @@ int pci_set_vga_state(struct pci_dev *dev, bool =
decode,
 /**
  * pci_add_dma_alias - Add a DMA devfn alias for a device
  * @dev: the PCI device for which alias is added
- * @devfn: alias slot and function
+ * @devfn_from: alias slot and function
+ * @nr_devfns: Number of subsequent devfns to alias
  *
  * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
  * which is used to program permissible bus-devfn source addresses for =
DMA
@@ -5873,8 +5874,13 @@ int pci_set_vga_state(struct pci_dev *dev, bool =
decode,
  * cannot be left as a userspace activity).  DMA aliases should =
therefore
  * be configured via quirks, such as the PCI fixup header quirk.
  */
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned =
nr_devfns)
 {
+	int devfn_to;
+
+	nr_devfns =3D min(nr_devfns, (unsigned)MAX_NR_DEVFNS);
+	devfn_to =3D devfn_from + nr_devfns - 1;
+
 	if (!dev->dma_alias_mask)
 		dev->dma_alias_mask =3D bitmap_zalloc(MAX_NR_DEVFNS, =
GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
@@ -5882,9 +5888,15 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 =
devfn)
 		return;
 	}
=20
-	set_bit(devfn, dev->dma_alias_mask);
-	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
-		 PCI_SLOT(devfn), PCI_FUNC(devfn));
+	bitmap_set(dev->dma_alias_mask, devfn_from, nr_devfns);
+
+	if (nr_devfns =3D=3D 1)
+		pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
+				PCI_SLOT(devfn_from), =
PCI_FUNC(devfn_from));
+	else if(nr_devfns > 1)
+		pci_info(dev, "Enabling fixed DMA alias for devfn range =
from %02x.%d to %02x.%d\n",
+				PCI_SLOT(devfn_from), =
PCI_FUNC(devfn_from),
+				PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
 }
=20
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev =
*dev2)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 320255e5e8f8..0f3f5afc73fd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3932,7 +3932,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, =
int probe)
 static void quirk_dma_func0_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) !=3D 0)
-		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
0));
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
0), 1);
 }
=20
 /*
@@ -3946,7 +3946,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, =
0xe476, quirk_dma_func0_alias);
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) !=3D 1)
-		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
1));
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
1), 1);
 }
=20
 /*
@@ -4031,7 +4031,7 @@ static void quirk_fixed_dma_alias(struct pci_dev =
*dev)
=20
 	id =3D pci_match_id(fixed_dma_alias_tbl, dev);
 	if (id)
-		pci_add_dma_alias(dev, id->driver_data);
+		pci_add_dma_alias(dev, id->driver_data, 1);
 }
=20
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285, =
quirk_fixed_dma_alias);
@@ -4073,9 +4073,9 @@ DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, =
quirk_use_pcie_bridge_dma_alias);
  */
 static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
 {
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0), 1);
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0), 1);
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3), 1);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, =
quirk_mic_x200_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, =
quirk_mic_x200_dma_alias);
@@ -5273,7 +5273,7 @@ static void quirk_switchtec_ntb_dma_alias(struct =
pci_dev *pdev)
 			pci_dbg(pdev,
 				"Aliasing Partition %d Proxy ID =
%02x.%d\n",
 				pp, PCI_SLOT(devfn), PCI_FUNC(devfn));
-			pci_add_dma_alias(pdev, devfn);
+			pci_add_dma_alias(pdev, devfn, 1);
 		}
 	}
=20
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6481da29d667..e7a9c8c92a93 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2325,7 +2325,7 @@ static inline struct eeh_dev =
*pci_dev_to_eeh_dev(struct pci_dev *pdev)
 }
 #endif
=20
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned =
nr_devfns);
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev =
*dev2);
 int pci_for_each_dma_alias(struct pci_dev *pdev,
 			   int (*fn)(struct pci_dev *pdev,
--=20
2.24.0

