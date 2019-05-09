Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6628318338
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 03:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEIBhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 21:37:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEIBhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:37:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD19FC045129;
        Thu,  9 May 2019 01:37:04 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCF87451A;
        Thu,  9 May 2019 01:37:01 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 3/3] x86/kdump/64: Change the upper limit of crashkernel reservation
Date:   Thu,  9 May 2019 09:36:44 +0800
Message-Id: <20190509013644.1246-4-bhe@redhat.com>
In-Reply-To: <20190509013644.1246-1-bhe@redhat.com>
References: <20190509013644.1246-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 09 May 2019 01:37:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restrict kdump to only reserve crashkernel below 64TB.

The reaons is that the kdump may jump from 5-level to 4-level, and if
the kdump kernel is put above 64TB, then the jumping will fail. While the
1st kernel reserves crashkernel region during bootup, we don't know yet
which kind of kernel will be loaded after system bootup, 5-level kernel
or 5-level kernel.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/setup.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 905dae880563..efb0934a46f6 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -452,15 +452,26 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 #define CRASH_ALIGN		SZ_16M
 
 /*
- * Keep the crash kernel below this limit.  On 32 bits earlier kernels
- * would limit the kernel to the low 512 MiB due to mapping restrictions.
+ * Keep the crash kernel below this limit.
+ *
+ * On 32 bits earlier kernels would limit the kernel to the low
+ * 512 MiB due to mapping restrictions.
+ *
+ * On 64bit, old kexec-tools need to be under 896MiB. The later
+ * supports to put kernel above 4G, up to system RAM top. Here
+ * kdump kernel need be restricted to be under 64TB, which is
+ * the upper limit of system RAM in 4-level paing mode. Since
+ * the kdump jumping could be from 5-level to 4-level, the jumping
+ * will fail if kernel is put above 64TB, and there's no way to
+ * detect the paging mode of the kernel which will be loaded for
+ * dumping during the 1st kernel bootup.
  */
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX	SZ_512M
 # define CRASH_ADDR_HIGH_MAX	SZ_512M
 #else
 # define CRASH_ADDR_LOW_MAX	SZ_4G
-# define CRASH_ADDR_HIGH_MAX	MAXMEM
+# define CRASH_ADDR_HIGH_MAX	(64UL << 40)
 #endif
 
 static int __init reserve_crashkernel_low(void)
-- 
2.17.2

