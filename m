Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7645615820E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 19:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBJSHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 13:07:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgBJSHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:07:48 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 527422082F;
        Mon, 10 Feb 2020 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581358067;
        bh=fZY3SQNpPCnRBs32URTn+EedNYpwNvv58zAKZ4PXDQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhSFm6pxgBM4UCGwR1shK5x3S7ghvaKBgaa8wHBuZU3zoh8GJXUvL//MSDY85r1eE
         BRup8cnQdmJ0sIk/2rKEK0dbZ6Wn1eVTFVkGNxHeHu64JFJ+BtEQ0wbQrrWPJEVlut
         0ZjWRbmrsBXc1XHZTYJ/fzWCK3XhFd2c6j3rvmf8=
Date:   Mon, 10 Feb 2020 18:07:41 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morse <james.morse@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/11] arm64: disable SCS for hypervisor code
Message-ID: <20200210180740.GA24354@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200128184934.77625-1-samitolvanen@google.com>
 <20200128184934.77625-10-samitolvanen@google.com>
 <6f62b3c0-e796-e91c-f53b-23bd80fcb065@arm.com>
 <20200210175214.GA23318@willie-the-truck>
 <20200210180327.GB20840@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210180327.GB20840@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 06:03:28PM +0000, Mark Rutland wrote:
> On Mon, Feb 10, 2020 at 05:52:15PM +0000, Will Deacon wrote:
> > On Mon, Feb 10, 2020 at 05:18:58PM +0000, James Morse wrote:
> > > On 28/01/2020 18:49, Sami Tolvanen wrote:
> > > > Filter out CC_FLAGS_SCS and -ffixed-x18 for code that runs at a
> > > > different exception level.
> > > 
> > > Hmmm, there are two things being disabled here.
> > > 
> > > Stashing the lr in memory pointed to by VA won't work transparently at EL2 ... but
> > > shouldn't KVM's C code still treat x18 as a fixed register?
> > 
> > My review of v6 suggested dropping the -ffixed-x18 as well, since it's only
> > introduced by SCS (in patch 5) and so isn't required by anything else. Why
> > do you think it's needed?
> 
> When EL1 code calls up to hyp, it expects x18 to be preserved across the
> call, so hyp needs to either preserve it explicitly across a transitions
> from/to EL1 or always preserve it.

I thought we explicitly saved/restored it across the call after
af12376814a5 ("arm64: kvm: stop treating register x18 as caller save"). Is
that not sufficient?

> The latter is easiest since any code used by VHE hyp code will need x18
> saved anyway (ans so any common hyp code needs to).

I would personally prefer to split the VHE and non-VHE code so they can be
compiled with separate options.

Will
