Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056D5B3576
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 09:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfIPHVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 03:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfIPHVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:21:40 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3580206A4;
        Mon, 16 Sep 2019 07:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568618500;
        bh=ZNzODOxruTg8StFF9gj8UjlKbahmC5vEdHRA5AUlXQs=;
        h=From:To:Cc:Subject:Date:From;
        b=GFEe+YXDq1D7SlleJ3gt0iXMEu0DdY+ZGgYH0brOW8ZMldag9FGK8oSw4SKcEmD19
         LwlwmHRtN8G4K7pvjCIj7HrIVPA91yY7uOqhRhQkx7cmAw6+obkWqf59oZdBulmRtJ
         z5ADC604hp9Q8Vwl/6jGPYZfWJL7Tx8GU0gMh7Wg=
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] arm64: use generic free_initrd_mem()
Date:   Mon, 16 Sep 2019 10:21:28 +0300
Message-Id: <1568618488-19055-1-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

arm64 calls memblock_free() for the initrd area in its implementation of
free_initrd_mem(), but this call has no actual effect that late in the boot
process. By the time initrd is freed, all the reserved memory is managed by
the page allocator and the memblock.reserved is unused, so there is no
point to update it.

Without the memblock_free() call the only difference between arm64 and the
generic versions of free_initrd_mem() is the memory poisoning. Switching
arm64 to the generic version will enable the poisoning.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---

I've boot tested it on qemu and I've checked that kexec works.

 arch/arm64/mm/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f3c7952..8ad2934 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -567,14 +567,6 @@ void free_initmem(void)
 	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, 0, "initrd");
-	memblock_free(__virt_to_phys(start), end - start);
-}
-#endif
-
 /*
  * Dump out memory limit information on panic.
  */
-- 
2.7.4

