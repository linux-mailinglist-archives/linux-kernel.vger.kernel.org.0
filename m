Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E511186BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 12:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLJLoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 06:44:11 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:38948 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbfLJLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:44:08 -0500
Received: from faui04g.informatik.uni-erlangen.de (faui04g.informatik.uni-erlangen.de [131.188.30.137])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 5F1CC241838;
        Tue, 10 Dec 2019 12:44:07 +0100 (CET)
Received: by faui04g.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 53934843353; Tue, 10 Dec 2019 12:44:07 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v2 03/10] PCMCIA/i82092: remove braces around single statement blocks
Date:   Tue, 10 Dec 2019 12:43:28 +0100
Message-Id: <20191210114333.12239-4-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210114333.12239-1-simon.geis@fau.de>
References: <20191210114333.12239-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces around single statement blocks in order to
maintain the Linux kernel coding style.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 2f698d021411..0adac6b24915 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -145,9 +145,8 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		sockets[i].socket.ops = &i82092aa_operations;
 		sockets[i].socket.resource_ops = &pccard_nonstatic_ops;
 		ret = pcmcia_register_socket(&sockets[i].socket);
-		if (ret) {
+		if (ret)
 			goto err_out_free_sockets;
-		}
 	}
 
 	leave("i82092aa_pci_probe");
@@ -155,9 +154,8 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 
 err_out_free_sockets:
 	if (i) {
-		for (i--; i >= 0; i--) {
+		for (i--; i >= 0; i--)
 			pcmcia_unregister_socket(&sockets[i].socket);
-		}
 	}
 	free_irq(dev->irq, i82092aa_interrupt);
 err_out_free_res:
@@ -346,9 +344,8 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 				events |= (csc & I365_CSC_READY) ? SS_READY : 0;
 			}
 
-			if (events) {
+			if (events)
 				pcmcia_parse_events(&sockets[i].socket, events);
-			}
 			active |= events;
 		}
 
@@ -430,9 +427,8 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 	status = indirect_read(sock, I365_STATUS); /* Interface Status Register */
 	*value = 0;
 
-	if ((status & I365_CS_DETECT) == I365_CS_DETECT) {
+	if ((status & I365_CS_DETECT) == I365_CS_DETECT)
 		*value |= SS_DETECT;
-	}
 
 	/* IO cards have a different meaning of bits 0,1 */
 	/* Also notice the inverse-logic on the bits */
@@ -545,9 +541,8 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 	/* Enable specific interrupt events */
 
 	reg = 0x00;
-	if (state->csc_mask & SS_DETECT) {
+	if (state->csc_mask & SS_DETECT)
 		reg |= I365_CSC_DETECT;
-	}
 	if (state->flags & SS_IOCARD) {
 		if (state->csc_mask & SS_STSCHG)
 			reg |= I365_CSC_STSCHG;
-- 
2.20.1

