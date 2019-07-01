Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65684F00A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 22:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFUUfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 16:35:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40288 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUUfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 16:35:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id e8so7536184otl.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6N4vzXYO45VrrxREuSle642/F5pE0F/ACcjS4mEnlQ=;
        b=njYNoPS18hXaxkC3YGE+AqCazLdeIo2/cWKB3hIPgn4u04NPPFQdNq7MiKBw9g28ZC
         TDSPMO74uiVh19htSBPeEuLPPpEfbSqb+ixgzUAbMjG3vWKZetmsnwsl3A1elZbZ9Gug
         UFl8VTrGiL5UM+uz3n6ftPJeq2f03VmtpipPbaXcUjEyr06YQxLE0w38exZKyokYjJTs
         JnoNfM52zcdA90Qjk2Yfm5NmOzh+l37okU+SEuoafDF9qgT2+24SWw8iA08wiWyg5YCE
         WWz+HxXWw7kesykyoe/RvQGXNOac96qsEtgulvhXL3J6u665BXRNd5sXTyZrzUbw407V
         tp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6N4vzXYO45VrrxREuSle642/F5pE0F/ACcjS4mEnlQ=;
        b=q+aF7n85tFbVC2JvV4ciaclSbovMNZ2Htcju7g1FJ/bR3QR1vl5aXLFE1HodegXJQT
         bKq0JGKXdXFt+vRAKmUZweicKuAIWoCgEts5cw/rg0NU+E+yAnOKoEHB3EVOL+8Nw4EB
         eWpFIuh8xsioN9mrq9tTvQkmLXLB3eTuB09BPoPIyE4kVQSRCd82jE3Zq0GqQifPc0hM
         HzwTBqrydhyMcI4Y/2WCyFxP808TRDby+7huFCidiFvCa+e14jrHzoRGd4s53x7CZ7H0
         ifdvSQqljB1TBX+ToO05CaJnpB40kSyVlD9bf+gPSF4o7USjXLqfZcAPGYTJeW0oP2z4
         eoWg==
X-Gm-Message-State: APjAAAUvOFnmhL2mnXPrI6zq4aKSmE7nzjpveCYEq+JIY3Tj87v0TKL7
        sBn1KeH8+PcyvVSKsH6WpRrfYMAb35kCpFE9CQDidA==
X-Google-Smtp-Source: APXvYqyVIXwJLQJoHc1HCz5yxPWpUYSffjFt5ymtVvtrHSHsaR7IY2yiXFy/m/3qyTqddC2ne3tKGI+/g0x4KQ1ZATk=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr5297224otn.247.1561149352873;
 Fri, 21 Jun 2019 13:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155993567002.3036719.5748845658364934737.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190607202332.GB32656@bombadil.infradead.org>
In-Reply-To: <20190607202332.GB32656@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Jun 2019 13:35:42 -0700
Message-ID: <CAPcyv4iOKJEJu_dY3ZVmLou-GAxc1=RkhToyodR16LPvLQ3jfA@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] lib/memregion: Uplevel the pmem "region" ida to
 a global allocator
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 1:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jun 07, 2019 at 12:27:50PM -0700, Dan Williams wrote:
> > diff --git a/lib/memregion.c b/lib/memregion.c
> > new file mode 100644
> > index 000000000000..f6c6a94c7921
> > --- /dev/null
> > +++ b/lib/memregion.c
> > @@ -0,0 +1,15 @@
> > +#include <linux/idr.h>
> > +
> > +static DEFINE_IDA(region_ids);
> > +
> > +int memregion_alloc(gfp_t gfp)
> > +{
> > +     return ida_alloc(&region_ids, gfp);
> > +}
> > +EXPORT_SYMBOL(memregion_alloc);
> > +
> > +void memregion_free(int id)
> > +{
> > +     ida_free(&region_ids, id);
> > +}
> > +EXPORT_SYMBOL(memregion_free);
>
> Does this trivial abstraction have to live in its own file?  I'd make
> memregion_alloc/free static inlines that live in a header file, then
> all you need do is find a suitable .c file to store memregion_ids in,
> and export that one symbol instead of two.

Ok, I think since these "memregion" objects tend to be closely related
to "device memory" I'll stash this in kernel/memremap.c with the rest
of the "ZONE_DEVICE" apis.
