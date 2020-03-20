Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B3D18C651
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 05:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgCTENk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 00:13:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:43744 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgCTENk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 00:13:40 -0400
IronPort-SDR: hgnp9zsyY4P543Fz98pSRroNCBHaBx0bn5gfkSAa+luUMY8L7Rl6mzxaT0fD0FSwXCGpFFoelJ
 5j4khqtOo6bA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 21:13:40 -0700
IronPort-SDR: uxiOACeS7AKxwG4i39xyV7/w0YwwudVfRMUAkx5aOajcw2D7JckXPGHQ7UAWXlbPNbjXdSIt/C
 g8h6CdaAietQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,283,1580803200"; 
   d="scan'208";a="280306857"
Received: from kmp-skylake-client-platform.sc.intel.com ([172.25.112.108])
  by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2020 21:13:38 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, kyung.min.park@intel.com
Subject: [PATCH v2 0/2] x86/delay: Introduce TPAUSE instruction 
Date:   Thu, 19 Mar 2020 21:13:22 -0700
Message-Id: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel processors that support the WAITPKG feature implement
the TPAUSE instruction that suspends execution in a lower power
state until the TSC (Time Stamp Counter) exceeds a certain value.

Update the udelay() function to use TPAUSE on systems where it
is available. Note that we hard code the deeper (C0.2) sleep
state because exit latency is small compared to the "microseconds"
that usleep() will delay.

ChangeLog:
- Change from v1 to v2:
  1. The patchset applies after Thomas's cleanup patch as below:
     https://lkml.org/lkml/diff/2020/3/18/893/1
  2. Change function/variable names as suggested by Thomas i.e.
     a. Change to delay_halt_fn/delay_halt_mwaitx/delay_halt_tpause from
        wait_func/mwaitx/tpause.
     b. Change variable name loops to cycles.
     c. Change back to the original name delay_fn from delay_platform.
  3. Organize comments to use full width.
  4. Add __ro_after_init for the function pointer delay_halt_fn.
  5. Change patch titles as suggested by Thomas.

Kyung Min Park (2):
  x86/delay: Refactor delay_mwaitx() for TPAUSE support
  x86/delay: Introduce TPAUSE delay

 arch/x86/include/asm/mwait.h | 17 ++++++++++
 arch/x86/lib/delay.c         | 75 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 73 insertions(+), 19 deletions(-)

-- 
2.7.4

