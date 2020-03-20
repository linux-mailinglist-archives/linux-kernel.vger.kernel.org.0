Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D0E18CEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 14:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCTNRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 09:17:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35727 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgCTNQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:32 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVi-00048W-F1
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:26 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id CFDFDFFC8D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:25 +0100 (CET)
Message-Id: <20200320131509.250559388@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:13:51 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [patch 06/22] x86/kernel: Convert to new CPU match macros
References: <20200320131345.635023594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Get rid the of the local macro wrappers for consistency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |   34 ++++++++++++++--------------------
 arch/x86/kernel/smpboot.c   |    2 +-
 arch/x86/kernel/tsc_msr.c   |   14 +++++++-------
 arch/x86/power/cpu.c        |   16 ++--------------
 4 files changed, 24 insertions(+), 42 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -546,12 +546,6 @@ static struct clock_event_device lapic_c
 };
 static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
-#define DEADLINE_MODEL_MATCH_FUNC(model, func)	\
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&func }
-
-#define DEADLINE_MODEL_MATCH_REV(model, rev)	\
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)rev }
-
 static u32 hsx_deadline_rev(void)
 {
 	switch (boot_cpu_data.x86_stepping) {
@@ -588,23 +582,23 @@ static u32 skx_deadline_rev(void)
 }
 
 static const struct x86_cpu_id deadline_match[] = {
-	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_HASWELL_X,	hsx_deadline_rev),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_X,	0x0b000020),
-	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_BROADWELL_D,	bdx_deadline_rev),
-	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_SKYLAKE_X,	skx_deadline_rev),
-
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL,		0x22),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_L,	0x20),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_G,	0x17),
+	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_X,		&hsx_deadline_rev),
+	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
+	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_D,	&bdx_deadline_rev),
+	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE_X,		&skx_deadline_rev),
+
+	X86_MATCH_INTEL_FAM6_MODEL( HASWELL,		0x22),
+	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_L,		0x20),
+	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_G,		0x17),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL,	0x25),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_G,	0x17),
+	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL,		0x25),
+	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_G,	0x17),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_L,	0xb2),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE,		0xb2),
+	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE_L,		0xb2),
+	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE,		0xb2),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_L,	0x52),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE,		0x52),
+	X86_MATCH_INTEL_FAM6_MODEL( KABYLAKE_L,		0x52),
+	X86_MATCH_INTEL_FAM6_MODEL( KABYLAKE,		0x52),
 
 	{},
 };
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -466,7 +466,7 @@ static bool match_smt(struct cpuinfo_x86
  */
 
 static const struct x86_cpu_id snc_cpu[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_SKYLAKE_X },
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, NULL),
 	{}
 };
 
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -63,13 +63,13 @@ static const struct freq_desc freq_desc_
 };
 
 static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
-	INTEL_CPU_FAM6(ATOM_SALTWELL_MID,	freq_desc_pnw),
-	INTEL_CPU_FAM6(ATOM_SALTWELL_TABLET,	freq_desc_clv),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT,		freq_desc_byt),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	freq_desc_tng),
-	INTEL_CPU_FAM6(ATOM_AIRMONT,		freq_desc_cht),
-	INTEL_CPU_FAM6(ATOM_AIRMONT_MID,	freq_desc_ann),
-	INTEL_CPU_FAM6(ATOM_AIRMONT_NP,		freq_desc_lgm),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID,	&freq_desc_pnw),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_TABLET,&freq_desc_clv),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&freq_desc_byt),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&freq_desc_tng),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&freq_desc_cht),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,	&freq_desc_ann),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_NP,	&freq_desc_lgm),
 	{}
 };
 
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -475,20 +475,8 @@ static int msr_save_cpuid_features(const
 }
 
 static const struct x86_cpu_id msr_save_cpu_table[] = {
-	{
-		.vendor = X86_VENDOR_AMD,
-		.family = 0x15,
-		.model = X86_MODEL_ANY,
-		.feature = X86_FEATURE_ANY,
-		.driver_data = (kernel_ulong_t)msr_save_cpuid_features,
-	},
-	{
-		.vendor = X86_VENDOR_AMD,
-		.family = 0x16,
-		.model = X86_MODEL_ANY,
-		.feature = X86_FEATURE_ANY,
-		.driver_data = (kernel_ulong_t)msr_save_cpuid_features,
-	},
+	X86_MATCH_VENDOR_FAM(AMD, 0x15, &msr_save_cpuid_features),
+	X86_MATCH_VENDOR_FAM(AMD, 0x16, &msr_save_cpuid_features),
 	{}
 };
 

