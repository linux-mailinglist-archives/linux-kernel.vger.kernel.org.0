Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEBBFABF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 09:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKMIW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 03:22:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37638 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfKMIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:22:48 -0500
Received: by mail-oi1-f195.google.com with SMTP id y194so1028606oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 00:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ayY6gCXrrA3VgRAyrp2bK0EyrP0ektptyzgRBWzw5I=;
        b=A+5ZDAwm0sisXEXV26bplYhx0LMI9tSEqcz5XKqugaaiNBsieQDhWSu2ezHIxsk3ok
         PapqJ40EqXbuXexGXvb3dctMfbGHjaFuYDAai4pvCrk3ttwW8fkWJFMlnWK5Sh3WDfzP
         au9tTKQUHDCal3qSVw21r18Mu3ZTlLggTEjdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ayY6gCXrrA3VgRAyrp2bK0EyrP0ektptyzgRBWzw5I=;
        b=hMTG8dcjpwyIb+EzXfaPk/a6hZKSOhoWb7AvKBI/KMXrjjGzCOdNnl043uH8/Uitrv
         vrf+a8u2MN23omLyvYBEl1qxSl4hAO791BIFmH0kgiblre2xmN0ShpDfm5qI2VK2PMYQ
         3A8+CuOePyrLLG0P1DOKHHI5lkmHA2euy6WRdaKv2T4AYt6xa9K0lAGhikQzvgAfBH6S
         4JE0vnoZojQYE3NGE9D40pd3B5mACcsEnYKVZFXu/dxPKOKCjrBtnA8H8PShH663z8TX
         0Lht+zRL3FclXPIWN4Ms9Jc6zu3NiBjA75i9ePvXiznRA/Njo6xPo8KPKGRP8WKQOIcL
         JuYQ==
X-Gm-Message-State: APjAAAW+BPpPkcgXWgnW3g0HP2KJKDYC4XL6A3rbBaGpSZCBdpP06Ioe
        cwsst8I3Fxza0y0usaGrBGvfAjbgk0VX6D4FzNAWMw==
X-Google-Smtp-Source: APXvYqxfSdLpxppf1Yvj8Pnz7e2iZsxyqjYKBICjfkF8MEX8zkGbqRRzZo57EW2FfCAXfyKFCc6JsAljOesoFoCv0a8=
X-Received: by 2002:a05:6808:4cf:: with SMTP id a15mr1806257oie.132.1573633368138;
 Wed, 13 Nov 2019 00:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20191112000700.3455038-1-jhubbard@nvidia.com> <20191112203802.GD5584@ziepe.ca>
 <02fa935c-3469-b766-b691-5660084b60b9@nvidia.com>
In-Reply-To: <02fa935c-3469-b766-b691-5660084b60b9@nvidia.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 13 Nov 2019 09:22:36 +0100
Message-ID: <CAKMK7uHvk+ti00mCCF2006U003w1dofFg9nSfmZ4bS2Z2pEDNQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] mm/gup: track dma-pinned pages: FOLL_PIN, FOLL_LONGTERM
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, kvm@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, linux-rdma@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:10 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 11/12/19 12:38 PM, Jason Gunthorpe wrote:
> > On Mon, Nov 11, 2019 at 04:06:37PM -0800, John Hubbard wrote:
> >> Hi,
> >>
> >> The cover letter is long, so the more important stuff is first:
> >>
> >> * Jason, if you or someone could look at the the VFIO cleanup (patch 8)
> >>   and conversion to FOLL_PIN (patch 18), to make sure it's use of
> >>   remote and longterm gup matches what we discussed during the review
> >>   of v2, I'd appreciate it.
> >>
> >> * Also for Jason and IB: as noted below, in patch 11, I am (too?) boldly
> >>   converting from put_user_pages() to release_pages().
> >
> > Why are we doing this? I think things got confused here someplace, as
>
>
> Because:
>
> a) These need put_page() calls,  and
>
> b) there is no put_pages() call, but there is a release_pages() call that
> is, arguably, what put_pages() would be.
>
>
> > the comment still says:
> >
> > /**
> >  * put_user_page() - release a gup-pinned page
> >  * @page:            pointer to page to be released
> >  *
> >  * Pages that were pinned via get_user_pages*() must be released via
> >  * either put_user_page(), or one of the put_user_pages*() routines
> >  * below.
>
>
> Ohhh, I missed those comments. They need to all be changed over to
> say "pages that were pinned via pin_user_pages*() or
> pin_longterm_pages*() must be released via put_user_page*()."
>
> The get_user_pages*() pages must still be released via put_page.
>
> The churn is due to a fairly significant change in strategy, whis
> is: instead of changing all get_user_pages*() sites to call
> put_user_page(), change selected sites to call pin_user_pages*() or
> pin_longterm_pages*(), plus put_user_page().

Can't we call this unpin_user_page then, for some symmetry? Or is that
even more churn?

Looking from afar the naming here seems really confusing.
-Daniel

> That allows incrementally converting the kernel over to using the
> new pin APIs, without taking on the huge risk of a big one-shot
> conversion.
>
> So, I've ended up with one place that actually needs to get reverted
> back to get_user_pages(), and that's the IB ODP code.
>
> >
> > I feel like if put_user_pages() is not the correct way to undo
> > get_user_pages() then it needs to be deleted.
> >
>
> Yes, you're right. I'll fix the put_user_page comments() as described.
>
>
> thanks,
>
> John Hubbard
> NVIDIA



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
