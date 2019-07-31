Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24C007CA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 19:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfGaRc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 13:32:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38849 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbfGaRbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so30770019plb.5;
        Wed, 31 Jul 2019 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/3pXFPCtwTUjw2uGuelbq+/hzvDc+xgZT4R+g9ZoYY8=;
        b=cJERArzD5sWX5PnWwDZBrI7ud4sX6fwusZ4Qx0YrOurXzZM27KWZ6m4uxQUQdI1AtJ
         kc7dbmwyIXr9cKKS8pfWMArzHwksSR4z9joeZgTzFKOsY9IjYpAFhjHCcayTvAaRlL5R
         MjFD1TRAv8/xj7BwARlU2P1BDCcIy2UFaop1kVn+5AJtuCOj6F2mhaGy4sYLgVqwFnQT
         zYh87m974o5fHeGORtGHaD073CDpxULwpsUBfgNx3/FJZ3iAZmnE2GKk/4FQS8NCPrAC
         59JmNtTd7BmZDkBVcUo8NFiM9L1iwWOA2ADBJm3l5WVhg7NjyYdXR+KIKCnq2iMQNvCJ
         mWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/3pXFPCtwTUjw2uGuelbq+/hzvDc+xgZT4R+g9ZoYY8=;
        b=YMRocBAJhbelXqzqBryBi9UGwgo8OzIrjPWZIiirRaGlHn6syejZkOBE3BsOcFkIVJ
         WcTVCHylQUcbr4MISVFzxvPAKGwKN7fLWUoBaZDtwzu8xzzIqpN74dptnpiJsxG5/Y/a
         e16CVFBEoOeluTMOhWxqtaMWsTVUkfQpjPUgjZn0OjqGLTphmFy5XebwEe3GQeaICilF
         4wtW42sA1KHphcvjgSElmctE/GwN+seMd23zZOU3bsyOhdU1q5DF1BLXA5/3H3sR+mcO
         XstdOzz/TgLV54Fb96vPHN2cnoomY8nbK/D63mAeoZbpTQ78rk3pv5IlNxcFNx+u4bjB
         J0sw==
X-Gm-Message-State: APjAAAU+f844psxMH/UpBkE1JHHxehsE0QOXzILO4YWIkYAGLpVsFfGV
        SOoMKXt1zlBR0yk3bwfsSAmtPdaU06M=
X-Google-Smtp-Source: APXvYqzEUzrdqa7pHYE3CknrSP5TL2hRjFZlU6yZ6+r4GpMvybuXjKUl4A2oiYi2BihRoFXMMunRsA==
X-Received: by 2002:a17:902:6a88:: with SMTP id n8mr121748346plk.70.1564594279289;
        Wed, 31 Jul 2019 10:31:19 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:18 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/23] tty: serial: fsl_lpuart: Drop unnecessary uart_write_wakeup()
Date:   Wed, 31 Jul 2019 10:30:28 -0700
Message-Id: <20190731173045.11718-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uart_write_wakeup() will already be called as a part of
lpuart*_transmit_buffer() call, so there doesn't seem to be a reason
to call it again right after.

It also appears that second uart_write_wakeup() might potentially
cause unwanted write wakeup when transmitting an x_char. See commit
5e42e9a30cda ("serial: imx: Fix x_char handling and tx flow control")
where this problem was fixed in a very similarly structured i.MX UART
driver.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 57c5825f5de7..c35f81df0cff 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -798,9 +798,6 @@ static void lpuart_txint(struct lpuart_port *sport)
 	else
 		lpuart_transmit_buffer(sport);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
-
 out:
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
-- 
2.21.0

