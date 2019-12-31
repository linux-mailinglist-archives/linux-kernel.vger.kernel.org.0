Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD9A12D7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 10:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfLaJzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 04:55:46 -0500
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:35170 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725875AbfLaJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 04:55:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id DFBDC18224D7B;
        Tue, 31 Dec 2019 09:55:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2904:3138:3139:3140:3141:3142:3865:3866:4419:5007:6691:10004:10400:10848:11026:11473:11658:11914:12296:12297:12555:12760:13069:13311:13357:13439:14181:14394:14659:14721:21080:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cloth06_14f9fc3e6c940
X-Filterd-Recvd-Size: 1403
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 31 Dec 2019 09:55:44 +0000 (UTC)
Message-ID: <78317df96ccb67b462878e07b3f87348c9d898cc.camel@perches.com>
Subject: [PATCH] arm64: Kconfig: Remove CONFIG_ prefix from ARM64_PSEUDO_NMI
 section
From:   Joe Perches <joe@perches.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Dec 2019 01:54:57 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the CONFIG_ prefix from the select statement for ARM_GIC_V3.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1b447..e9b1fc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1544,7 +1544,7 @@ config ARM64_MODULE_PLTS
 
 config ARM64_PSEUDO_NMI
 	bool "Support for NMI-like interrupts"
-	select CONFIG_ARM_GIC_V3
+	select ARM_GIC_V3
 	help
 	  Adds support for mimicking Non-Maskable Interrupts through the use of
 	  GIC interrupt priority. This support requires version 3 or later of


