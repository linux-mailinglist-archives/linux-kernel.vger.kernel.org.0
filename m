Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F51840DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 07:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgCMGha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 02:37:30 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60876 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726060AbgCMGha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 02:37:30 -0400
X-IronPort-AV: E=Sophos;i="5.70,547,1574092800"; 
   d="scan'208";a="86262345"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Mar 2020 14:37:22 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 983A250A9984;
        Fri, 13 Mar 2020 14:27:21 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 13 Mar 2020 14:37:18 +0800
Received: from TEST.g08.fujitsu.local (10.167.226.147) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Fri, 13 Mar 2020 14:37:17 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
Subject: [RFC PATCH] x86/apic: Drop superfluous apic_phys
Date:   Fri, 13 Mar 2020 14:37:15 +0800
Message-ID: <20200313063715.7523-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 983A250A9984.A55C0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

apic_phys seems having totally the same meaning as mp_lapic_addr,
except it is static, replace it.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
Not sure if there is still any corner case, but it boots fine.

 arch/x86/kernel/apic/apic.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 5f973fed3c9f..5b7b59951421 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -199,8 +199,6 @@ unsigned int lapic_timer_period = 0;
 
 static void apic_pm_activate(void);
 
-static unsigned long apic_phys __ro_after_init;
-
 /*
  * Get the LAPIC version
  */
@@ -1170,7 +1168,7 @@ void clear_local_APIC(void)
 	u32 v;
 
 	/* APIC hasn't been mapped yet */
-	if (!x2apic_mode && !apic_phys)
+	if (!x2apic_mode && !mp_lapic_addr)
 		return;
 
 	maxlvt = lapic_get_maxlvt();
@@ -1261,7 +1259,7 @@ void apic_soft_disable(void)
 void disable_local_APIC(void)
 {
 	/* APIC hasn't been mapped yet */
-	if (!x2apic_mode && !apic_phys)
+	if (!x2apic_mode && !mp_lapic_addr)
 		return;
 
 	apic_soft_disable();
@@ -2111,14 +2109,12 @@ void __init init_apic_mappings(void)
 		pr_info("APIC: disable apic facility\n");
 		apic_disable();
 	} else {
-		apic_phys = mp_lapic_addr;
-
 		/*
 		 * If the system has ACPI MADT tables or MP info, the LAPIC
 		 * address is already registered.
 		 */
 		if (!acpi_lapic && !smp_found_config)
-			register_lapic_address(apic_phys);
+			register_lapic_address(mp_lapic_addr);
 	}
 
 	/*
@@ -2874,11 +2870,11 @@ early_param("apic", apic_set_verbosity);
 
 static int __init lapic_insert_resource(void)
 {
-	if (!apic_phys)
+	if (!mp_lapic_addr)
 		return -1;
 
 	/* Put local APIC into the resource map. */
-	lapic_resource.start = apic_phys;
+	lapic_resource.start = mp_lapic_addr;
 	lapic_resource.end = lapic_resource.start + PAGE_SIZE - 1;
 	insert_resource(&iomem_resource, &lapic_resource);
 
-- 
2.21.1



