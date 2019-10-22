Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C60E07C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbfJVPrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 11:47:41 -0400
Received: from [217.140.110.172] ([217.140.110.172]:55818 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbfJVPrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:47:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977AC177F;
        Tue, 22 Oct 2019 08:47:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E54FC3F71A;
        Tue, 22 Oct 2019 08:47:16 -0700 (PDT)
Date:   Tue, 22 Oct 2019 16:47:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/18] arm64: preserve x18 when CPU is suspended
Message-ID: <20191022154708.GA699@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-14-samitolvanen@google.com>
 <20191021165649.GE56589@lakrids.cambridge.arm.com>
 <CABCJKucm2ETxe2dgJhb4Ruzq72psFMGsx=0D6TVnJ-_DL2FgfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKucm2ETxe2dgJhb4Ruzq72psFMGsx=0D6TVnJ-_DL2FgfA@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 03:43:14PM -0700, Sami Tolvanen wrote:
> On Mon, Oct 21, 2019 at 9:56 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > This should have a corresponding change to cpu_suspend_ctx in
> > <asm/suspend.h>. Otherwise we're corrupting a portion of the stack.
> 
> Ugh, correct. I'll fix this in the next version. Thanks.

It's probably worth extending the comment above cpu_do_suspend to say:

| This must be kept in sync with struct cpu_suspend_ctx in
| <asm/suspend.h>

... to match what we have above struct cpu_suspend_ctx, and make this
more obvious in future.

Thanks,
Mark.
