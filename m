Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD4154C65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 20:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgBFTlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 14:41:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:49994 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgBFTlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:41:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 11:41:16 -0800
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="236084936"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.24.10.96])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 11:41:15 -0800
Message-ID: <75f0bd0365857ba4442ee69016b63764a8d2ad68.camel@linux.intel.com>
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Date:   Thu, 06 Feb 2020 11:41:15 -0800
In-Reply-To: <202002060408.84005CEFFD@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
         <20200205223950.1212394-7-kristen@linux.intel.com>
         <202002060408.84005CEFFD@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-06 at 04:26 -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 02:39:45PM -0800, Kristen Carlson Accardi
> wrote:
> > We will be using -ffunction-sections to place each function in
> > it's own text section so it can be randomized at load time. The
> > linker considers these .text.* sections "orphaned sections", and
> > will place them after the first similar section (.text). However,
> > we need to move _etext so that it is after both .text and .text.*
> > We also need to calculate text size to include .text AND .text.*
> 
> The dependency on the linker's orphan section handling is, I feel,
> rather fragile (during work on CFI and generally building kernels
> with
> Clang's LLD linker, we keep tripping over difference between how BFD
> and
> LLD handle orphans). However, this is currently no way to perform a
> section "pass through" where input sections retain their name as an
> output section. (If anyone knows a way to do this, I'm all ears).
> 
> Right now, you can only collect sections like this:
> 
>         .text :  AT(ADDR(.text) - LOAD_OFFSET) {
> 		*(.text.*)
> 	}
> 
> or let them be orphans, which then the linker attempts to find a
> "similar" (code, data, etc) section to put them near:
> https://sourceware.org/binutils/docs-2.33.1/ld/Orphan-Sections.html
> 
> So, basically, yes, this works, but I'd like to see BFD and LLD grow
> some kind of /PASSTHRU/ special section (like /DISCARD/), that would
> let
> a linker script specify _where_ these sections should roughly live.
> 
> Related thoughts:
> 
> I know x86_64 stack alignment is 16 bytes. I cannot find evidence for
> what function start alignment should be. It seems the linker is 16
> byte
> aligning these functions, when I think no alignment is needed for
> function starts, so we're wasting some memory (average 8 bytes per
> function, at say 50,000 functions, so approaching 512KB) between
> functions. If we can specify a 1 byte alignment for these orphan
> sections, that would be nice, as mentioned in the cover letter: we
> lose
> a 4 bits of entropy to this alignment, since all randomized function
> addresses will have their low bits set to zero.

So, when I was developing this patch set, I initially ignored the value
of sh_addralign and just packed the functions in one right after
another when I did the new layout. They were byte aligned :). I later
realized that I should probably pay attention to alignment and thus
started respecting the value that was in sh_addralign. There is
actually nothing stopping me from ignoring it again, other than I am
concerned that I will make runtime performance suffer even more than I
already have.

> 
> And we can't adjust function section alignment, or there is some
> benefit to a larger alignment, I would like to have a way for the
> linker
> to specify the inter-section padding (or fill) bytes. Right now, the
> FILL(0xnn) (or =0xnn) can be used to specify the padding bytes
> _within_
> a section, but not between sections. Right now, BFD appears to 0-pad. 
> I'd
> like that to be 0xCC so "guessing" addresses incorrectly will trigger
> a trap.

Padding the space between functions with int3 is easy to add during
boot time, and I've got it on my todo list.


