Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAFB10B02C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfK0N2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 08:28:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39837 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfK0N2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:28:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so680394wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
        b=bqeEfwiqk0IKUu+/s7/f4KVO2FRmMdw4XJ0fWLSmDH0To6KqDOOgO4XrlX3zZnuG7X
         6rR5jF2kApx7IBGq8ez5zVO0VljO3aEtwJozblGMlk/j3MszTPXVqJ+QZiH6LkijbL/5
         B/y0jiNBhHnx4cmlJrZaRaRs3XjtgcACB4oZATVNaAV2K8sPw72l4vN/8wisuQb7nCeL
         2FxRB5o1Tsz5cfFURBAFBPR3cfBac8nV42z10V5sUISiPdrELV46WirrSt8CDdtEv3i7
         EVtPD9Efq8eacJUUognqws7jWObIWGiXy2X1JMYtSfbi22+SS1yAQFR+4VAmkj2AnFYU
         P2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9ZkhQrbE0pqWo4Xrfbt5no2EyvavM8680V6oMcMbppE=;
        b=XrLKr70HuE7KGNAszDYZ4P7JzTA+4qb6eSLEzYwHWQYShodoUqV3A5IsdHSevb/GiE
         +Pl5ws0h3r1TQg8aZb+7GmmK+Ps8PoWU/pZ3v51T4YMfz/Bp+eJhkWwgbwGM6FocgjMN
         Jn1xDmRaEUEMhbRJf2w/ylV/rUrs3CPCnmCKsbjppddSuNBgdIwRUGNlDjkB2jKY7Df8
         bD4+YXH4WYz1uaqCT70wEafr5PrYX5nhD+bp6hIq7Al/aONGVl/clREzqt9buBAjvHA7
         WYpHrJSAz994HT9Hgxt+W49T/wnH3gQrTabQAv9gOUtuE1SmHdk0PNjzuPe5lV4hz1I0
         fGcw==
X-Gm-Message-State: APjAAAXzJFZOIg8U8PJq1FRJVCxDHWSwOabZSYiKMlXocPvmNQdZxWAz
        aPR4P2dlPU5RA1tuSnEXyRb/Lg==
X-Google-Smtp-Source: APXvYqwQ816W3GKWS10H6Ble2Ctbp4cU63fRLOyXrTZyx6yPK307q9gUbHR2eQPabyEVRDjo2i+RzQ==
X-Received: by 2002:a1c:2b82:: with SMTP id r124mr4492218wmr.112.1574861320452;
        Wed, 27 Nov 2019 05:28:40 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v15sm6609957wmh.24.2019.11.27.05.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 05:28:39 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v3 2/2] PCI: Add DMA alias quirk for PLX PEX NTB
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
Date:   Wed, 27 Nov 2019 13:28:36 +0000
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A7F2676-5BB0-4C37-B97C-E67021AD5EB1@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
To:     linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLX PEX NTB forwards DMA transactions using Requester ID's that
don't exist as PCI devices. The devfn for a transaction is used as an
index into a lookup table storing the origin of a transaction on the
other side of the bridge.

This patch aliases all possible devfn's to the NTB device so that any
transaction coming in is governed by the mappings for the NTB.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0f3f5afc73fd..3a67049ca630 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5315,6 +5315,21 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
 SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
 SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
=20
+/*
+ * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. =
These IDs
+ * are used to forward responses to the originator on the other side of =
the
+ * NTB. Alias all possible IDs to the NTB to permit access when the =
IOMMU is
+ * turned on.
+ */
+static void quirk_plx_ntb_dma_alias(struct pci_dev *pdev)
+{
+	pci_info(pdev, "Setting PLX NTB proxy ID aliases\n");
+	/* PLX NTB may use all 256 devfns */
+	pci_add_dma_alias(pdev, 0, 256);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b0, =
quirk_plx_ntb_dma_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b1, =
quirk_plx_ntb_dma_alias);
+
 /*
  * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS =
does
  * not always reset the secondary Nvidia GPU between reboots if the =
system
--=20
2.24.0

