Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A29010CD88
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 18:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfK1RN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 12:13:56 -0500
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:52301 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbfK1RN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:13:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 066043A9B;
        Thu, 28 Nov 2019 17:13:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1539:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3865:3872:4250:4321:4419:5007:6691:10004:10400:11026:11473:11658:11914:12043:12296:12297:12438:12555:12760:13069:13311:13357:13439:14181:14394:14659:14721:21080:21627:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hands38_220ec12b9b71d
X-Filterd-Recvd-Size: 1347
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Nov 2019 17:13:53 +0000 (UTC)
Message-ID: <9fcf53ca7372ef421e3b0836e4a7ec8239b380ec.camel@perches.com>
Subject: [PATCH] MIPS: Kconfig: Use correct form for 'depends on'
From:   Joe Perches <joe@perches.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 28 Nov 2019 09:13:26 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the CONFIG_ prefix from "depends on" as it makes the selection
not possible.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/platform/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
index f4d0a86..5e77b0 100644
--- a/drivers/platform/mips/Kconfig
+++ b/drivers/platform/mips/Kconfig
@@ -18,7 +18,7 @@ if MIPS_PLATFORM_DEVICES
 
 config CPU_HWMON
 	tristate "Loongson-3 CPU HWMon Driver"
-	depends on CONFIG_MACH_LOONGSON64
+	depends on MACH_LOONGSON64
 	select HWMON
 	default y
 	help


