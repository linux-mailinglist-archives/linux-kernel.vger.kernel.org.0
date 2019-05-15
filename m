Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9F31F01D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 13:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfEOLkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 07:40:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41954 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfEOLkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:40:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54D7680D;
        Wed, 15 May 2019 04:40:39 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F169B3F71E;
        Wed, 15 May 2019 04:40:37 -0700 (PDT)
Date:   Wed, 15 May 2019 12:40:35 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: use the correct function type for
 __arm64_sys_ni_syscall
Message-ID: <20190515114035.GG24357@fuggles.cambridge.arm.com>
References: <20190503191225.6684-1-samitolvanen@google.com>
 <20190503191225.6684-4-samitolvanen@google.com>
 <20190507172512.GA35803@lakrids.cambridge.arm.com>
 <20190507183227.GA10191@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507183227.GA10191@google.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:32:27AM -0700, Sami Tolvanen wrote:
> On Tue, May 07, 2019 at 06:25:12PM +0100, Mark Rutland wrote:
> > I strongly think that we cant to fix up the common definition in
> > kernel/sys_ni.c rather than having a point-hack in arm64. Other
> > architectures (e.g. x86, s390) will want the same for CFI, and I'd like
> > to ensure that our approached don't diverge.
> 
> s390 already has the following in arch/s390/kernel/sys_s390.c:
> 
>   SYSCALL_DEFINE0(ni_syscall)
>   {
>         return -ENOSYS;
>   }
> 
> Which, I suppose, is cleaner than calling sys_ni_syscall.
> 
> > I took a quick look, and it looks like it's messy but possible to fix
> > up the core.
> 
> OK. How would you propose fixing this?

In the absence of a patch from Mark, I'd suggest just adding a SYS_NI macro
to our asm/syscall_wrapper.h file which avoids the error injection stuff. It
doesn't preclude moving this to the core later on, but it unblocks the CFI
work.

Will
