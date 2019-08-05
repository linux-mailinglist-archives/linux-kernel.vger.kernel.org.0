Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E182510
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfHESwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 14:52:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44244 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHESwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:52:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so40062602pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OsKqWk6oFcCzgRC0S8GKkGmI0CJF7nPjf7Uo25WNgS0=;
        b=jhpFTgtWsn+JgPPhU21xW+YjI5duPOSa+RVkP3SxTV9RVfCmWC2gAUYei1Vyt/6s+J
         ZJS0zLWj1+iPerGqrOikIPMPPVagGNOH424cuY1OFH8jYS4T23qz+Y0UxhSOqmGD1yD3
         9ILlDe5uTgx0UkR4Zwks5sOdslHf+XWKWP6qUEvfRWGuu2maVM2wK+m17DpSadujuqyF
         vmSuJfGu3gl8WdgtEt1CkJBnnPwJ5xBoo3E5te433nmtxw3Dw+olFuz8Lwphy7dy/0UB
         XpH4LO1B+ysAle4HE1QI/qwLm2PlHm362SCsahqBi/e79jkjUUsABUunKxwCUzvg/+Ag
         qjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OsKqWk6oFcCzgRC0S8GKkGmI0CJF7nPjf7Uo25WNgS0=;
        b=FU/CxLmX9H2jxsXdNkemewbZA7fghJ74p9hp0i5npec0By+CvPVq67RjzG+n94z5CH
         YOE4Drh5OIs5EeIGrwLqr92y+sEyzRg8dElBJ131sdHSx8UIQV4UfmYwDY+7M54CT1Tt
         482pomstT+nEkSlmLU1gcYzBdq81onAX8aUwJ2tI5fX6JTfSGZv96xAc818OldBCaks+
         wl181evTDGT61SbZ55nSurMqsCzChhbwwi+cfATAZzCA+prwIn99TF/Da4ZCJ6v6t/uy
         pn9UAAg87c6yqQBfZvwk7E+V4yv78SlQW1xlrNi8IpyEAhoIIJYbmxw3ynlmDrtX85dE
         HVyQ==
X-Gm-Message-State: APjAAAXKdDfnzH6DcKpqdTLV0FUf9aQsdO44JFrsxW5lf6M3YWODsz1z
        Y7GTUPkaA9lJX4KUam8TLvreLSm2
X-Google-Smtp-Source: APXvYqwkklwIB/rlYcRcAsB/ic8miQ/CHSmDXU0PISNTRn2fJjBdngBbzPX/8T6ZR3eAkv+onUX/oQ==
X-Received: by 2002:a62:3895:: with SMTP id f143mr73559525pfa.116.1565031127284;
        Mon, 05 Aug 2019 11:52:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a3sm94071724pfl.145.2019.08.05.11.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 11:52:05 -0700 (PDT)
Date:   Mon, 5 Aug 2019 11:52:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] page flags: prioritize kasan bits over last-cpuid
Message-ID: <20190805185204.GA28257@roeck-us.net>
References: <20190805165128.GA23762@roeck-us.net>
 <CAK8P3a1MLMu0qh-j9fZXmG10-q2SZrtFm9JGT_xOuuZHQm31qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1MLMu0qh-j9fZXmG10-q2SZrtFm9JGT_xOuuZHQm31qw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 08:35:40PM +0200, Arnd Bergmann wrote:
> On Mon, Aug 5, 2019 at 6:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Fri, Aug 02, 2019 at 09:49:02PM -0700, Arnd Bergmann wrote:
> > > ARM64 randdconfig builds regularly run into a build error, especially
> > > when NUMA_BALANCING and SPARSEMEM are enabled but not SPARSEMEM_VMEMMAP:
> > >
> > >   #error "KASAN: not enough bits in page flags for tag"
> > >
> > > The last-cpuid bits are already contitional on the available space, so
> > > the result of the calculation is a bit random on whether they were
> > > already left out or not.
> > >
> > > Adding the kasan tag bits before last-cpuid makes it much more likely to
> > > end up with a successful build here, and should be reliable for
> > > randconfig at least, as long as that does not randomize NR_CPUS or
> > > NODES_SHIFT but uses the defaults.
> > >
> > > In order for the modified check to not trigger in the x86 vdso32 code
> > > where all constants are wrong (building with -m32), enclose all the
> > > definitions with an #ifdef.
> > >
> >
> > This results in
> >
> > ./include/linux/page-flags-layout.h:95:2: error: #error "Not enough bits in page flags"
> >  #error "Not enough bits in page flags"
> >
> > when trying to build mipsel64:fuloong2e_defconfig.
> 
> Do you have my follow-up fix applied?
> 
> https://ozlabs.org/~akpm/mmots/broken-out/page-flags-prioritize-kasan-bits-over-last-cpuid-fix.patch
> 

No. I see the failure in next-20190729..next-20190805.

I didn't try to apply that patch, but I don't see
arch/mips/vdso/vdso.h in the tree. I only see

arch/mips/include/asm/vdso.h
arch/mips/include/asm/vdso/vdso.h

Are you sure that your patch can be applied as-is ?

Guenter
