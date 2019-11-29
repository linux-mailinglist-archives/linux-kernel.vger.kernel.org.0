Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B1A10D173
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 07:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfK2GX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 01:23:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36285 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfK2GX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:23:27 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iaZgL-0001NE-B9; Fri, 29 Nov 2019 06:23:09 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, harry.pan@intel.com, feng.tang@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] x86/intel: Disable HPET on Intel Coffee Lake H platforms
Date:   Fri, 29 Nov 2019 14:23:02 +0800
Message-Id: <20191129062303.18982-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coffee Lake H SoC has similar behavior as Coffee Lake, skewed HPET timer
once the SoCs entered PC10.

So let's disable HPET on CFL-H platforms.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 arch/x86/kernel/early-quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 4cba91ec8049..606711f5ebf8 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -710,6 +710,8 @@ static struct chipset early_qrk[] __initdata = {
 	 */
 	{ PCI_VENDOR_ID_INTEL, 0x0f00,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+	{ PCI_VENDOR_ID_INTEL, 0x3e20,
+		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_INTEL, 0x3ec4,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
-- 
2.17.1

