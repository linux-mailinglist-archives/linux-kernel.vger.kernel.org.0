Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9EB1917FE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgCXRpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 13:45:10 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42992 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgCXRpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:45:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 23F4B803078E;
        Tue, 24 Mar 2020 17:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Lh46Dl5x4otu; Tue, 24 Mar 2020 20:45:00 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dinh Nguyen <dinguyen@altera.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Jamie Iles <jamie@jamieiles.com>,
        Rob Herring <rob.herring@calxeda.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/6] clocksource: dw_apb_timer_of: Fix missing clockevent timers
Date:   Tue, 24 Mar 2020 20:43:23 +0300
Message-ID: <20200324174325.14213-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200324174325.14213-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306125622.839ED80307C4@mail.baikalelectronics.ru>
 <20200324174325.14213-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Commit 100214889973 ("clocksource: dw_apb_timer_of: use
clocksource_of_init") replaced a publicly available driver
initialization method with one called by the timer_probe() method
available after CLKSRC_OF. In current implementation it traverses
all the timers available in the system and calls their initialization
methods if corresponding devices were either in dtb or in acpi. But
if before the commit any number of available timers would be installed
as clockevent and clocksource devices, after that there would be at most
two. The rest are just ignored since default case branch doesn't do
anything. I don't see a reason of such behaviour, neither the commit
message explains it. Moreover this might be wrong if on some platforms
these timers might be used for different purpose, as virtually CPU-local
clockevent timers and as an independent broadcast timer. So in order
to keep the compatibility with the platforms where the order of the
timers detection has some meaning, lets add the secondly discovered
timer to be of clocksource/sched_clock type, while the very first and
the others would provide the clockevents service.

Fixes: 100214889973 ("clocksource: dw_apb_timer_of: use clocksource_of_init")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
---
 drivers/clocksource/dw_apb_timer_of.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 0a2505b323d7..0b61b90a525e 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -146,10 +146,6 @@ static int num_called;
 static int __init dw_apb_timer_init(struct device_node *timer)
 {
 	switch (num_called) {
-	case 0:
-		pr_debug("%s: found clockevent timer\n", __func__);
-		add_clockevent(timer);
-		break;
 	case 1:
 		pr_debug("%s: found clocksource timer\n", __func__);
 		add_clocksource(timer);
@@ -160,6 +156,8 @@ static int __init dw_apb_timer_init(struct device_node *timer)
 #endif
 		break;
 	default:
+		pr_debug("%s: found clockevent timer\n", __func__);
+		add_clockevent(timer);
 		break;
 	}
 
-- 
2.25.1

