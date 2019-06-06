Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 375123718B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 12:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfFFKXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 06:23:43 -0400
Received: from smtp-good-out-2.t-2.net ([84.255.208.44]:35976 "EHLO
        smtp-good-out-2.t-2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfFFKXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:23:43 -0400
Received: from smtp-2.t-2.si (smtp-2.t-2.si [IPv6:2a01:260:1:4::1f])
        by smtp-good-out-2.t-2.net (Postfix) with ESMTP id 45KMFS5byrzZG5;
        Thu,  6 Jun 2019 12:23:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1559816620;
        bh=be0m1mh0IVu6WZqXXkKj2KT0971wDCJEPqmo2Z4Dqlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bXJMBBKOyGPE1Iz/ZgOJhixqj2KKwSy7W1bc6vy5iOJHevymr6kDdic8i1NsuiVBj
         jp2tILAneZmB1LUHRd2ypE8pWnmnzK3IV0+iFCFlL4gMov7ysc9RUcpZtHCeKfQkHf
         17Y5eOxM61h8IjQIcAPX9qMQ5wVwKlC6+mR2lgTo=
Received: from localhost (localhost [127.0.0.1])
        by smtp-2.t-2.si (Postfix) with ESMTP id 45KMFS5MwzzMsJFD;
        Thu,  6 Jun 2019 12:23:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.si
Received: from smtp-2.t-2.si ([127.0.0.1])
        by localhost (smtp-2.t-2.si [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oGAyOBO-3v3y; Thu,  6 Jun 2019 12:23:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [89.212.35.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: borut_seljak@t-2.net)
        by smtp-2.t-2.si (Postfix) with ESMTPSA;
        Thu,  6 Jun 2019 12:23:11 +0200 (CEST)
From:   Borut Seljak <borut.seljak@t-2.net>
To:     erwan.leray@st.com
Cc:     borut.seljak@t-2.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] serial: stm32: fix a recursive locking in stm32_config_rs485
Date:   Thu,  6 Jun 2019 12:19:01 +0200
Message-Id: <20190606101901.31151-1-borut.seljak@t-2.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <erwan.leray@st.com>
References: <erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove spin_lock_irqsave in stm32_config_rs485, it cause recursive locking.
Already locked in uart_set_rs485_config.

fixes: 1bcda09d291081 ("serial: stm32: add support for RS485 hardware control mode")

Signed-off-by: Borut Seljak <borut.seljak@t-2.net>
---
 drivers/tty/serial/stm32-usart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index e8d7a7bb4339..5d072ec61071 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -105,9 +105,7 @@ static int stm32_config_rs485(struct uart_port *port,
 	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 usartdiv, baud, cr1, cr3;
 	bool over8;
-	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
 	stm32_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
 
 	port->rs485 = *rs485conf;
@@ -147,7 +145,6 @@ static int stm32_config_rs485(struct uart_port *port,
 	}
 
 	stm32_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
-	spin_unlock_irqrestore(&port->lock, flags);
 
 	return 0;
 }
-- 
2.17.1

