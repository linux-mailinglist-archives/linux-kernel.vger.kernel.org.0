Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413BA63AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfGISUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 14:20:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37131 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbfGISUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:20:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so10046868qto.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AiVVzsQgxExtlPdXUQO7u3KIlgj9fJXNjXAFaENAUkA=;
        b=AqunWWWxGh4NAhLbFvISj8wCzu6id3JXejuIXa4TvV30VuMXGIT0XEXhkQJ6p4TGgR
         DjjKaYUsaAaVrwO0CP1uVEJp5OBZ4ZkazaAVcwwTVNPZpUvUow0ckU9EpwWik/tlIupX
         b/5dCH7k5TtiD1e3G4JHhANhB95vpUm8sKLXx6E1+5Ay29tkvlxkYf9asnwd2JcpbkDs
         ZflCqDPNQ9DDfGOkeI1EgEgDY8Txm1qrd14+8P75qq+3BJyby4paKruB3BM8iwSL5wRi
         Q8JvaJDDY7rxp4ujqvGLkI1MTqlzc4WcOryOl/Sk1EbjnjIndttpQuVZgDtUlgTT7MXp
         Xqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AiVVzsQgxExtlPdXUQO7u3KIlgj9fJXNjXAFaENAUkA=;
        b=m3vVyKv/jDW4qoP826Hm9i8rfFBFN5bx0JpV6Z8yQ25SHayp+nC8IXxsG2OFXks4X7
         fqFjoKnnYd0nz2irR/ryj7gOErhsabUHCgtoA73ngV/BKxHZT3ty6dgL4KknyZkMKRGe
         8fww3IScVOemG09b6IdMGuq3NCfkt622DWzVzEN4T4HDPcQppovFT2EFoAG6P4lZ1JdC
         ynP9CjpbtTb5IaC8soeEQ8MKF24Ucxtex/WGhZCu9XR/s6s/fBc9M0oPhxVT2vyVqOlG
         rSrDT3MjtFhNACty09658e2lDUHSCEvAofK+UE/YfGK9vSfLF24XmeRuin6K6b2yk2RQ
         p+4g==
X-Gm-Message-State: APjAAAWH/P6ssUCuETJsjRyTbE08K1jJsykt/+/imoMjL7VuZ8FchVtT
        rbpHzv/oLYvH6CZwno1WahcEbA==
X-Google-Smtp-Source: APXvYqypFDORJK55t4/iPYv6UX1UCBaFaqAzD+I5UAklLCwgFf6Nywn8Ipf3ouT61bmq39qnWmnv5Q==
X-Received: by 2002:ac8:1195:: with SMTP id d21mr19311947qtj.278.1562696422992;
        Tue, 09 Jul 2019 11:20:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id k123sm9113056qkf.13.2019.07.09.11.20.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 11:20:22 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v2 5/5] arm64, kexec: reserve kexeckernel region
Date:   Tue,  9 Jul 2019 14:20:14 -0400
Message-Id: <20190709182014.16052-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190709182014.16052-1-pasha.tatashin@soleen.com>
References: <20190709182014.16052-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexeckernel= is used to reserve memory for normal kexec kernel for
faster reboot.

Rename reserve_crashkernel() to reserve_crash_or_kexec_kernel(), and
generalize it by adding an argument that specifies what is reserved:
"crashkernel=" for crash kernel region
"kexeckernel=" for normal kexec region

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 +--
 arch/arm64/kernel/setup.c                     |  5 ++
 arch/arm64/mm/init.c                          | 83 ++++++++++++-------
 3 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0f5ce665c7f5..a18222c1fbee 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -740,11 +740,11 @@
 			or memory reserved is below 4G.
 
 	kexeckernel=size[KMG][@offset[KMG]]
-			[KNL] Using kexec, Linux can reboot to a new kernel.
-			This parameter reserves the physical memory region
-			[offset, offset + size] for that kernel. If '@offset' is
-			omitted, then a suitable offset is selected
-			automatically.
+			[KNL, ARM64] Using kexec, Linux can reboot to a new
+			kernel. This parameter reserves the physical memory
+			region [offset, offset + size] for that kernel. If
+			'@offset' is omitted, then a suitable offset is
+			selected automatically.
 
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 7e541f947b4c..9f308fa103c5 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -235,6 +235,11 @@ static void __init request_standard_resources(void)
 		if (crashk_res.end && crashk_res.start >= res->start &&
 		    crashk_res.end <= res->end)
 			request_resource(res, &crashk_res);
+
+		/* Userspace will find "Kexec kernel" region in /proc/iomem. */
+		if (kexeck_res.end && kexeck_res.start >= res->start &&
+		    kexeck_res.end <= res->end)
+			request_resource(res, &kexeck_res);
 #endif
 	}
 }
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f3c795278def..dfef39f72faf 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -54,61 +54,83 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
 #ifdef CONFIG_KEXEC_CORE
 /*
- * reserve_crashkernel() - reserves memory for crash kernel
+ * reserve_crash_or_kexec_kernel() - reserves memory for crash kernel or
+ * for normal kexec kernel.
  *
- * This function reserves memory area given in "crashkernel=" kernel command
- * line parameter. The memory reserved is used by dump capture kernel when
- * primary kernel is crashing.
+ * This function reserves memory area given in "crashkernel=" or "kexeckenel="
+ * kernel command line parameter. The memory reserved is used by dump capture
+ * kernel when primary kernel is crashing, or to load new kexec kernel for
+ * faster reboot without relocation.
  */
-static void __init reserve_crashkernel(void)
+static void __init reserve_crash_or_kexec_kernel(char *cmd)
 {
-	unsigned long long crash_base, crash_size;
+	unsigned long long base, size;
+	struct resource *res;
+	char s[16];
 	int ret;
 
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
-	/* no crashkernel= or invalid value specified */
-	if (ret || !crash_size)
+	/* cmd must be either: "crashkernel=" or "kexeckernel=" */
+	if (!strcmp(cmd, "crashkernel=")) {
+		res = &crashk_res;
+	} else if (!strcmp(cmd, "kexeckernel=")) {
+		res = &kexeck_res;
+	} else {
+		pr_err("%s: invalid cmd %s\n", __func__, cmd);
+		return;
+	}
+
+	/* remove trailing '=' for a nicer printfs */
+	strcpy(s, cmd);
+	s[strlen(s) - 1] = '\0';
+
+	ret = parse_crash_or_kexec_kernel(boot_command_line,
+					  memblock_phys_mem_size(),
+					  &size, &base, cmd, NULL);
+	/* no specified command or invalid value specified */
+	if (ret || !size)
 		return;
 
-	crash_size = PAGE_ALIGN(crash_size);
+	size = PAGE_ALIGN(size);
 
-	if (crash_base == 0) {
+	if (base == 0) {
 		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
-				crash_size, SZ_2M);
-		if (crash_base == 0) {
-			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
-				crash_size);
+		base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
+					      size, SZ_2M);
+		if (base == 0) {
+			pr_warn("cannot allocate %s (size:0x%llx)\n",
+				s, size);
 			return;
 		}
 	} else {
 		/* User specifies base address explicitly. */
-		if (!memblock_is_region_memory(crash_base, crash_size)) {
-			pr_warn("cannot reserve crashkernel: region is not memory\n");
+		if (!memblock_is_region_memory(base, size)) {
+			pr_warn("cannot reserve %s: region is not memory\n",
+				s);
 			return;
 		}
 
-		if (memblock_is_region_reserved(crash_base, crash_size)) {
-			pr_warn("cannot reserve crashkernel: region overlaps reserved memory\n");
+		if (memblock_is_region_reserved(base, size)) {
+			pr_warn("cannot reserve %s: region overlaps reserved memory\n",
+				s);
 			return;
 		}
 
-		if (!IS_ALIGNED(crash_base, SZ_2M)) {
-			pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");
+		if (!IS_ALIGNED(base, SZ_2M)) {
+			pr_warn("cannot reserve %s: base address is not 2MB aligned\n",
+				s);
 			return;
 		}
 	}
-	memblock_reserve(crash_base, crash_size);
+	memblock_reserve(base, size);
 
-	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
-		crash_base, crash_base + crash_size, crash_size >> 20);
+	pr_info("%s reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
+		s, base, base + size, size >> 20);
 
-	crashk_res.start = crash_base;
-	crashk_res.end = crash_base + crash_size - 1;
+	res->start = base;
+	res->end = base + size - 1;
 }
 #else
-static void __init reserve_crashkernel(void)
+static void __init reserve_crash_or_kexec_kernel(char *cmd)
 {
 }
 #endif /* CONFIG_KEXEC_CORE */
@@ -411,7 +433,8 @@ void __init arm64_memblock_init(void)
 	else
 		arm64_dma_phys_limit = PHYS_MASK + 1;
 
-	reserve_crashkernel();
+	reserve_crash_or_kexec_kernel("crashkernel=");
+	reserve_crash_or_kexec_kernel("kexeckernel=");
 
 	reserve_elfcorehdr();
 
-- 
2.22.0

