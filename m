Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9068155582
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 11:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBGKUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 05:20:01 -0500
Received: from fudo.makrotopia.org ([185.142.180.71]:44859 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgBGKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:20:01 -0500
X-Greylist: delayed 1562 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Feb 2020 05:20:00 EST
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.92.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1j00Kg-0002ET-JY; Fri, 07 Feb 2020 10:53:56 +0100
Date:   Fri, 7 Feb 2020 11:53:35 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Eitan Cohen <eitan@neot-semadar.com>,
        Ori Gofen <origofen@gmail.com>
Subject: [PATCH] serial: ar933x_uart: set UART_CS_{RX,TX}_READY_ORIDE
Message-ID: <20200207095335.GA179836@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AR934x this UART is usually not initialized by the bootloader
as it is only used as a secondary serial port while the primary
UART is a newly introduced NS16550-compatible.
In order to make use of the ar933x-uart on AR934x without RTS/CTS
hardware flow control, one needs to set the
UART_CS_{RX,TX}_READY_ORIDE bits as other than on AR933x where this
UART is used as primary/console, the bootloader on AR934x typically
doesn't set those bits.
Setting them explicitely on AR933x should not do any harm, so just
set them unconditionally.

Tested-by: Chuanhong Guo <gch981213@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/tty/serial/ar933x_uart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -328,6 +328,10 @@ static void ar933x_uart_set_termios(stru
 	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
 			    AR933X_UART_CS_HOST_INT_EN);
 
+	/* enable RX and TX ready overide */
+	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
+		AR933X_UART_CS_TX_READY_ORIDE | AR933X_UART_CS_RX_READY_ORIDE);
+
 	/* reenable the UART */
 	ar933x_uart_rmw(up, AR933X_UART_CS_REG,
 			AR933X_UART_CS_IF_MODE_M << AR933X_UART_CS_IF_MODE_S,
@@ -460,6 +464,10 @@ static int ar933x_uart_startup(struct ua
 	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
 			    AR933X_UART_CS_HOST_INT_EN);
 
+	/* enable RX and TX ready overide */
+	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
+		AR933X_UART_CS_TX_READY_ORIDE | AR933X_UART_CS_RX_READY_ORIDE);
+
 	/* Enable RX interrupts */
 	up->ier = AR933X_UART_INT_RX_VALID;
 	ar933x_uart_write(up, AR933X_UART_INT_EN_REG, up->ier);
