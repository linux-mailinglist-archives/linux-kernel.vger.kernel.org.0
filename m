Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8281CB4479
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 01:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfIPXM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 19:12:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbfIPXM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qx7q94gHn7s/YPwIKyrM9DaRifGENyYAu1Q/ylcesgo=; b=MnecJI64GA945xjMzZdduzvGT
        yaDTLrHBsKJHFgzY5zrVwfwsT4jZtM5dT/xm7ln5wxgt4iSsVYtWWpAloUsj6yaGmlWnZlU0rWxsu
        Pu7d1fJwHlqBaDPzmCInsX7w0uCSBCcjs9AoG7da2UMSa/sOFaCSoNtN11Skx7LtlstyuGDz4z6r/
        ELvW6dAt6xgW8+g2iZ0kGQX5c4RTUwYdT+7i29CKcCLwkX2fntQuw5kVc0xqQcfrK1fuivOCln89Z
        m8kGkDdDUfnLcjc8wub1U2otNqKaS2EVNk1fR+0HAWCAQFc6whVncNqrXIcRJTEJRhhT4MZ2zHa31
        S/8tSVxRQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA0AT-0003b1-9U; Mon, 16 Sep 2019 23:12:25 +0000
To:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Korsgaard <jacmet@sunsite.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] serial: uartlite: fix exit path null pointer
Message-ID: <9c8e6581-6fcc-a595-0897-4d90f5d710df@infradead.org>
Date:   Mon, 16 Sep 2019 16:12:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Call uart_unregister_driver() conditionally instead of
unconditionally, only if it has been previously registered.

This uses driver.state, just as the sh-sci.c driver does.

Fixes this null pointer dereference in tty_unregister_driver(),
since the 'driver' argument is null:

  general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
  RIP: 0010:tty_unregister_driver+0x25/0x1d0

Fixes: 238b8721a554 ("serial uartlite driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/tty/serial/uartlite.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- lnx-53.orig/drivers/tty/serial/uartlite.c
+++ lnx-53/drivers/tty/serial/uartlite.c
@@ -897,7 +897,8 @@ static int __init ulite_init(void)
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	uart_unregister_driver(&ulite_uart_driver);
+	if (ulite_uart_driver.state)
+		uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);

