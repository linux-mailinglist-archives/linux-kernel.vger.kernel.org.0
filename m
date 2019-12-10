Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781AF1186C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 12:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfLJLoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 06:44:24 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:39022 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727455AbfLJLoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:44:20 -0500
Received: from faui04g.informatik.uni-erlangen.de (faui04g.informatik.uni-erlangen.de [131.188.30.137])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 822D324183D;
        Tue, 10 Dec 2019 12:44:18 +0100 (CET)
Received: by faui04g.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 76D19843353; Tue, 10 Dec 2019 12:44:18 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v2 07/10] PCMCIA/i82092: shorten the lines with over 80 characters
Date:   Tue, 10 Dec 2019 12:43:32 +0100
Message-Id: <20191210114333.12239-8-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210114333.12239-1-simon.geis@fau.de>
References: <20191210114333.12239-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintain the Linux kernel coding style by splitting the lines
with over 80 characters. This also improves the readability of the code.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 72 +++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 33c242f06e0a..562e696a7156 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -70,7 +70,8 @@ static struct socket_info sockets[MAX_SOCKETS];
 static int socket_count;	/* shortcut */
 
 
-static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int i82092aa_pci_probe(struct pci_dev *dev,
+			      const struct pci_device_id *id)
 {
 	unsigned char configbyte;
 	int i, ret;
@@ -81,7 +82,9 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 	if (ret)
 		return ret;
 
-	pci_read_config_byte(dev, 0x40, &configbyte);  /* PCI Configuration Control */
+	/* PCI Configuration Control */
+	pci_read_config_byte(dev, 0x40, &configbyte);
+
 	switch (configbyte&6) {
 	case 0:
 		socket_count = 2;
@@ -122,15 +125,19 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 
 		if (card_present(i)) {
 			sockets[i].card_state = 3;
-			dev_dbg(&dev->dev, "i82092aa: slot %i is occupied\n", i);
+			dev_dbg(&dev->dev,
+				"i82092aa: slot %i is occupied\n", i);
 		} else {
 			dev_dbg(&dev->dev, "i82092aa: slot %i is vacant\n", i);
 		}
 	}
 
 	/* Now, specifiy that all interrupts are to be done as PCI interrupts */
-	configbyte = 0xFF; /* bitmask, one bit per event, 1 = PCI interrupt, 0 = ISA interrupt */
-	pci_write_config_byte(dev, 0x50, configbyte); /* PCI Interrupt Routing Register */
+	/* bitmask, one bit per event, 1 = PCI interrupt, 0 = ISA interrupt */
+	configbyte = 0xFF;
+
+	/* PCI Interrupt Routing Register */
+	pci_write_config_byte(dev, 0x50, configbyte);
 
 	/* Register the interrupt handler */
 	dev_dbg(&dev->dev, "Requesting interrupt %i\n", dev->irq);
@@ -252,7 +259,8 @@ static void indirect_setbit(int socket, unsigned short reg, unsigned char mask)
 }
 
 
-static void indirect_resetbit(int socket, unsigned short reg, unsigned char mask)
+static void indirect_resetbit(int socket,
+			      unsigned short reg, unsigned char mask)
 {
 	unsigned short int port;
 	unsigned char val;
@@ -269,7 +277,8 @@ static void indirect_resetbit(int socket, unsigned short reg, unsigned char mask
 	spin_unlock_irqrestore(&port_lock, flags);
 }
 
-static void indirect_write16(int socket, unsigned short reg, unsigned short value)
+static void indirect_write16(int socket,
+			     unsigned short reg, unsigned short value)
 {
 	unsigned short int port;
 	unsigned char val;
@@ -328,10 +337,12 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 		for (i = 0; i < socket_count; i++) {
 			int csc;
 
-			if (sockets[i].card_state == 0) /* Inactive socket, should not happen */
+			/* Inactive socket, should not happen */
+			if (sockets[i].card_state == 0)
 				continue;
 
-			csc = indirect_read(i, I365_CSC); /* card status change register */
+			/* card status change register */
+			csc = indirect_read(i, I365_CSC);
 
 			if (csc == 0)  /* no events on this socket */
 				continue;
@@ -346,12 +357,16 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 
 			if (indirect_read(i, I365_INTCTL) & I365_PC_IOCARD) {
 				/* For IO/CARDS, bit 0 means "read the card" */
-				events |= (csc & I365_CSC_STSCHG) ? SS_STSCHG : 0;
+				if (csc & I365_CSC_STSCHG)
+					events |= SS_STSCHG;
 			} else {
 				/* Check for battery/ready events */
-				events |= (csc & I365_CSC_BVD1) ? SS_BATDEAD : 0;
-				events |= (csc & I365_CSC_BVD2) ? SS_BATWARN : 0;
-				events |= (csc & I365_CSC_READY) ? SS_READY : 0;
+				if (csc & I365_CSC_BVD1)
+					events |= SS_BATDEAD;
+				if (csc & I365_CSC_BVD2)
+					events |= SS_BATWARN;
+				if (csc & I365_CSC_READY)
+					events |= SS_READY;
 			}
 
 			if (events)
@@ -435,7 +450,8 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 
 	enter("i82092aa_get_status");
 
-	status = indirect_read(sock, I365_STATUS); /* Interface Status Register */
+	/* Interface Status Register */
+	status = indirect_read(sock, I365_STATUS);
 	*value = 0;
 
 	if ((status & I365_CS_DETECT) == I365_CS_DETECT)
@@ -468,7 +484,8 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 }
 
 
-static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *state)
+static int i82092aa_set_socket(struct pcmcia_socket *socket,
+			       socket_state_t *state)
 {
 	struct socket_info *sock_info = container_of(socket, struct socket_info,
 						     socket);
@@ -484,12 +501,14 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 	/* Values for the IGENC register */
 
 	reg = 0;
-	if (!(state->flags & SS_RESET)) 	/* The reset bit has "inverse" logic */
+	/* The reset bit has "inverse" logic */
+	if (!(state->flags & SS_RESET))
 		reg = reg | I365_PC_RESET;
 	if (state->flags & SS_IOCARD)
 		reg = reg | I365_PC_IOCARD;
 
-	indirect_write(sock, I365_INTCTL, reg); /* IGENC, Interrupt and General Control Register */
+	/* IGENC, Interrupt and General Control Register */
+	indirect_write(sock, I365_INTCTL, reg);
 
 	/* Power registers */
 
@@ -567,7 +586,9 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 
 	}
 
-	/* now write the value and clear the (probably bogus) pending stuff by doing a dummy read*/
+	/* now write the value and clear the (probably bogus) pending stuff
+	 * by doing a dummy read
+	 */
 
 	indirect_write(sock, I365_CSCINT, reg);
 	(void)indirect_read(sock, I365_CSC);
@@ -576,7 +597,8 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 	return 0;
 }
 
-static int i82092aa_set_io_map(struct pcmcia_socket *socket, struct pccard_io_map *io)
+static int i82092aa_set_io_map(struct pcmcia_socket *socket,
+			       struct pccard_io_map *io)
 {
 	struct socket_info *sock_info = container_of(socket, struct socket_info,
 						     socket);
@@ -592,7 +614,8 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket, struct pccard_io_ma
 		leave("i82092aa_set_io_map with invalid map");
 		return -EINVAL;
 	}
-	if ((io->start > 0xffff) || (io->stop > 0xffff) || (io->stop < io->start)) {
+	if ((io->start > 0xffff) || (io->stop > 0xffff)
+				 || (io->stop < io->start)) {
 		leave("i82092aa_set_io_map with invalid io");
 		return -EINVAL;
 	}
@@ -625,9 +648,11 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket, struct pccard_io_ma
 	return 0;
 }
 
-static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_map *mem)
+static int i82092aa_set_mem_map(struct pcmcia_socket *socket,
+				struct pccard_mem_map *mem)
 {
-	struct socket_info *sock_info = container_of(socket, struct socket_info, socket);
+	struct socket_info *sock_info = container_of(socket, struct socket_info,
+						     socket);
 	unsigned int sock = sock_info->number;
 	struct pci_bus_region region;
 	unsigned short base, i;
@@ -648,8 +673,7 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 	     (mem->speed > 1000)) {
 		leave("i82092aa_set_mem_map: invalid address / speed");
 		dev_err(&sock_info->dev->dev,
-			"invalid mem map for socket %i: %llx to %llx with a "
-			"start of %x\n",
+			"invalid mem map for socket %i: %llx to %llx with a start of %x\n",
 			sock,
 			(unsigned long long)region.start,
 			(unsigned long long)region.end,
-- 
2.20.1

