Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695B511E4FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 14:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfLMNzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 08:55:55 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43742 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727490AbfLMNzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:55:55 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [131.188.30.136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 8F4DB2417CD;
        Fri, 13 Dec 2019 14:55:53 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 857C6C20BC7; Fri, 13 Dec 2019 14:55:53 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v3 06/10] PCMCIA/i82092: move assignment out of if condition
Date:   Fri, 13 Dec 2019 14:53:10 +0100
Message-Id: <20191213135311.9111-7-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213135311.9111-1-simon.geis@fau.de>
References: <20191213135311.9111-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability by moving the assignment out of if conditions.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 6b39750db282..ad105f9949c7 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -77,7 +77,8 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 
 	enter("i82092aa_pci_probe");
 
-	if ((ret = pci_enable_device(dev)))
+	ret = pci_enable_device(dev);
+	if (ret)
 		return ret;
 
 	pci_read_config_byte(dev, 0x40, &configbyte);  /* PCI Configuration Control */
@@ -133,7 +134,9 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 
 	/* Register the interrupt handler */
 	dev_dbg(&dev->dev, "Requesting interrupt %i\n", dev->irq);
-	if ((ret = request_irq(dev->irq, i82092aa_interrupt, IRQF_SHARED, "i82092aa", i82092aa_interrupt))) {
+	ret = request_irq(dev->irq, i82092aa_interrupt, IRQF_SHARED,
+			  "i82092aa", i82092aa_interrupt);
+	if (ret) {
 		dev_err(&dev->dev, "Failed to register IRQ %d, aborting\n",
 			dev->irq);
 		goto err_out_free_res;
-- 
2.20.1

