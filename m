Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB3FBF462
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 12:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfD3Kml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 06:42:41 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:20968 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbfD3Kml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:42:41 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Apr 2019 06:42:39 EDT
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Apr 2019 16:05:43 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9242"; a="9070500"
Received: from blr-ubuntu-104.ap.qualcomm.com (HELO blr-ubuntu-104.qualcomm.com) ([10.79.40.64])
  by ironmsg01-blr.qualcomm.com with ESMTP; 30 Apr 2019 16:05:44 +0530
Received: by blr-ubuntu-104.qualcomm.com (Postfix, from userid 346745)
        id 992793DF6; Tue, 30 Apr 2019 16:05:42 +0530 (IST)
From:   Arun KS <arunks@codeaurora.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Steve Capper <steve.capper@arm.com>,
        Arun KS <arunks@codeaurora.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: arm64: Fix size of __early_cpu_boot_status
Date:   Tue, 30 Apr 2019 16:05:04 +0530
Message-Id: <1556620535-10060-1-git-send-email-arunks@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__early_cpu_boot_status is of type long. Use quad
assembler directive to allocate proper size.

Signed-off-by: Arun KS <arunks@codeaurora.org>
---
 arch/arm64/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index eecf792..115f332 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -684,7 +684,7 @@ ENTRY(__boot_cpu_mode)
  * with MMU turned off.
  */
 ENTRY(__early_cpu_boot_status)
-	.long 	0
+	.quad 	0
 
 	.popsection
 
-- 
1.9.1

