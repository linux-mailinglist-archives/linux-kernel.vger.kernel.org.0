Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF57111DE3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 23:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfLCW6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 17:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729866AbfLCW57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:57:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50DA02053B;
        Tue,  3 Dec 2019 22:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413878;
        bh=rkOE49kpeLjRvMNUYJJcUKAHPJqfb3H+YeUXdrPxnQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0+UjvxfR2qVAuVh4QJFnBgj8RDiyw+FFPsulT6sGrvmce7l7eegh0o33SD4lW+Ql
         MQYoMITGzRi4W037KjJCBCDJPkyQGBLJczK9eRAwEmBcccPEjUdWMo4cfFdovzQpP7
         SXN7IioMSBqfSUfg5V5DoAY1Fy4T3jQDhmsTH5r8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 295/321] watchdog: sama5d4: fix WDD value to be always set to max
Date:   Tue,  3 Dec 2019 23:36:01 +0100
Message-Id: <20191203223442.500748791@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

commit 8632944841d41a36d77dd1fa88d4201b5291100f upstream.

WDD value must be always set to max (0xFFF) otherwise the hardware
block will reset the board on the first ping of the watchdog.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/sama5d4_wdt.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -111,9 +111,7 @@ static int sama5d4_wdt_set_timeout(struc
 	u32 value = WDT_SEC2TICKS(timeout);
 
 	wdt->mr &= ~AT91_WDT_WDV;
-	wdt->mr &= ~AT91_WDT_WDD;
 	wdt->mr |= AT91_WDT_SET_WDV(value);
-	wdt->mr |= AT91_WDT_SET_WDD(value);
 
 	/*
 	 * WDDIS has to be 0 when updating WDD/WDV. The datasheet states: When
@@ -251,7 +249,7 @@ static int sama5d4_wdt_probe(struct plat
 
 	timeout = WDT_SEC2TICKS(wdd->timeout);
 
-	wdt->mr |= AT91_WDT_SET_WDD(timeout);
+	wdt->mr |= AT91_WDT_SET_WDD(WDT_SEC2TICKS(MAX_WDT_TIMEOUT));
 	wdt->mr |= AT91_WDT_SET_WDV(timeout);
 
 	ret = sama5d4_wdt_init(wdt);


