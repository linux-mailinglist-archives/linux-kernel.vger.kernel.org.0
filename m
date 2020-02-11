Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B880158BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 10:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgBKJOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 04:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbgBKJOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:14:55 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CED82086A;
        Tue, 11 Feb 2020 09:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581412494;
        bh=tb46MiN81vH1/UcBBXyXQyevhAUAyIvqCLgT+INhd9c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z7P4LQAqyhoXtX/Vhz5CyJEfpz7BSlCpxQC/59C45/1y3W4didWfyBso2fKDFJfs4
         rODuahjFDB1bS/GiXTX+EM0mIhpSdN7Nq+VOxOAYS240eeBnChNGR8X9ofBepUraOd
         6DmvKlGOaxyK74q62QInJYLX72dwVHAnMQpHk9Jc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j1Rd6-004HfL-6C; Tue, 11 Feb 2020 09:14:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 11 Feb 2020 09:14:52 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/11] arm64: disable SCS for hypervisor code
In-Reply-To: <20200210180740.GA24354@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200128184934.77625-1-samitolvanen@google.com>
 <20200128184934.77625-10-samitolvanen@google.com>
 <6f62b3c0-e796-e91c-f53b-23bd80fcb065@arm.com>
 <20200210175214.GA23318@willie-the-truck>
 <20200210180327.GB20840@lakrids.cambridge.arm.com>
 <20200210180740.GA24354@willie-the-truck>
Message-ID: <43839239237869598b79cab90e100127@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, mark.rutland@arm.com, james.morse@arm.com, samitolvanen@google.com, catalin.marinas@arm.com, rostedt@goodmis.org, mhiramat@kernel.org, ard.biesheuvel@linaro.org, Dave.Martin@arm.com, keescook@chromium.org, labbott@redhat.com, ndesaulniers@google.com, jannh@google.com, miguel.ojeda.sandonis@gmail.com, yamada.masahiro@socionext.com, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-10 18:07, Will Deacon wrote:
> On Mon, Feb 10, 2020 at 06:03:28PM +0000, Mark Rutland wrote:
>> On Mon, Feb 10, 2020 at 05:52:15PM +0000, Will Deacon wrote:
>> > On Mon, Feb 10, 2020 at 05:18:58PM +0000, James Morse wrote:
>> > > On 28/01/2020 18:49, Sami Tolvanen wrote:
>> > > > Filter out CC_FLAGS_SCS and -ffixed-x18 for code that runs at a
>> > > > different exception level.
>> > >
>> > > Hmmm, there are two things being disabled here.
>> > >
>> > > Stashing the lr in memory pointed to by VA won't work transparently at EL2 ... but
>> > > shouldn't KVM's C code still treat x18 as a fixed register?
>> >
>> > My review of v6 suggested dropping the -ffixed-x18 as well, since it's only
>> > introduced by SCS (in patch 5) and so isn't required by anything else. Why
>> > do you think it's needed?
>> 
>> When EL1 code calls up to hyp, it expects x18 to be preserved across 
>> the
>> call, so hyp needs to either preserve it explicitly across a 
>> transitions
>> from/to EL1 or always preserve it.
> 
> I thought we explicitly saved/restored it across the call after
> af12376814a5 ("arm64: kvm: stop treating register x18 as caller save"). 
> Is
> that not sufficient?
> 
>> The latter is easiest since any code used by VHE hyp code will need 
>> x18
>> saved anyway (ans so any common hyp code needs to).
> 
> I would personally prefer to split the VHE and non-VHE code so they can 
> be
> compiled with separate options.

This is going to generate a lot of code duplication (or at least object 
duplication),
as the two code paths are intricately linked and splitting them to 
support different
compilation options and/or calling conventions.

I'm not fundamentally opposed to that, but it should come with ways to 
still
manage it as a unified code base as much as possible, as ways to discard 
the
unused part at runtime (which should become easy to do once we have two
distinct sets of objects).

         M.
-- 
Jazz is not dead. It just smells funny...
