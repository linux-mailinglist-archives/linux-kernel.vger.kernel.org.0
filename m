Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4345D17BD32
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 13:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgCFMtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 07:49:16 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:35684 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgCFMtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:49:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id AEE648030797;
        Fri,  6 Mar 2020 12:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LoOnL7-9FjW0; Fri,  6 Mar 2020 15:49:09 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 17/22] bus: cdmm: Add MIPS R5 arch support
Date:   Fri, 6 Mar 2020 15:47:00 +0300
In-Reply-To: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306124909.AEE648030797@mail.baikalelectronics.ru>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

CDMM may be available not only MIPS R2 architectures, but also in
newer MIPS R5 chips. For instance our P5600 chip has one. Lets mark
the CDMM bus being supported for that MIPS arch too.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 6095b6df8a81..63466bff0264 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -58,7 +58,7 @@ config IMX_WEIM
 
 config MIPS_CDMM
 	bool "MIPS Common Device Memory Map (CDMM) Driver"
-	depends on CPU_MIPSR2
+	depends on CPU_MIPSR2 || CPU_MIPSR5
 	help
 	  Driver needed for the MIPS Common Device Memory Map bus in MIPS
 	  cores. This bus is for per-CPU tightly coupled devices such as the
-- 
2.25.1

