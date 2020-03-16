Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38FB61875CF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 23:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbgCPWvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 18:51:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42087 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732842AbgCPWvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:51:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id x2so10412718pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NX0Wlea0R+1ZmGi4xMK0+FDmtBI/tqrLeKbfSQ7Asuo=;
        b=PGt/Pcs8qCHWG0HZAYcY4liJPhGxmPGT2SofhLVciazm2WCrV04GL5dX4GIaLyyoHe
         dbOgjLpBHV0G4APe6a7npTSAjkEuYSLe6NAuPG+6eCRK7IOwEmImaAuNQJn0DVDm6maF
         uotA5/rrJ7GWT5B+WSAeW301ZL78kgGsdPaFt9ZbyRpF0xqegp9Nwm9dICs1VTAGL00+
         ih/cpO8iq7phkb/bKTqjpFfwlJL4mMPu5K7r+eF5ghVq70zzaJX0OHWghftHVbulubyw
         3hyM8EphOhCSd1/quYzOuI/1Y+ZGxOC8E1r434ppacD05u44UA44q3QxIKD030XDYaHC
         k7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NX0Wlea0R+1ZmGi4xMK0+FDmtBI/tqrLeKbfSQ7Asuo=;
        b=aPH5e6b4iugCCKZJG1dZk50ygtfNmpUm3yA8HPcmlhiT5bWvWDUcUM9ceL07q3LX+/
         ANMHY404PwcZ0WLIQUU3svZju4b/dl/XcPdhcHz4LF15mgQiiTcJ6a+7b4drtQbwSAP7
         uN4OZ5aJlqYCvOC1VnRmIuzp4c9erxBUr5+AVut8vMDU+fQh0aqadqYQKaWHAZQ8pyxe
         saRu1PfTJFZDDGHsp/MZ+rBqmL/bAypNEog+bc+CgcYSwaXCE4+Zm+eH9miSK4pQul1J
         xvcUuRDpw4p2qZhDIM6Vsi/xSJoaQt4KZG+O87uoa6ncAHUX63qMozfAMZA71Sgv3ZQK
         UBCA==
X-Gm-Message-State: ANhLgQ0MW0CPd/kW9712BCv2VUEYRhTBwQZgzdelRMw1wmHqctH7Mik8
        b3cToV5fOWPUTqTey46rNT2/ZRrdbtLqTwWSd4zpVE5F
X-Google-Smtp-Source: ADFU+vv5Y28ixNFLFWNAzRJSTYVQJvMzfJGA6f5XuD7J4RDHOOk3bgVb55GFlwn8kKvWpGQW9XT8MUU6eLclIGt/498=
X-Received: by 2002:aa7:87ca:: with SMTP id i10mr1941704pfo.169.1584399104245;
 Mon, 16 Mar 2020 15:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <b1177cdfc6af74a3e277bba5d9e708c4b3315ebe.1583575707.git.christophe.leroy@c-s.fr>
 <20200313033517.GA37606@ubuntu-m2-xlarge-x86>
In-Reply-To: <20200313033517.GA37606@ubuntu-m2-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Mar 2020 15:51:32 -0700
Message-ID: <CAKwvOdm6Z+ERUcGXPbuBKmnpBUNKfL8fPOdxK2g+a1gVRWqh-Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/32: Fix missing NULL pmd check in virt_to_kpte()
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ppc friends, did this get picked up into -next yet?

On Thu, Mar 12, 2020 at 8:35 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Sat, Mar 07, 2020 at 10:09:15AM +0000, Christophe Leroy wrote:
> > Commit 2efc7c085f05 ("powerpc/32: drop get_pteptr()"),
> > replaced get_pteptr() by virt_to_kpte(). But virt_to_kpte() lacks a
> > NULL pmd check and returns an invalid non NULL pointer when there
> > is no page table.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Fixes: 2efc7c085f05 ("powerpc/32: drop get_pteptr()")
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > ---
> >  arch/powerpc/include/asm/pgtable.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> > index b80bfd41828d..b1f1d5339735 100644
> > --- a/arch/powerpc/include/asm/pgtable.h
> > +++ b/arch/powerpc/include/asm/pgtable.h
> > @@ -54,7 +54,9 @@ static inline pmd_t *pmd_ptr_k(unsigned long va)
> >
> >  static inline pte_t *virt_to_kpte(unsigned long vaddr)
> >  {
> > -     return pte_offset_kernel(pmd_ptr_k(vaddr), vaddr);
> > +     pmd_t *pmd = pmd_ptr_k(vaddr);
> > +
> > +     return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
> >  }
> >  #endif
> >
> > --
> > 2.25.0
> >
>
> With QEMU 4.2.0, I can confirm this fixes the panic:
>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>



-- 
Thanks,
~Nick Desaulniers
