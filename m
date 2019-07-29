Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62A79733
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 21:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403983AbfG2TxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 15:53:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40173 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403948AbfG2Tw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so27859149pla.7;
        Mon, 29 Jul 2019 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L2GrFCc9D3WL/PNzooHGzzSvpdiTmwdSbMUKxvJZPzY=;
        b=pmOThawuup9vu+NIc6QrzGlWCDKMPYBsStynBNWXUhIY7Mt3YY3d0/SpEmPXcqSF4u
         wcx23kMNoksa4Zle7wqxMAUZlDAO8Lsbkd3/9jZ6sJuBJ/I2GJmS63zA783CLHntnhg5
         MZJIiZ+Or1DKeb4c5EUZVAjqY+KOoBMZ3ded+BIWnytuX/OsZYK6mNqHZfC9XH3avx0S
         595E9zrGsXpz9PpKk3K9Yut3JvJbFbyZTQuQybJXHrfmcXcTbxunuPv4+loKyzXU49pL
         E6nxDKAKHnS9YPTyZGG+d2qrNuZWNz6mwb5ANq4nymUc9M3h64poldklV3M3x2HFz1zf
         egEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2GrFCc9D3WL/PNzooHGzzSvpdiTmwdSbMUKxvJZPzY=;
        b=T7FPJl3XKqbREHUQA0GfvXgGcAH1JXKjo0ss7X7w3VczOMii/D8paPjE36U8YmCRDL
         j613b8rpKyJ8ejKUc093RDTFvBckN48pd9ssSpfAmbyiOku+Y1gmv/AmBvaCvc8slrf+
         YNrWFoBYqNcl5gJZ3GOEY90N+OU5lu0X0jJpPZQXbO5wobMie5QuFn+gyEfCJnKZZbih
         b4XQdlbRQ89OQmLKd0ryQpT2Idiuy05Zqp/rL29aTNAIPgZPe0hXcL7JOIlW2MmxIX3A
         NVMAn+odNIzvZdwgT4IaKRNqjnRazvzTZczvLCFwSxuAY4M7haSkwnhkFuO7Vzdmy12Q
         6wtg==
X-Gm-Message-State: APjAAAUqyaovzudP+Hc0Uezt1PzltUsDbE5HZA/nIigq02SvLkDROR2C
        LlwP49i1YEWcEBOokYnDbQjhyPHb
X-Google-Smtp-Source: APXvYqzfMcWYQWOxnlxTQ1J+bdjC0AgbaZIqDH/Ml8Q3qfUlazI90HaUcabsMKqEr622Zitj1T8LDg==
X-Received: by 2002:a17:902:2ac7:: with SMTP id j65mr112694634plb.242.1564429976844;
        Mon, 29 Jul 2019 12:52:56 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:52:56 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/24] tty: serial: fsl_lpuart: Fix issue in software flow control
Date:   Mon, 29 Jul 2019 12:52:10 -0700
Message-Id: <20190729195226.8862-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although I haven't observed this bug in practice, it seems that the
code for handling x_char of LPUART is pretty much identical to that of
i.MX. So the fix found in commit 7e2fb5aa8d81 ("serial: imx: Fix issue
in software flow control"):

    serial: imx: Fix issue in software flow control

    After send out x_char in UART driver, x_char needs to be cleared
    by UART driver itself, otherwise data in TXFIFO can no longer be
    sent out.
    Also tx counter needs to be increased to keep track of correct
    number of transmitted data.

    Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

should apply here as well.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 840dcbb27e5a..1fe9b1b29a46 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -781,6 +781,8 @@ static void lpuart_txint(struct lpuart_port *sport)
 			lpuart32_write(&sport->port, sport->port.x_char, UARTDATA);
 		else
 			writeb(sport->port.x_char, sport->port.membase + UARTDR);
+		sport->port.icount.tx++;
+		sport->port.x_char = 0;
 		goto out;
 	}
 
-- 
2.21.0

