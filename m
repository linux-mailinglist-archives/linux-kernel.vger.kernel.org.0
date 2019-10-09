Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F8D1B91
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 00:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfJIWVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 18:21:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:36992 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbfJIWVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:21:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 15:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="368878922"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga005.jf.intel.com with ESMTP; 09 Oct 2019 15:21:03 -0700
Message-ID: <d733c8d7c7c7c27ac6e89374bfb78891119e3b02.camel@intel.com>
Subject: Re: [PATCH 6/6] x86/fpu/xstate: Rename validate_xstate_header() to
 validate_xstate_header_from_user()
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
Date:   Wed, 09 Oct 2019 15:10:54 -0700
In-Reply-To: <20191009173148.GJ10395@zn.tnic>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
         <20190925151022.21688-7-yu-cheng.yu@intel.com>
         <20191009173148.GJ10395@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 19:31 +0200, Borislav Petkov wrote:
> On Wed, Sep 25, 2019 at 08:10:22AM -0700, Yu-cheng Yu wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > 
> > The function validate_xstate_header() validates an xstate header coming
> > from userspace (PTRACE or sigreturn).  To make it clear, rename it to
> > validate_xstate_header_from_user().
> > 
> > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> This one is correct!
> 
> \o/
> 
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/include/asm/fpu/xstate.h | 2 +-
> >  arch/x86/kernel/fpu/regset.c      | 2 +-
> >  arch/x86/kernel/fpu/signal.c      | 2 +-
> >  arch/x86/kernel/fpu/xstate.c      | 6 +++---
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> And I like patches like this one! :-)
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Thanks for reviewing.  I will send out an updated version.

Yu-cheng
