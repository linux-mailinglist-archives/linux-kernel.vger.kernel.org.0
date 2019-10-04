Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB632CC549
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 23:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfJDVzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 17:55:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44440 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfJDVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:55:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id i14so4467658pgt.11;
        Fri, 04 Oct 2019 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkZt0GXM6qo82WWXoUdTiYWmectwUJ8fNOCzw+vFaZA=;
        b=TMYufGuSnVoxWfOa8/Z/yRVBCyCrAwDmi57il930HlXUOWstAn1VqNgqDpxG1/s6FO
         jVzxb47Maw5QTKV6BdRdm2QHqkXXajXuMft5uydWJ99ug99ePO0JfKZ7Yzs3AUFszp4z
         oNO2bNEo5kVLPtTCaUmeaoeLPIFKW7K5j2s9Fuvd4oV86SZ9BhW+YIDKpSPrhj7Pzr5A
         EQcZ5Y0bvs+1S/4dvq7NnL0CQLhxkGBTzgg6WUuRT2qhJlxsogGuTPP+NKpQ1/OdALTq
         O0ToFvndKTQat/q1uNOZrmIfItPPQ8GhI9SnH5APlRoQS97Uu1BT7ZfL7paW94ySCiPj
         CbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkZt0GXM6qo82WWXoUdTiYWmectwUJ8fNOCzw+vFaZA=;
        b=c2GQDB9SWaEzFF6cFO25N7vNut0AAaQLW0WQWVHoTAEG6ySsrRyjl7iIdyCQUg6mWn
         fZ2G0AHiV44p1StiYOMyvbrPSF4Qagq2DlRnyZWP6T5NOa/OuGmPQShFMiK2zsP0mj1o
         kiDMxFhkDdwQ1VWVW9Ugw/zFQZFyqLZ+eptwb74XR57MSEwJGV5SPdbyN5XkUo8mZHjP
         hvCxoK+b5gPwA8aW7Rc5tQC4J54e5Tk8vZoDN5lWgre3ECo3p7emIHocfsqtxshXsdpt
         HxEetOW+fgFjScTXxHYxKqnRZbf16JqD0+mgKgF3F/cLuUmKdGuwSENhyUjC69+3TaUu
         nljg==
X-Gm-Message-State: APjAAAW9sgnutfhSI90DCXX+3HDRlKsIDxzhLcoZKxvK0UXe4XOY1O8Z
        WBtDF3AO9H3eVlUknsRao8g=
X-Google-Smtp-Source: APXvYqwx/LQCYgX/lCyiMKyiW7/oppBn2dDWhtxoXzCzqXC9DuFsGT8gP6S4+j+MAh1N3GHx0oTurA==
X-Received: by 2002:a17:90a:1609:: with SMTP id n9mr19150165pja.64.1570226149687;
        Fri, 04 Oct 2019 14:55:49 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id 207sm8094732pfu.129.2019.10.04.14.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:55:48 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: fsl_lpuart: Fix lpuart_flush_buffer()
Date:   Fri,  4 Oct 2019 14:55:37 -0700
Message-Id: <20191004215537.5308-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect read-modify-write sequence in lpuart_flush_buffer() that
was reading from UARTPFIFO and writing to UARTCFIFO instead of
operating solely on the latter.

Fixes: 9bc19af9dacb ("tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer")
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Greg:

This bug causes occasional boot hang on 5.4-rc1 on Vybrid, so it might
be good to push that for 5.4-rc2.

Thanks,
Andrey Sirnov

 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3e17bb8a0b16..537896c4d887 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -548,7 +548,7 @@ static void lpuart_flush_buffer(struct uart_port *port)
 		val |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
 		lpuart32_write(&sport->port, val, UARTFIFO);
 	} else {
-		val = readb(sport->port.membase + UARTPFIFO);
+		val = readb(sport->port.membase + UARTCFIFO);
 		val |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
 		writeb(val, sport->port.membase + UARTCFIFO);
 	}
-- 
2.21.0

