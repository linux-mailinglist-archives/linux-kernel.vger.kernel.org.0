Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19CD6E9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 19:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfGSRDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 13:03:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:43190 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbfGSRDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 13:03:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 10:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,283,1559545200"; 
   d="scan'208";a="170185090"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.165])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jul 2019 10:03:44 -0700
Date:   Fri, 19 Jul 2019 10:03:44 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace on
 i386
Message-ID: <20190719170343.GA13680@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic vDSO implementation, starting with commit

   7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")

breaks seccomp-enabled userspace on 32-bit x86 (i386) kernels.  Prior to
the generic implementation, the x86 vDSO used identical code for both
x86_64 and i386 kernels, which worked because it did all calcuations using
structs with naturally sized variables, i.e. didn't use __kernel_timespec.

The generic vDSO does its internal calculations using __kernel_timespec,
which in turn requires the i386 fallback syscall to use the 64-bit
variation, __NR_clock_gettime64.

Using __NR_clock_gettime64 instead of __NR_clock_gettime breaks userspace
applications that use seccomp filtering to block syscalls, as applications
are completely unaware of the newly added of __NR_clock_gettime64, e.g.
sshd gets zapped on syscall(403) when attempting to ssh into the system.

I can fudge around the issue easily enough, but I have no idea how to fix
this properly without duplicating __cvdso_clock_gettime, do_hres, etc...,
especially now that the i386 vDSO exposes __vdso_clock_gettime64().
