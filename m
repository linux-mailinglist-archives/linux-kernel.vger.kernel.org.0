Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2644C46380
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 17:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfFNP6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 11:58:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:2001 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfFNP6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:58:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 08:58:39 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2019 08:58:38 -0700
Date:   Fri, 14 Jun 2019 08:58:38 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 8/9] x86/tlb: Privatize cpu_tlbstate
Message-ID: <20190614155838.GD12191@linux.intel.com>
References: <20190613064813.8102-1-namit@vmware.com>
 <20190613064813.8102-9-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613064813.8102-9-namit@vmware.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:48:12PM -0700, Nadav Amit wrote:
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 79272938cf79..a1fea36d5292 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h

...

> @@ -439,6 +442,7 @@ static inline void __native_flush_tlb_one_user(unsigned long addr)
>  {
>  	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
>  
> +	//invpcid_flush_one(kern_pcid(loaded_mm_asid), addr);

Leftover debug/testing code.

>  	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
>  
>  	if (!static_cpu_has(X86_FEATURE_PTI))
