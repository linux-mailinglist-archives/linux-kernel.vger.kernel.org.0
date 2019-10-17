Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0810DB005
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437743AbfJQO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 10:26:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37064 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfJQO0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:26:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4so1904337edy.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pTZm79Y77en4+WVH2R/MS/mKWiM//Hl1RgvICjEclrk=;
        b=TKjxRtPwWpvtdWaMYbV45LyV9HVOzaOpAFbMpF2wo5zHCbYg0VRPUUtdJ1VyU2CUc6
         l/GfxXIxUHAzOJXFyL/sOqbcEBBADqp8Pq1no/2KigSG5eGP/nwp1ooFXzgeBH8HEdjO
         GmJV/kE/BTVPJEGV8LKAdzay5o0rhZDFgVvRTWl/8/mJ/iwqxTg0IqZ6T9qTkiFc8x78
         2EcQkBTDbFH6XEMf1N3dkNFpK4jjV2/42IkyvXgNWCq+s3Q6czyEmpaIe60dwwf0EJUc
         0QeFMbdS9HQHYMtc2JQUheqYhHhaL2gcvWIPxKnh27DvXjcivpklLdfmftATrLQDcDfZ
         nO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pTZm79Y77en4+WVH2R/MS/mKWiM//Hl1RgvICjEclrk=;
        b=Cjr/tct8anbLW6llDm3S3g/ro7y7PBesUY/RfilGeBTj8nUz4P6JLhddo1GOlRoiNG
         IXJymbwnvTbn1nbwANU46bN7bGklyGd6/w6vhpDCNpEEa3wXaCFXbv8RW2KNYXHq+bZM
         72hgaqTcqltMY7D3pf1e3Iv73KGnLgEUzPG+mwyvkj/t/WBIBvvCGB5FJtH+qcDb3EFB
         cerFItpTDYsLtP46q/+wwM9z4ry/FYu8Xl9aZOnDKjiaXthl4uX0dljQ7Pw48T5ZehqI
         dlZ6HFxicMpqNqRzDTS8qo5Wde9xXMEnQ3E/UTe7TcI5PGhK0nX6VZHCbDszgUIqx/PO
         IXuQ==
X-Gm-Message-State: APjAAAVKOoCpD2ieIbgmMc+kQ6DPkjPCw+ToRpLVGcVZfn2QQgZp4iUY
        N+uJ2QUaqTDVlQQX57VvlW2RbgCXonNHjuz6KQfEaw==
X-Google-Smtp-Source: APXvYqziFMNgpgw2iHsErr96SyZ2uSmSqs5rGVbMozjNUXiBuLfqaEtdRt8edlaf9N0bltup9A+f3kj+ItWHzZYFDds=
X-Received: by 2002:aa7:dd0f:: with SMTP id i15mr4281166edv.0.1571322404589;
 Thu, 17 Oct 2019 07:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 17 Oct 2019 10:26:33 -0400
Message-ID: <CA+CK2bC2KwWufE1DWa4szn_hQ1dbjDVHgYUu7=J4O_kvKXTrHg@mail.gmail.com>
Subject: Re: [PATCH v7 00/25] arm64: MMU enabled kexec relocation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> https://lore.kernel.org/lkml/45a2f0b8-5bac-8b5d-d595-f92e9acb27ad@arm.com
> > +     /* Map relocation function va == pa */
> > +     rc = trans_pgd_map_page(&info, trans_ttbr0,  __va(kern_reloc),
> > +                             kern_reloc, PAGE_KERNEL_EXEC);
> > +     if (rc)
> > +             return rc;
> James wrote:
> You can't do this with the page table helpers. We support platforms
> with no memory in range of TTBR0's VA space. See dd006da21646f
>
> You will need some idmapped memory to turn the MMU off on a system
> that booted at EL1. This will need to be in a set of page tables
> that the helpers can't easily touch - so it should only be a single
> page. (like the arch code's existing idmap - although that may
> have been overwritten).
>
> (I have a machine where this is a problem, if I get the time I will
> have a stab at making hibernate's safe page idmaped).
> ---
>
> As I understand, there are platforms where TTBR0 cannot include all
> physical memory for idmap. However, kexec must have at least one page
> idmapped (kimage->control_code_page) to be able to relocate kernel
> while MMU is enabled:
>
> I am still trying to fully understand the problem:
> CONFIG_ARM64_VA_BITS must be smaller than 48 and physical memory must
> start at a high address for this problem to occur.
>
> Why can't we simply decrease T0SZ to cover all physical memory?

Is there a way to reproduce this platform with qemu?

Pasha
