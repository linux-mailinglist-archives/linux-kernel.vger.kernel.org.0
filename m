Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A326C1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 22:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfGQUOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 16:14:16 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:42791 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGQUOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:14:16 -0400
Received: by mail-pg1-f172.google.com with SMTP id t132so11677823pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 13:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject;
        bh=wFwzYNfk1JLs61+QvfChsPFoRDh7IkRBsGRWO//WkXs=;
        b=JRXBNL/XKLpQQYJgQASYvBS3k2SnFhxKOOO6wmXPziwjkRxPc05fadukwdkl1sqlB9
         7WsLOaswhFf3UlfEdbLDdn3JNRpAWDBR/giFtn1G8fgqRkkI8YOjOnu6asjZ76MKvVjb
         ByuB7rifHvo9TFGK1aoQvLdEawkX8s0PogVhOMrorYqnSNrFTo56+iZtzg46L9ghuxhv
         kgj38Z/7WYXA7LravOMHRzwvyRgOiPUlA//vuFFtSCu1bW1s+SI4nnQ4ZbqfCdnoLG9U
         CgslAwSNe+wV0+T7ijq10VRSG7HFZH3rhVldEmr+9t0xkErudjHvEl9dP4MmAW7pylqq
         q1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject;
        bh=wFwzYNfk1JLs61+QvfChsPFoRDh7IkRBsGRWO//WkXs=;
        b=rhlQXBRpzpmhRtDZCYZVAzRoUw1Z6iSanB6IoQE0eYq6AbeYMpYfIbuunCmC+PF6C0
         2reuSG2ZBmOyM6RW5pi9worVvZV4ZjY0qwXm29ZOrzHt10tajRHUzOQSznbb+tYvJ3J9
         SndlQTi4/ai+eDWZZgl0GaU/sLq54Z6j/l+5M5szxUvM0DSY6+y7VBtQc/5dbqqIIaZp
         fncPFB5Bt5K8Xl4ly+VtAaB8HISBt5taI8SRK7C1VACsshmyufMeJ8/GeQVuuyot9LGx
         bFlW1iQDnliIpvW31LxdtFe6qm/cMYGyWCxztcD1mcIg2vVhX67wEzWopkidsNoHBCSj
         /LXQ==
X-Gm-Message-State: APjAAAW0rt4Uba8l2RhOvA9sp90L+nD8/AssECUpF+waxas89zc7wqyK
        wbwlko4uFEYbhAB4P8e0Y84=
X-Google-Smtp-Source: APXvYqy/woNeUlPXQR+AL23HT2kOTiLNljpcuYfQtLjE2liT0zC277R3mXOk75a4eFPcwDPaaLJleA==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr46205261pjv.95.1563394455309;
        Wed, 17 Jul 2019 13:14:15 -0700 (PDT)
Received: from localhost ([103.70.83.110])
        by smtp.gmail.com with ESMTPSA id c26sm24020613pfr.172.2019.07.17.13.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 13:14:14 -0700 (PDT)
Message-ID: <5d2f8196.1c69fb81.958e6.3bdd@mx.google.com>
From:   Abhishek Upperwal <a.upperwal@gmail.com>
Date:   Thu, 18 Jul 2019 00:44:20 +0530
Subject: [PATCH] Drivers: tty: cyclades: Fixed coding style issues
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected multi-line comment formats

Signed-off-by: Abhishek Upperwal <a.upperwal@gmail.com>
---
 drivers/tty/cyclades.c | 181 +++++++++++++++++++++++------------------
 1 file changed, 100 insertions(+), 81 deletions(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 4562c8060d09..760c4b2b4ea6 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -23,15 +23,17 @@
 #define CY_VERSION	"2.6"
 
 /* If you need to install more boards than NR_CARDS, change the constant
-   in the definition below. No other change is necessary to support up to
-   eight boards. Beyond that you'll have to extend cy_isa_addresses. */
+ * in the definition below. No other change is necessary to support up to
+ * eight boards. Beyond that you'll have to extend cy_isa_addresses.
+ */
 
 #define NR_CARDS	4
 
 /*
-   If the total number of ports is larger than NR_PORTS, change this
-   constant in the definition below. No other change is necessary to
-   support more boards/ports. */
+ * If the total number of ports is larger than NR_PORTS, change this
+ * constant in the definition below. No other change is necessary to
+ * support more boards/ports.
+ */
 
 #define NR_PORTS	256
 
@@ -368,7 +370,8 @@ static int __cyy_issue_cmd(void __iomem *base_addr, u8 cmd, int index)
 		udelay(10L);
 	}
 	/* if the CCR never cleared, the previous command
-	   didn't finish within the "reasonable time" */
+	 * didn't finish within the "reasonable time"
+	 */
 	if (i == 100)
 		return -1;
 
@@ -529,7 +532,8 @@ static void cyy_chip_rx(struct cyclades_card *cinfo, int chip,
 			}
 		} else {
 			/* there was a software buffer overrun and nothing
-			 * could be done about it!!! */
+			 * could be done about it!!!
+			 */
 			info->icount.buf_overrun++;
 			info->idle_stats.overruns++;
 		}
@@ -572,8 +576,9 @@ static void cyy_chip_tx(struct cyclades_card *cinfo, unsigned int chip,
 	u8 save_xir, channel, save_car, outch;
 
 	/* Since we only get here when the transmit buffer
-	   is empty, we know we can always stuff a dozen
-	   characters. */
+	 * is empty, we know we can always stuff a dozen
+	 * characters.
+	 */
 #ifdef CY_DEBUG_INTERRUPTS
 	printk(KERN_DEBUG "cyy_interrupt: xmit intr, chip %d\n", chip);
 #endif
@@ -722,7 +727,8 @@ static void cyy_chip_modem(struct cyclades_card *cinfo, int chip,
 		if (tty->hw_stopped) {
 			if (mdm_status & CyCTS) {
 				/* cy_start isn't used
-				   because... !!! */
+				 * because... !!!
+				 */
 				tty->hw_stopped = 0;
 				cyy_writeb(info, CySRER,
 					cyy_readb(info, CySRER) | CyTxRdy);
@@ -731,7 +737,8 @@ static void cyy_chip_modem(struct cyclades_card *cinfo, int chip,
 		} else {
 			if (!(mdm_status & CyCTS)) {
 				/* cy_stop isn't used
-				   because ... !!! */
+				 * because ... !!!
+				 */
 				tty->hw_stopped = 1;
 				cyy_writeb(info, CySRER,
 					cyy_readb(info, CySRER) & ~CyTxRdy);
@@ -739,9 +746,10 @@ static void cyy_chip_modem(struct cyclades_card *cinfo, int chip,
 		}
 	}
 /*	if (mdm_change & CyDSR) {
-	}
-	if (mdm_change & CyRI) {
-	}*/
+ *	}
+ *	if (mdm_change & CyRI) {
+ *	}
+ */
 	tty_kref_put(tty);
 end:
 	/* end of service */
@@ -750,8 +758,8 @@ static void cyy_chip_modem(struct cyclades_card *cinfo, int chip,
 }
 
 /* The real interrupt service routine is called
-   whenever the card wants its hand held--chars
-   received, out buffer empty, modem change, etc.
+ * whenever the card wants its hand held--chars
+ * received, out buffer empty, modem change, etc.
  */
 static irqreturn_t cyy_interrupt(int irq, void *dev_id)
 {
@@ -777,9 +785,9 @@ static irqreturn_t cyy_interrupt(int irq, void *dev_id)
 		return IRQ_HANDLED;
 
 	/* This loop checks all chips in the card.  Make a note whenever
-	   _any_ chip had some work to do, as this is considered an
-	   indication that there will be more to do.  Only when no chip
-	   has any work does this outermost loop exit.
+	 * _any_ chip had some work to do, as this is considered an
+	 * indication that there will be more to do.  Only when no chip
+	 * has any work does this outermost loop exit.
 	 */
 	do {
 		had_work = 0;
@@ -791,9 +799,9 @@ static irqreturn_t cyy_interrupt(int irq, void *dev_id)
 						(CySVRR << index))) != 0x00) {
 				had_work++;
 			/* The purpose of the following test is to ensure that
-			   no chip can monopolize the driver.  This forces the
-			   chips to be checked in a round-robin fashion (after
-			   draining each of a bunch (1000) of characters).
+			 * no chip can monopolize the driver.  This forces the
+			 * chips to be checked in a round-robin fashion (after
+			 * draining each of a bunch (1000) of characters).
 			 */
 				if (1000 < too_many++)
 					break;
@@ -951,8 +959,9 @@ static void cyz_handle_rx(struct cyclades_port *info)
 
 #ifdef BLOCKMOVE
 	/* we'd like to use memcpy(t, f, n) and memset(s, c, count)
-	   for performance, but because of buffer boundaries, there
-	   may be several steps to the operation */
+	 * for performance, but because of buffer boundaries, there
+	 * may be several steps to the operation
+	 */
 	while (1) {
 		len = tty_prepare_flip_string(port, &buf,
 				char_count);
@@ -985,7 +994,8 @@ static void cyz_handle_rx(struct cyclades_port *info)
 #endif
 #ifdef CONFIG_CYZ_INTR
 	/* Recalculate the number of chars in the RX buffer and issue
-	   a cmd in case it's higher than the RX high water mark */
+	 * a cmd in case it's higher than the RX high water mark
+	 */
 	rx_put = readl(&buf_ctrl->rx_put);
 	if (rx_put >= rx_get)
 		char_count = rx_put - rx_get;
@@ -1028,7 +1038,7 @@ static void cyz_handle_tx(struct cyclades_port *info)
 
 	if (!char_count)
 		return;
-		
+
 	tty = tty_port_tty_get(&info->port);
 	if (tty == NULL)
 		goto ztxdone;
@@ -1441,7 +1451,8 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 
 		cyy_issue_cmd(info, CyCHAN_CTL | CyDIS_RCVR);
 		/* it may be appropriate to clear _XMIT at
-		   some later date (after testing)!!! */
+		 * some later date (after testing)!!!
+		 */
 
 		set_bit(TTY_IO_ERROR, &tty->flags);
 		tty_port_set_initialized(&info->port, 0);
@@ -1530,8 +1541,9 @@ static int cy_open(struct tty_struct *tty, struct file *filp)
 #ifdef CONFIG_CYZ_INTR
 		else {
 		/* In case this Z board is operating in interrupt mode, its
-		   interrupts should be enabled as soon as the first open
-		   happens to one of its ports. */
+		 * interrupts should be enabled as soon as the first open
+		 * happens to one of its ports.
+		 */
 			if (!cinfo->intr_enabled) {
 				u16 intr;
 
@@ -1709,7 +1721,8 @@ static void cy_do_close(struct tty_port *port)
 		cyy_writeb(info, CySRER, cyy_readb(info, CySRER) & ~CyRxData);
 		if (tty_port_initialized(&info->port)) {
 			/* Waiting for on-board buffers to be empty before
-			   closing the port */
+			 * closing the port
+			 */
 			spin_unlock_irqrestore(&card->card_lock, flags);
 			cy_wait_until_sent(port->tty, info->timeout);
 			spin_lock_irqsave(&card->card_lock, flags);
@@ -1717,7 +1730,8 @@ static void cy_do_close(struct tty_port *port)
 	} else {
 #ifdef Z_WAKE
 		/* Waiting for on-board buffers to be empty before closing
-		   the port */
+		 * the port
+		 */
 		struct CH_CTRL __iomem *ch_ctrl = info->u.cyz.ch_ctrl;
 		int retval;
 
@@ -2031,8 +2045,9 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 			info->timeout = 0;
 		}
 		/* By tradition (is it a standard?) a baud rate of zero
-		   implies the line should be/has been closed.  A bit
-		   later in this routine such a test is performed. */
+		 * implies the line should be/has been closed.  A bit
+		 * later in this routine such a test is performed.
+		 */
 
 		/* byte size and parity */
 		info->cor5 = 0;
@@ -2212,7 +2227,8 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 					~(C_RS_CTS | C_RS_RTS));
 		}
 		/* As the HW flow control is done in firmware, the driver
-		   doesn't need to care about it */
+		 * doesn't need to care about it
+		 */
 		tty_port_set_cts_flow(&info->port, 0);
 
 		/* XON/XOFF/XANY flow control flags */
@@ -2297,8 +2313,7 @@ static int cy_set_serial_info(struct tty_struct *tty,
 				ss->baud_base != info->baud ||
 				(ss->flags & ASYNC_FLAGS &
 					~ASYNC_USR_MASK) !=
-				(info->port.flags & ASYNC_FLAGS & ~ASYNC_USR_MASK))
-		{
+				(info->port.flags & ASYNC_FLAGS & ~ASYNC_USR_MASK)) {
 			mutex_unlock(&info->port.mutex);
 			return -EPERM;
 		}
@@ -2491,7 +2506,7 @@ static int cy_break(struct tty_struct *tty, int break_state)
 	spin_lock_irqsave(&card->card_lock, flags);
 	if (!cy_is_Z(card)) {
 		/* Let the transmit ISR take care of this (since it
-		   requires stuffing characters into the output stream).
+		 * requires stuffing characters into the output stream).
 		 */
 		if (break_state == -1) {
 			if (!info->breakon) {
@@ -3140,7 +3155,8 @@ static int cy_init_card(struct cyclades_card *cinfo)
 }
 
 /* initialize chips on Cyclom-Y card -- return number of valid
-   chips (which is number of ports/4) */
+ * chips (which is number of ports/4)
+ */
 static unsigned short cyy_init_card(void __iomem *true_base_addr,
 		int index)
 {
@@ -3160,9 +3176,9 @@ static unsigned short cyy_init_card(void __iomem *true_base_addr,
 		mdelay(1);
 		if (readb(base_addr + (CyCCR << index)) != 0x00) {
 			/*************
-			printk(" chip #%d at %#6lx is never idle (CCR != 0)\n",
-			chip_number, (unsigned long)base_addr);
-			*************/
+			 * printk(" chip #%d at %#6lx is never idle (CCR != 0)\n",
+			 * chip_number, (unsigned long)base_addr);
+			 *************/
 			return chip_number;
 		}
 
@@ -3170,10 +3186,10 @@ static unsigned short cyy_init_card(void __iomem *true_base_addr,
 		udelay(10L);
 
 		/* The Cyclom-16Y does not decode address bit 9 and therefore
-		   cannot distinguish between references to chip 0 and a non-
-		   existent chip 4.  If the preceding clearing of the supposed
-		   chip 4 GFRCR register appears at chip 0, there is no chip 4
-		   and this must be a Cyclom-16Y, not a Cyclom-32Ye.
+		 * cannot distinguish between references to chip 0 and a non-
+		 * existent chip 4.  If the preceding clearing of the supposed
+		 * chip 4 GFRCR register appears at chip 0, there is no chip 4
+		 * and this must be a Cyclom-16Y, not a Cyclom-32Ye.
 		 */
 		if (chip_number == 4 && readb(true_base_addr +
 				(cy_chip_offset[0] << index) +
@@ -3186,19 +3202,19 @@ static unsigned short cyy_init_card(void __iomem *true_base_addr,
 
 		if (readb(base_addr + (CyGFRCR << index)) == 0x00) {
 			/*
-			   printk(" chip #%d at %#6lx is not responding ",
-			   chip_number, (unsigned long)base_addr);
-			   printk("(GFRCR stayed 0)\n",
+			 * printk(" chip #%d at %#6lx is not responding ",
+			 * chip_number, (unsigned long)base_addr);
+			 * printk("(GFRCR stayed 0)\n",
 			 */
 			return chip_number;
 		}
 		if ((0xf0 & (readb(base_addr + (CyGFRCR << index)))) !=
 				0x40) {
 			/*
-			printk(" chip #%d at %#6lx is not valid (GFRCR == "
-					"%#2x)\n",
-					chip_number, (unsigned long)base_addr,
-					base_addr[CyGFRCR<<index]);
+			 * printk(" chip #%d at %#6lx is not valid (GFRCR == "
+			 *		"%#2x)\n",
+			 *		chip_number, (unsigned long)base_addr,
+			 *		base_addr[CyGFRCR<<index]);
 			 */
 			return chip_number;
 		}
@@ -3206,7 +3222,8 @@ static unsigned short cyy_init_card(void __iomem *true_base_addr,
 		if (readb(base_addr + (CyGFRCR << index)) >= CD1400_REV_J) {
 			/* It is a CD1400 rev. J or later */
 			/* Impossible to reach 5ms with this chip.
-			   Changed to 2ms instead (f = 500 Hz). */
+			 * Changed to 2ms instead (f = 500 Hz).
+			 */
 			cy_writeb(base_addr + (CyPPR << index), CyCLOCK_60_2MS);
 		} else {
 			/* f = 200 Hz */
@@ -3214,9 +3231,9 @@ static unsigned short cyy_init_card(void __iomem *true_base_addr,
 		}
 
 		/*
-		   printk(" chip #%d at %#6lx is rev 0x%2x\n",
-		   chip_number, (unsigned long)base_addr,
-		   readb(base_addr+(CyGFRCR<<index)));
+		 * printk(" chip #%d at %#6lx is rev 0x%2x\n",
+		 * chip_number, (unsigned long)base_addr,
+		 * readb(base_addr+(CyGFRCR<<index)));
 		 */
 	}
 	return chip_number;
@@ -3490,7 +3507,8 @@ static int cyz_load_fw(struct pci_dev *pdev, void __iomem *base_addr,
 	}
 
 	/* Check whether the firmware is already loaded and running. If
-	   positive, skip this board */
+	 * positive, skip this board
+	 */
 	if (__cyz_fpga_loaded(ctl_addr) && readl(&fid->signature) == ZFIRM_ID) {
 		u32 cntval = readl(base_addr + 0x190);
 
@@ -3622,8 +3640,8 @@ static int cyz_load_fw(struct pci_dev *pdev, void __iomem *base_addr,
 	cy_writel(&pt_zfwctrl->board_ctrl.dr_version, DRIVER_VERSION);
 
 	/*
-	   Early firmware failed to start looking for commands.
-	   This enables firmware interrupts for those commands.
+	 * Early firmware failed to start looking for commands.
+	 * This enables firmware interrupts for those commands.
 	 */
 	cy_writel(&ctl_addr->intr_ctrl_stat, readl(&ctl_addr->intr_ctrl_stat) |
 			(1 << 17));
@@ -3754,8 +3772,8 @@ static int cy_pci_probe(struct pci_dev *pdev,
 			}
 #endif
 			/* The following clears the firmware id word.  This
-			   ensures that the driver will not attempt to talk to
-			   the board until it has been properly initialized.
+			 * ensures that the driver will not attempt to talk to
+			 * the board until it has been properly initialized.
 			 */
 			if ((mailbox == ZO_V1) || (mailbox == ZO_V2))
 				cy_writel(addr2 + ID_ADDRESS, 0L);
@@ -3968,21 +3986,21 @@ static int cyclades_proc_show(struct seq_file *m, void *v)
 }
 
 /* The serial driver boot-time initialization code!
-    Hardware I/O ports are mapped to character special devices on a
-    first found, first allocated manner.  That is, this code searches
-    for Cyclom cards in the system.  As each is found, it is probed
-    to discover how many chips (and thus how many ports) are present.
-    These ports are mapped to the tty ports 32 and upward in monotonic
-    fashion.  If an 8-port card is replaced with a 16-port card, the
-    port mapping on a following card will shift.
-
-    This approach is different from what is used in the other serial
-    device driver because the Cyclom is more properly a multiplexer,
-    not just an aggregation of serial ports on one card.
-
-    If there are more cards with more ports than have been
-    statically allocated above, a warning is printed and the
-    extra ports are ignored.
+ *  Hardware I/O ports are mapped to character special devices on a
+ *  first found, first allocated manner.  That is, this code searches
+ *  for Cyclom cards in the system.  As each is found, it is probed
+ *  to discover how many chips (and thus how many ports) are present.
+ *  These ports are mapped to the tty ports 32 and upward in monotonic
+ *  fashion.  If an 8-port card is replaced with a 16-port card, the
+ *  port mapping on a following card will shift.
+ *
+ *  This approach is different from what is used in the other serial
+ *  device driver because the Cyclom is more properly a multiplexer,
+ *  not just an aggregation of serial ports on one card.
+ *
+ *  If there are more cards with more ports than have been
+ *  statically allocated above, a warning is printed and the
+ *  extra ports are ignored.
  */
 
 static const struct tty_operations cy_ops = {
@@ -4043,11 +4061,12 @@ static int __init cy_init(void)
 	}
 
 	/* the code below is responsible to find the boards. Each different
-	   type of board has its own detection routine. If a board is found,
-	   the next cy_card structure available is set by the detection
-	   routine. These functions are responsible for checking the
-	   availability of cy_card and cy_port data structures and updating
-	   the cy_next_channel. */
+	 * type of board has its own detection routine. If a board is found,
+	 * the next cy_card structure available is set by the detection
+	 * routine. These functions are responsible for checking the
+	 * availability of cy_card and cy_port data structures and updating
+	 * the cy_next_channel.
+	 */
 
 	/* look for isa boards */
 	nboards = cy_detect_isa();
-- 
2.17.1

