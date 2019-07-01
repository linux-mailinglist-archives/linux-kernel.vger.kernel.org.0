Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DBD44DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 23:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfFMVBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 17:01:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:57146 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbfFMVBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:01:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 14:01:01 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2019 14:01:01 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Christopherson Sean J" <sean.j.christopherson@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 0/3] x86/cpufeatures: Re-arrange a few features and enumerate AVX512 BFLOAT16 intructions
Date:   Thu, 13 Jun 2019 13:51:01 -0700
Message-Id: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enumerate AVX512 BFLOAT16 feature CPUID.7.1:EAX[5] and other future
features in CPUID.7.1:EAX, Boris suggests to create a new pure feature
bits word.

Boris further suggests to re-define word 11 as scattered features word
and move the four X86_FEATURE_CQM_* features in existing word 11 and
word 12 into the new word 11. Then use word 12 to hold features in
CPUID.7.1:EAX including AVX512 BFLOAT16 instructions.

Also remove x86_cache_max_rmid and x86_cache_occ_scale in cpuinfo_x86
to save memory space because they are only read once by resctrl during
boot time. Get the info directly from CPUID in resctrl initialization.

Fenghua Yu (3):
  x86/resctrl: Get max rmid and occupancy scale directly from CPUID
    instead of cpuinfo_x86
  x86/cpufeatures: Combine word 11 and 12 into new scattered features
    word 11
  x86/cpufeatures: Enumerate new AVX512 BFLOAT16 instructions

 arch/x86/include/asm/cpufeature.h      |  4 +--
 arch/x86/include/asm/cpufeatures.h     | 18 +++++++----
 arch/x86/include/asm/processor.h       |  3 --
 arch/x86/kernel/cpu/common.c           | 45 ++------------------------
 arch/x86/kernel/cpu/cpuid-deps.c       |  4 +++
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 28 ++++++++++++++--
 arch/x86/kernel/cpu/scattered.c        |  4 +++
 arch/x86/kvm/cpuid.h                   |  2 --
 9 files changed, 51 insertions(+), 59 deletions(-)

-- 
2.19.1

