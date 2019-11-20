Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C24103BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbfKTNgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:36:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbfKTNgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:36:50 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4B76224D2;
        Wed, 20 Nov 2019 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257009;
        bh=bQX60zcLlQ0mKK3ETYbxWBd2F0HHX86vvZGfECP9sWM=;
        h=From:To:Cc:Subject:Date:From;
        b=jIy91amcmSDzPh6O66HZJG4hxO+kH+REAXHlOMdnGmjXJBIJsdd8YAWYTwHkvOwa8
         4bZQFEajN5re4aD6asf+1Hj1vBiLsI2+0ondAYGPIOOH5rYcJS7Iw8byaMMcg3cqX6
         DpnmIrY6mqrWLb65lFzJLxoYk8gGf/up19yG8WNQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:36:45 +0800
Message-Id: <20191120133645.11714-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/x86/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3fc6daff2109..89598ac1deff 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -809,9 +809,9 @@ config KVM_GUEST
 	  timing infrastructure such as time of day, and system time
 
 config ARCH_CPUIDLE_HALTPOLL
-        def_bool n
-        prompt "Disable host haltpoll when loading haltpoll driver"
-        help
+	def_bool n
+	prompt "Disable host haltpoll when loading haltpoll driver"
+	help
 	  If virtualized under KVM, disable host haltpoll.
 
 config PVH
@@ -895,11 +895,11 @@ config APB_TIMER
        select DW_APB_TIMER
        depends on X86_INTEL_MID && SFI
        help
-         APB timer is the replacement for 8254, HPET on X86 MID platforms.
-         The APBT provides a stable time base on SMP
-         systems, unlike the TSC, but it is more expensive to access,
-         as it is off-chip. APB timers are always running regardless of CPU
-         C states, they are used as per CPU clockevent device when possible.
+	 APB timer is the replacement for 8254, HPET on X86 MID platforms.
+	 The APBT provides a stable time base on SMP
+	 systems, unlike the TSC, but it is more expensive to access,
+	 as it is off-chip. APB timers are always running regardless of CPU
+	 C states, they are used as per CPU clockevent device when possible.
 
 # Mark as expert because too many people got it wrong.
 # The code disables itself when not needed.
@@ -1998,7 +1998,7 @@ config EFI_STUB
        depends on EFI && !X86_USE_3DNOW
        select RELOCATABLE
        ---help---
-          This kernel feature allows a bzImage to be loaded directly
+	  This kernel feature allows a bzImage to be loaded directly
 	  by EFI firmware without the use of a bootloader.
 
 	  See Documentation/admin-guide/efi-stub.rst for more information.
-- 
2.17.1

