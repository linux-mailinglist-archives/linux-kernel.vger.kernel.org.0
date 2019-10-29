Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F69E886E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 13:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfJ2Mlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 08:41:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfJ2Mlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:41:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D39CBBDE45543FEB6506;
        Tue, 29 Oct 2019 20:41:41 +0800 (CST)
Received: from HGHY4Z004218071.china.huawei.com (10.133.224.57) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 29 Oct 2019 20:41:35 +0800
From:   Xiang Zheng <zhengxiang9@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
Subject: [PATCH v2] arm64: print additional fault message when executing non-exec memory
Date:   Tue, 29 Oct 2019 20:41:31 +0800
Message-ID: <20191029124131.32028-1-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to executing non-executable memory, the fault message
shows:

  Unable to handle kernel read from unreadable memory at virtual address
  ffff802dac469000

This may confuse someone, so add a new fault message for instruction
abort.

Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 arch/arm64/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9fc6db0bcbad..9adec86d0f8a 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -318,6 +318,8 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	if (is_el1_permission_fault(addr, esr, regs)) {
 		if (esr & ESR_ELx_WNR)
 			msg = "write to read-only memory";
+		else if (is_el1_instruction_abort(esr))
+			msg = "execute from non-executable memory";
 		else
 			msg = "read from unreadable memory";
 	} else if (addr < PAGE_SIZE) {
-- 
2.19.1


