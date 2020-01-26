Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7C7149A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 13:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgAZMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 07:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387403AbgAZMdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 07:33:23 -0500
Received: from ziggy.de (unknown [95.169.235.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5AA2071A;
        Sun, 26 Jan 2020 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580042002;
        bh=jiPyg4xMYng3XTyef+gtnfbqk1VNKvF8MyDPzuNMtWU=;
        h=From:To:Cc:Subject:Date:From;
        b=oY/V6N+Bk295aS5GBBQ4hYmTuZJaC2Ikx3wC+D4nFi0kXAvZTX1gTtF0TS0ljn4r0
         Rhw8kURC/bEaPBnvaduzUuX751qYa/n9Dacm6ArLhMp+CYfDfnMbwZdqwmWbJoKqV3
         BJgFkNHZb6mcfOsRROAYBekXYeC0mxv6U2x4NQmE=
From:   matthias.bgg@kernel.org
To:     gregkh@linuxfoundation.org, jslaby@suse.com, nsaenzjulienne@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@kernel.org,
        Matthias Brugger <mbrugger@suse.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH] serial: 8250_early: Add earlycon for BCM2835 aux uart
Date:   Sun, 26 Jan 2020 13:33:14 +0100
Message-Id: <20200126123314.3558-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Define the OF early console for BCM2835 aux UART, which can be enabled
by passing "earlycon" on the boot command line. This UART is found on
BCM283x and BCM27xx SoCs, a.k.a. Raspberry Pi in its variants.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

 drivers/tty/serial/8250/8250_bcm2835aux.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 8ce700c1a7fc..6769cea2964a 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -135,6 +135,24 @@ static struct platform_driver bcm2835aux_serial_driver = {
 };
 module_platform_driver(bcm2835aux_serial_driver);
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+
+static int __init early_bcm2835aux_setup(struct earlycon_device *device,
+					const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->port.iotype = UPIO_MEM32;
+	device->port.regshift = 2;
+
+	return early_serial8250_setup(device, NULL);
+}
+
+OF_EARLYCON_DECLARE(bcm2835aux, "brcm,bcm2835-aux-uart",
+		    early_bcm2835aux_setup);
+#endif
+
 MODULE_DESCRIPTION("BCM2835 auxiliar UART driver");
 MODULE_AUTHOR("Martin Sperl <kernel@martin.sperl.org>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.1

