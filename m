Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B71152413
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 01:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgBEA2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 19:28:40 -0500
Received: from fw-tnat-cam7.arm.com ([217.140.106.55]:60638 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727537AbgBEA2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:28:39 -0500
X-Greylist: delayed 706 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Feb 2020 19:28:38 EST
Received: from moist.wifiportal.lan (arm6-cctv-system.cambridge.arm.com [10.37.12.8])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id 0150Ga3Q011086;
        Wed, 5 Feb 2020 00:16:37 GMT
From:   Grant Likely <grant.likely@arm.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Grant Likely <grant.likely@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] Documentation/process: Add Arm contact for embargoed HW issues
Date:   Wed,  5 Feb 2020 00:16:27 +0000
Message-Id: <20200205001627.27356-1-grant.likely@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding myself to list after getting voluntold

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Grant Likely <grant.likely@arm.com>
---
 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 5d54946cfc75..25bc61c07e6a 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -239,7 +239,7 @@ disclosure of a particular issue, unless requested by a response team or by
 an involved disclosed party. The current ambassadors list:
 
   ============= ========================================================
-  ARM
+  ARM           Grant Likely <grant.likely@arm.com>
   AMD		Tom Lendacky <tom.lendacky@amd.com>
   IBM
   Intel		Tony Luck <tony.luck@intel.com>
-- 
2.20.1

