Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C14115AFD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2019 05:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLGEyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 23:54:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:58097 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfLGEyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 23:54:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 20:54:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,286,1571727600"; 
   d="scan'208";a="209624089"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2019 20:54:03 -0800
Message-ID: <eacbe6d2608d8cd8ee90a0cc953c3443d1e849b0.camel@intel.com>
Subject: Re: [PATCH] x86/fpu/xstate: Export fpu_fpregs_owner_ctx
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
Date:   Fri, 06 Dec 2019 20:42:51 -0800
In-Reply-To: <20191206235157.GA7601@zn.tnic>
References: <20191206231709.15398-1-yu-cheng.yu@intel.com>
         <20191206235157.GA7601@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-12-07 at 00:51 +0100, Borislav Petkov wrote:
> On Fri, Dec 06, 2019 at 03:17:09PM -0800, Yu-cheng Yu wrote:
> > After applying my "Invalidate fpregs when __fpu_restore_sig() fails"
> > patch [1], the following happens:
> > 
> >     ERROR: "fpu_fpregs_owner_ctx" [arch/x86/kvm/kvm.ko] undefined!
> > 
> > Fix it by exporting the symbol.  I apologize for missing this!
> 
> So why a separate patch? Just send a v2 as a reply to the incomplete
> one.

I just did that.  Thanks!

Yu-cheng
