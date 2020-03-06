Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90F517BD58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 13:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCFM4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 07:56:53 -0500
Received: from foss.arm.com ([217.140.110.172]:60986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgCFM4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:56:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 544F331B;
        Fri,  6 Mar 2020 04:56:52 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23E1D3F6CF;
        Fri,  6 Mar 2020 04:56:51 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] arm: mach-dove: Mark dove_io_desc as __maybe_unused
Date:   Fri,  6 Mar 2020 12:56:38 +0000
Message-Id: <20200306125638.8285-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, we get the warnings below when CONFIG_MMU is disabled:

linux/arch/arm/mach-dove/common.c:51:24: warning: ‘dove_io_desc’ defined
but not used [-Wunused-variable]
static struct map_desc dove_io_desc[] __initdata = {
                       ^~~~~~~~~~~~

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm/mach-dove/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 01b830afcea9..dbe970e37895 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -48,7 +48,7 @@
 /*****************************************************************************
  * I/O Address Mapping
  ****************************************************************************/
-static struct map_desc dove_io_desc[] __initdata = {
+static struct map_desc __maybe_unused dove_io_desc[] __initdata = {
 	{
 		.virtual	= (unsigned long) DOVE_SB_REGS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(DOVE_SB_REGS_PHYS_BASE),
-- 
2.25.1

