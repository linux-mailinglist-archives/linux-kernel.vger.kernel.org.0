Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9DF78E64
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfG2Ova (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 10:51:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:48143 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfG2Ova (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:51:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 07:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,323,1559545200"; 
   d="scan'208";a="371086756"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2019 07:51:29 -0700
Date:   Mon, 29 Jul 2019 07:51:29 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Subject: Re: [patch 4/5] x86/vdso/32: Use 32bit syscall fallback
Message-ID: <20190729145128.GB21120@linux.intel.com>
References: <20190728131251.622415456@linutronix.de>
 <20190728131648.879156507@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728131648.879156507@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 03:12:55PM +0200, Thomas Gleixner wrote:
> The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
> clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
> seccomp setups because these syscalls might be not (yet) allowed.
> 
> Implement the 32bit variants which use the legacy syscalls and select the
> variant in the core library.
> 
> The 64bit time variants are not removed because they are required for the
> time64 based vdso accessors.
> 
> Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reported-by: Paul Bolle <pebolle@tiscali.nl>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Fixes: 7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Reviewed-and-tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
