Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A539849
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 00:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbfFGWK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 18:10:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:58792 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730029AbfFGWKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:10:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 15:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,564,1557212400"; 
   d="scan'208";a="182814097"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2019 15:10:03 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 0/5] x86/umwait: Enable user wait instructions
Date:   Fri,  7 Jun 2019 15:00:32 -0700
Message-Id: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today, if an application needs to wait for a very short duration
they have to have spinloops. Spinloops consume more power and continue
to use execution resources that could hurt its thread siblings in a core
with hyperthreads. New instructions umonitor, umwait and tpause allow
a low power alternative waiting at the same time could improve the HT
sibling perform while giving it any power headroom. These instructions
can be used in both user space and kernel space.

A new MSR IA32_UMWAIT_CONTROL allows kernel to set a time limit in
TSC-quanta that prevents user applications from waiting for a long time.
This allows applications to yield the CPU and the user application
should consider using other alternatives to wait.

The processor supports two levels of optimized states: a light-weight
power/performance optimized state (C0.1 state) or an improved
power/performance optimized state (C0.2 state with deeper power saving
and higher exit latency). The above MSR can be used to restrict
entry to C0.2 and then any request for C0.2 will revert to C0.1.

This patch set covers feature discovery, provides initial values for
the MSR, adds some sysfs control files for admin to tweak the values
in the MSR if needed.

The sysfs interface files are in /sys/devices/system/cpu/umwait_control/

GCC 9 enables intrinsics for the instructions. To use the instructions,
user applications should include <immintrin.h> and be compiled with
-mwaitpkg.

Detailed information on the instructions, the MSR, and syntax of the
intrinsics can be found in the latest Intel Architecture Instruction
Set Extensions and Future Features Programming Reference and Intel 64
and IA-32 Architectures Software Developer's Manual.

Changelog:
v4:
- Error out when bit[1:0] in IA32_UMWAIT_CONTROL is not zero per
Andy Lutomirski's comment.
- Use umwait_control_cached to cache IA32_UMWAIT_CONTROL MSR. This
variable replaces the two previous variables umwait_max_time and
umwait_c0_2_enabled. The code is simpler than before and the cached MSR
will be easier to be used in future KVM support.

v3:
Address issues pointed out by Andy Lutomirski:
- Change default umwait max time to 100k TSC cycles
- Setting up MSR on BSP during resume suspend/hibernation
- A few other naming and coding changes as suggested
- Some security concerns of the user wait instructions are not issues
of the patches and cannot be addressed in the patch set. They will be
discussed on lkml.

Plus:
- Add ABI document entry for umwait control sysfs interfaces

v2:
- Address comments from Thomas Gleixner and Andy Lutomirski
- Remove vDSO functions
- Add sysfs control file for umwait max time

v1:
Based on comments from Thomas:
- Change user APIs to vDSO functions
- Changed sysfs per comments from Thomas.
- Change patch descriptions etc

Fenghua Yu (5):
  x86/cpufeatures: Enumerate user wait instructions
  x86/umwait: Initialize umwait control values
  x86/umwait: Add sysfs interface to control umwait C0.2 state
  x86/umwait: Add sysfs interface to control umwait maximum time
  x86/umwait: Document umwait control sysfs interfaces

 .../ABI/testing/sysfs-devices-system-cpu      |  21 ++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   4 +
 arch/x86/power/Makefile                       |   1 +
 arch/x86/power/umwait.c                       | 182 ++++++++++++++++++
 5 files changed, 209 insertions(+)
 create mode 100644 arch/x86/power/umwait.c

-- 
2.19.1

