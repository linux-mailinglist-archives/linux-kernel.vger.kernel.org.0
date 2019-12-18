Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC212545E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 22:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfLRVLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 16:11:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46846 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfLRVLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:11:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id m8so2805792edi.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRnTtk9JZIi/3I1W9vSxQ7/mm0z0CC1gLLvuFpfUIuI=;
        b=SDMWOZ6lQOb/VZRxOexIDEBtyrlvnLSoH+FiJyCNSXqPnRFfJ26Gn0LuQPT12y7A0c
         lnJolpTE8N8rqaP6nxeRUdAGqO8uwJW2n+hreJFUcssOvxBco69nMD89oSqbkKa74G+n
         RxXaI2ISeSqylE/bYEEcez6fS72xry1fa1bsuc66nnJeHlIXPW9zK3oEj6ybcmuOyPEq
         NwahnSFrJp2yti1ljc0Raocs3d8Cp+JYUVuQCDw0K7ZvqfD/HnPCn6/+X7BeJLcGnkgF
         z/PFEpAyrntX6BKJDaoTI9ptXkbOuQh4C81cI86Igt/lS0jNk5pVeWMmDEocZIyYQmDS
         oI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRnTtk9JZIi/3I1W9vSxQ7/mm0z0CC1gLLvuFpfUIuI=;
        b=m5oIHy6/McxlwZMy9q1C+vOEaXhwtpOYOfNRjSPY4+RC6W6BFxlEPw0CijWWfMXJBa
         jziffoDG9FzFA8mSjJdfDozK8v6qtn9kqwYwDAo5oOlfGe2w3EZcmc86LLFwxlHmmIrB
         GWnpv+fMv0TaVUzL/YgzUS6eS+SRGcDyFxbL65Dz8XLQf9C6CFqowA4fy1bUguA/KU3O
         RWgsFORhgD7qXXo1gMXbrozmB95Wqoa6kpdHZnfwi6C/184MnmEhFTZRdLqf6o6+Kv8s
         pAhPLxdrEX8xKBmzP0W4FctyTPzffH82Ng4bH1TlbktPEm08BNMu15Vkx+Gp+rvmaVFJ
         zFtA==
X-Gm-Message-State: APjAAAWEoEVxBlkJE0P7oBE1eRwcKuNEQWzp8HnKbSGlljEZWJLBj1IK
        08Nc4nAY+X7IWE7iKEibRrGpZbsD/+5YWk+thxWvmA==
X-Google-Smtp-Source: APXvYqzCSdZ2WNjJ4q1+2kgxv6xiSMyDM5buf7JnxsPCxLvV6KwaInc5wgRm4EmYWM+VKPm9g7bHq7zLHX0kZcHWPLw=
X-Received: by 2002:aa7:d64f:: with SMTP id v15mr4964015edr.71.1576703500385;
 Wed, 18 Dec 2019 13:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
 <20191204232058.2500117-3-pasha.tatashin@soleen.com> <b3a6359a-e7df-b47b-f50d-31b716fae191@xen.org>
In-Reply-To: <b3a6359a-e7df-b47b-f50d-31b716fae191@xen.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 18 Dec 2019 16:11:29 -0500
Message-ID: <CA+CK2bAw62_6UpTR6316FVE3AiNV7fH7FkF55vRjE8R4=ocd+Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] arm/arm64/xen: use C inlines for privcmd_call
To:     Julien Grall <julien@xen.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 3:41 PM Julien Grall <julien@xen.org> wrote:
>
> Hello,
>
> On 04/12/2019 23:20, Pavel Tatashin wrote:
> > privcmd_call requires to enable access to userspace for the
> > duration of the hypercall.
> >
> > Currently, this is done via assembly macros. Change it to C
> > inlines instead.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Acked-by: Stefano Stabellini <sstabellini@kernel.org>
>
> Reviewed-by: Julien Grall <julien@xen.org>

Great, thank you!

Pasha
