Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F4916924F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 00:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgBVXcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 18:32:13 -0500
Received: from vps.xff.cz ([195.181.215.36]:34226 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgBVXcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 18:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582414331; bh=IxjYsKuZde7SyqZ/SuCk3wb/xdZPGdl9V7ADWU7YqlM=;
        h=From:To:Cc:Subject:Date:From;
        b=MU6t6luDIt1l6QHL4PTsN72GySLrOmLilLguUWlKy9fX39bngBYaIR1Hq53GIXCSQ
         v21eevbB0PMRplPJbKyT4bQXB8gJ/FUFkkMJW7q2gQtvKpCQinTUfkNZaGOjJ4HLq0
         PN/s4/b/TXDhYbKNXTJsvqnMOVvIM+A0dNGZlQfg=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-usb@vger.kernel.org
Cc:     Ondrej Jirman <megous@megous.com>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Support Castles Vega5000 PoS terminal USB
Date:   Sun, 23 Feb 2020 00:32:02 +0100
Message-Id: <20200222233202.237967-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This terminal's USB port needs NO_UNION_NORMAL quirk to work with
cdc-acm driver.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/usb/class/cdc-acm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 62f4fb9b362f1..8577441c81a4d 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1739,6 +1739,9 @@ static const struct usb_device_id acm_ids[] = {
 	{ USB_DEVICE(0x22b8, 0x2d9a),   /* modem + AT port + diagnostics + NMEA */
 	.driver_info = NO_UNION_NORMAL, /* handle only modem interface          */
 	},
+	{ USB_DEVICE(0x0ca6, 0xa050), /* Castles Technology VEGA 5000 */
+	.driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
+	},
 
 	{ USB_DEVICE(0x0572, 0x1329), /* Hummingbird huc56s (Conexant) */
 	.driver_info = NO_UNION_NORMAL, /* union descriptor misplaced on
-- 
2.25.1

