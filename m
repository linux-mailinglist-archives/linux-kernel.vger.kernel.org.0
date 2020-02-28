Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 384651741DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 23:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgB1WOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 17:14:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:44027 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgB1WOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 17:14:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 14:14:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; 
   d="scan'208";a="257257678"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002.jf.intel.com with ESMTP; 28 Feb 2020 14:14:17 -0800
Message-ID: <c8da950a64db495088f0abe3932a489a84e4da97.camel@intel.com>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 28 Feb 2020 14:13:29 -0800
In-Reply-To: <20200228214742.GF25261@zn.tnic>
References: <20200221175859.GL25747@zn.tnic>
         <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
         <20200228121724.GA25261@zn.tnic>
         <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
         <20200228162359.GC25261@zn.tnic>
         <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
         <20200228172202.GD25261@zn.tnic>
         <9a283ad42da140d73de680b1975da142e62e016e.camel@intel.com>
         <20200228183131.GE25261@zn.tnic>
         <7c6560b067436e2ec52121bba6bff64833e28d8d.camel@intel.com>
         <20200228214742.GF25261@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-28 at 22:47 +0100, Borislav Petkov wrote:
> On Fri, Feb 28, 2020 at 01:22:39PM -0800, Yu-cheng Yu wrote:
> > The code is for sigreturn only.  Because of lazy-restore,
> > copy_xregs_to_kernel() does not happen all the time.
> 
> What does "not all the time" mean? You need to quantify this more
> precisely.

If the XSAVES buffer already has current data (i.e. TIF_NEED_FPU_LOAD is
set), then skip copy_xregs_to_kernel().  This happens when the task was
context-switched out and has not returned to user-mode.

