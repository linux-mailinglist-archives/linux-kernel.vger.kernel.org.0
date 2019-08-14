Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C518C73A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 04:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfHNCWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 22:22:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38278 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfHNCWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:22:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so29022708ota.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 19:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8BVuvw3t6MICKGaM59gUM2yEToQKCitDbig7bIPBipc=;
        b=mLHWVPc2XzViL5mr2TusnZ0mnC+7dlsKZVniZcvXdOrbNxLERbn3v/jwLoZeTYqVUn
         5g3/Jq6Aeziwxy0RpUY+5gdXMYhwuv/zlNhSHsK156/UvKGF0KVCRY3CQ3py/oXwYHCk
         113hKC85UTgw8T1FaOQuNFpYni9gBqLm+1DOyxf/sMFiel5z1A9q9t+k9YZ57NPlhJ2d
         +MIyZXqSMVf0ii3HgGKhHV+QM45ABReJ8WUEKavXRKdKIqjomC2lzjgMsIwg+vihBuCy
         8zOiMH0OXm1lKPv9Nu9TAYGR9NDXaJkA6VVW6jsz/0wGx85MZjpj8RjsDvccIK6LQ9b6
         POcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8BVuvw3t6MICKGaM59gUM2yEToQKCitDbig7bIPBipc=;
        b=Kpd0tUV6RdZzWb/m5yHnAL4G4VeVMWx7WgEr0NLIhyutPuyd+DZnPA5RR7611qOigw
         lBEVuZ0yvpzmRjLZCUFz/86RAcMTEHfOM8UMOXMxbGN3PmgsSxhWyAlWSb6L19IcQJNm
         RJqN09tonoWrY+jbA3cOvTFNS9wflvcDXOvBEeRIybAsZJ5zijewVGqR17OmygP+xFqx
         Jw9gkhmNuGEv/CsrFNZJlTls3nEy1d4R8PUmt3FaXfD2IN0UgMx33GdVslQZnSibl639
         OT90Ni7zUnqJb0NZUNRJ0HnbHnB0KhMZZNknGGBFVETm6iRiZReygIfBT2SHzwqGmzSq
         noeg==
X-Gm-Message-State: APjAAAUGd9cUF7rZ75d4N7W+2UYAXH46UQ95HnJ960ib2bSWewTSBmwm
        eGMCxLmaM/6VlrkOtnvTVe0oqQ==
X-Google-Smtp-Source: APXvYqwneMyChwem1IZY1SgCchGO2nCncpWJ+r8g6Oc+o8I11BYTdeZNV/bjkZxCWbUx24fPg2ZFVA==
X-Received: by 2002:a5d:9752:: with SMTP id c18mr82018ioo.22.1565749336873;
        Tue, 13 Aug 2019 19:22:16 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id e22sm17331071iog.2.2019.08.13.19.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 19:22:16 -0700 (PDT)
Date:   Tue, 13 Aug 2019 19:22:15 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Palmer Dabbelt <palmer@sifive.com>
cc:     Christoph Hellwig <hch@infradead.org>, nickhu@andestech.com,
        alankao@andestech.com, aou@eecs.berkeley.edu, green.hu@gmail.com,
        deanbo422@gmail.com, tglx@linutronix.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        Anup Patel <Anup.Patel@wdc.com>,
        Greg KH <gregkh@linuxfoundation.org>, alexios.zavras@intel.com,
        Atish Patra <Atish.Patra@wdc.com>, zong@andestech.com,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/2] riscv: Add memmove string operation.
In-Reply-To: <mhng-ba92c635-7087-4783-baa5-2a111e0e2710@palmer-si-x1e>
Message-ID: <alpine.DEB.2.21.9999.1908131921180.19217@viisi.sifive.com>
References: <mhng-ba92c635-7087-4783-baa5-2a111e0e2710@palmer-si-x1e>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Palmer Dabbelt wrote:

> On Mon, 12 Aug 2019 08:04:46 PDT (-0700), Christoph Hellwig wrote:
> > On Wed, Aug 07, 2019 at 03:19:14PM +0800, Nick Hu wrote:
> > > There are some features which need this string operation for compilation,
> > > like KASAN. So the purpose of this porting is for the features like KASAN
> > > which cannot be compiled without it.
> > > 
> > > KASAN's string operations would replace the original string operations and
> > > call for the architecture defined string operations. Since we don't have
> > > this in current kernel, this patch provides the implementation.
> > > 
> > > This porting refers to the 'arch/nds32/lib/memmove.S'.
> > 
> > This looks sensible to me, although my stringop asm is rather rusty,
> > so just an ack and not a real review-by:
> > 
> > Acked-by: Christoph Hellwig <hch@lst.de>
> 
> FWIW, we just write this in C everywhere else and rely on the compiler to
> unroll the loops.  I always prefer C to assembly when possible, so I'd prefer
> if we just adopt the string code from newlib.  We have a RISC-V-specific
> memcpy in there, but just use the generic memmove.
> 
> Maybe the best bet here would be to adopt the newlib memcpy/memmove as generic
> Linux functions?  They're both in C so they should be fine, and they both look
> faster than what's in lib/string.c.  Then everyone would benefit and we don't
> need this tricky RISC-V assembly.  Also, from the look of it the newlib code
> is faster because the inner loop is unrolled.

There's a generic memmove implementation in the kernel already:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/string.h#n362

Nick, could you tell us more about why the generic memmove() isn't 
suitable?


- Paul
