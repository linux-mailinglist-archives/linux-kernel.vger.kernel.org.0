Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06113BAD0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 09:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgAOIV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 03:21:57 -0500
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:31105 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726088AbgAOIV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:21:57 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 15 Jan
 2020 16:21:54 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.11) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 15 Jan
 2020 16:21:51 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <peterz@infradead.org>,
        <tony.luck@intel.com>, <jacob.jun.pan@linux.intel.com>,
        <wangkefeng.wang@huawei.com>, <jbeulich@suse.com>,
        <sean.j.christopherson@intel.com>, <linux-kernel@vger.kernel.org>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH] x86/apic: mask IOAPIC entries when disable LAPIC
Date:   Wed, 15 Jan 2020 16:22:19 +0800
Message-ID: <1579076539-7267-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.11]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When system suspend to S1, LAPIC disabled via soft but some IOAPIC
entries are unmask like IOAPIC 0 pin 9 which is for acpi interrupt.
This state IOAPIC can response external interrupt, but the interrupt
message can not handled by LAPIC.

When wakeup system via keyboard/rtc, level triggered interrupt IOAPIC 0
pin 9 RTE's Remote IRR bit may be set to 1 but LAPIC does not send EOI
for it. So this Remote IRR bit will remain all the time. This cause the
following S1 suspend sequence failed because software lockup in
__synchronize_hardirq.

Mask IOAPIC entries when disable LAPIC to make IOAPIC completely quiet
when LAPIC disabled.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/apic/apic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 28446fa..233239a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2626,6 +2626,12 @@ static int lapic_suspend(void)
 #endif
 
 	local_irq_save(flags);
+
+	/*
+	 * Make IOAPIC quiet before disable LAPIC
+	 */
+	mask_ioapic_entries();
+
 	disable_local_APIC();
 
 	irq_remapping_disable();
-- 
2.7.4

