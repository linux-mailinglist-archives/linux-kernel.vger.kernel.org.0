Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCF34CAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfFTJdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 05:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfFTJdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:33:18 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA533208CB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561023197;
        bh=wF4Kft1kjvbBGl6bFmuWJVdHoYPD3Au810PkssaKIZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CRnVSVD2m/JMuXmXMMrNupVPb9HD1/YsmLG8zB04i3IkiTQa5+dImtqjWlVtUVL2D
         D6jpwAqpeH0/uzLX9kd3H2jKKRW5rWYgla3LouDxkAwovsEOVIM7Q15eS9jT6yjpgK
         RV1gJEk7ESm7ioUhEmW3+1cjqjSwKwUbjyJDEMgE=
Received: by mail-wr1-f46.google.com with SMTP id p11so2267919wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 02:33:16 -0700 (PDT)
X-Gm-Message-State: APjAAAXTSV43Q4fFwvT43L1niU/oK+Vi6GesoHxNbSXFMfI6dMlaG9tw
        ETlvx67OXuZkULnz3OFT79K/N/b4DOMFRm8uDzU=
X-Google-Smtp-Source: APXvYqwcJ3JkBbowwrQ6KDOzuprIogDlsLPM1Ig5CGLqsI9nvrmysAdsaO2kn1od4dFuMTqL4DBP4KwoTY8KiIhPM/I=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr8885379wro.343.1561023195316;
 Thu, 20 Jun 2019 02:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190321163623.20219-1-julien.grall@arm.com> <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com> <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com> <20190619091219.GB7767@fuggles.cambridge.arm.com>
 <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com> <20190619123939.GF7767@fuggles.cambridge.arm.com>
In-Reply-To: <20190619123939.GF7767@fuggles.cambridge.arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 Jun 2019 17:33:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
Message-ID: <CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To:     Will Deacon <will.deacon@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        aou@eecs.berkeley.edu, gary@garyguo.net, Atish.Patra@wdc.com,
        hch@infradead.org, paul.walmsley@sifive.com, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, Anup Patel <anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
        julien.thierry@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 8:39 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Wed, Jun 19, 2019 at 08:18:04PM +0800, Guo Ren wrote:
> > On Wed, Jun 19, 2019 at 5:12 PM Will Deacon <will.deacon@arm.com> wrote:
> > > This is one place where I'd actually prefer not to go down the route of
> > > making the code generic. Context-switching and low-level TLB management
> > > is deeply architecture-specific and I worry that by trying to make this
> > > code common, we run the real risk of introducing subtle bugs on some
> > > architecture every time it is changed.
> > "Add generic asid code" and "move arm's into generic" are two things.
> > We could do
> > first and let architecture's maintainer to choose.
>
> If I understand the proposal being discussed, it involves basing that
> generic ASID allocation code around the arm64 implementation which I don't
> necessarily think is a good starting point.
...
>
> > > Furthermore, the algorithm we use
> > > on arm64 is designed to scale to large systems using DVM and may well be
> > > too complex and/or sub-optimal for architectures with different system
> > > topologies or TLB invalidation mechanisms.
> > It's just a asid algorithm not very complex and there is a callback
> > for architecture to define their
> > own local hart tlb flush. Seems it has nothing with DVM or tlb
> > broadcast mechanism.
>
> I'm pleased that you think the algorithm is not very complex, but I'm also
> worried that you might not have fully understood some of its finer details.
I understand your concern about my less understanding of asid
technology. Here is
my short-description of arm64 asid allocator: (If you find anything
wrong, please
correct me directly, thx :)
The asid allocator use five level check to reduce the cost of switch_mm.
 1. Check if the asid version is the same (it's general)
 2. Check reserved_asid which is set in rollover flush_context() and
the key point is
     keep the same bit position with the current asid version instead
of input version.
 3. Check if the position of bitmap is free then it could be set &
used directly.
 4. find_next_zero_bit() (a little performance cost)
 5. flush_context  (this is the worst cost with increase current asid version)

Check is level by level and cost is also higher with the next level.
The design that
impressed me the most was reserved_asid and bitmap and the 2th level and 3th
level will prevent unnecessary find_next_zero_bit().

The atomic 64 bit asid is also ok for 32-bit system and it won't cost
a lot in 1th 2th 3th
level check.

The operation of set/clear mm_cpumask was removed in arm64 compared to arm32.
It seems no side effect on current arm64 system, but from software
meaning it's wrong.
So I think it should be reserved in generic version.

>
> The reason I mention DVM and TLB broadcasting is because, depending on
> the mechanisms in your architecture relating to those, it may be strictly
> required that all concurrently running threads of a process have the same
> ASID at any given point in time, or it may be that you really don't care.
>
> If you don't care, then the arm64 allocator is over-engineered and likely
> inefficient for your system. If you do care, then it's worth considering
> whether a lock is sufficient around the allocator if you don't expect high
> core counts. Another possibility is that you end up using only one ASID and
> invalidating the local TLB on every context switch. Yet another design
> would be to manage per-cpu ASID pools.
I'll keep my system use the same ASID for SMP + IOMMU :P
Yes, there are two styles of asid allocator: per-cpu ASID (MIPS) or
same ASID (ARM).
If the CPU couldn't support cache/tlb coherency maintian in hardware,
it should use
per-cpu ASID style because IPI is expensive and per-cpu ASID style
need more software
mechanism to improve performance (eg: delay cache flush). From software view the
same ASID is clearer and easier to build bigger system with more TLB caches.

I think the same ASID style is a more sensible choice for modern
processor and let it be
one of generic is reasonable.

>
> So rather than blindly copying the arm64 code, I suggest sitting down and
> designing something that fits to your architecture instead. You may end up
> with something that is both simpler and more efficient.
In fact, riscv folks have discussed a lot about arm's asid allocator
and I learned
a lot from the discussion:
https://lore.kernel.org/linux-riscv/20190327100201.32220-1-anup.patel@wdc.com/

We are developing C-SKY and RISC-V ISA cpu cores and make it generic
is good for us.

Best Regards
 Guo Ren
