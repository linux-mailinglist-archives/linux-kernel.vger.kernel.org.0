Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE23E0823
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbfJVQAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:00:40 -0400
Received: from [217.140.110.172] ([217.140.110.172]:56130 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2387746AbfJVQAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:00:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6C2C177F;
        Tue, 22 Oct 2019 09:00:14 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09A513F71A;
        Tue, 22 Oct 2019 09:00:12 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:00:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/18] arm64: reserve x18 only with Shadow Call Stack
Message-ID: <20191022160010.GB699@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-13-samitolvanen@google.com>
 <CAKwvOd=rU2cC7C3a=8D2WBEmS49YgR7=aCriE31JQx7ExfQZrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=rU2cC7C3a=8D2WBEmS49YgR7=aCriE31JQx7ExfQZrg@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 02:23:10PM -0700, Nick Desaulniers wrote:
> On Fri, Oct 18, 2019 at 9:11 AM 'Sami Tolvanen' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > Only reserve x18 with CONFIG_SHADOW_CALL_STACK. Note that all external
> > kernel modules must also have x18 reserved if the kernel uses SCS.
> 
> Ah, ok.  The tradeoff for maintainers to consider, either:
> 1. one less GPR for ALL kernel code or
> 2. remember not to use x18 in inline as lest you potentially break SCS

This option only affects compiler-generated code, so I don't think that
matters.

I think it's fine to say that we should always avoid the use of x18 in
hand-written assembly (with manual register allocation), while also
allowing the compiler to use x18 if we're not using SCS.

This can be folded into the earlier patch which always reserved x18.

> This patch is 2 (the earlier patch was 1).  Maybe we don't write
> enough inline asm that this will be hard to remember, and we do have
> CI in Android to watch for this (on mainline, not sure about -next).

I think that we can trust the set of people who regularly review arm64
assembly to remember this. We could also document this somewhere -- we
might need to document other constraints or conventions for assembly
in preparation for livepatching and so on.

If we wanted to, we could periodically grep for x18 to find any illicit
usage.

Thanks,
Mark.
