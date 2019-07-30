Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877AA7AAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 16:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfG3O2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 10:28:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:55563 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfG3O2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:28:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 07:28:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="179744647"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2019 07:28:05 -0700
Date:   Tue, 30 Jul 2019 07:28:05 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Subject: Re: [patch V2 3/5] lib/vdso/32: Provide legacy syscall fallbacks
Message-ID: <20190730142804.GA1622@linux.intel.com>
References: <20190728131251.622415456@linutronix.de>
 <20190728131648.786513965@linutronix.de>
 <20190729144831.GA21120@linux.intel.com>
 <alpine.DEB.2.21.1907301134470.1738@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907301134470.1738@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:38:50AM +0200, Thomas Gleixner wrote:
> To address the regression which causes seccomp to deny applications the
> access to clock_gettime64() and clock_getres64() syscalls because they
> are not enabled in the existing filters.
> 
> That trips over the fact that 32bit VDSOs use the new clock_gettime64() and
> clock_getres64() syscalls in the fallback path.
> 
> Add a conditional to invoke the 32bit legacy fallback syscalls instead of
> the new 64bit variants. The conditional can go away once all architectures
> are converted.
> 
> Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Reviewed-and-tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
