Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2483A00
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 22:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfHFUD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 16:03:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35848 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfHFUD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 16:03:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so85963998qtc.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X4WStm4sd99gxcsiHRK905oUotgl76w2o1W1C4yVJ6I=;
        b=dcd3JYDJk152NlFfhO/9qO7tld2EmCF8YFkFxS8Gs6O3Eoi2v5a/p+kLVV72KaaDZH
         4AOPO6UQwsqqSpKlkkmk62Hxppen7/IFJKSpOLIvaEcL3N5LOWdJcJ3uwdOeXMO99Q9Q
         Y+QyzsRM0n6nW3nAnKygZxiG5A+b6hJR/51n9u0k+imi9/6Ip/PFhv8jDVoF1QLCfhOE
         mc8U5KqjaSeDQJIru7Rkv0aQxcqZ/bBs3+8ohxG0EleOYIJ0yGSZ17/3ZQ9kmYzGdGc9
         lnGhK+bfHIxMwOWyuDrIFwNQZiRvrAKnQOXdx2VYo9gZpFBLdNdodmHnLp7wXWjv5EFF
         EsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X4WStm4sd99gxcsiHRK905oUotgl76w2o1W1C4yVJ6I=;
        b=pK8813+Z8oe0MYZ/5W6mVNMsOeV0lmTv+qlm/6tlhu0DKsJ+ChaH9428GkRWTruWu8
         f6xm6raihJiBIfNC4osPzr5RBjyeakBEy+dek1g2kkC3T3c6cWnOPGlLf3hySti2ULFw
         +YEG++xYS+P3v56B7rHIhvuSTGsZ94ENQGlhdVOqDmeN9eMWT7QUB9VtgXTE1gwKG8ST
         49VF9YyCC1snkQQsxig4nvoKWxm5a9qtJRsBKZVAWN66a5emWxieAOcQ+0n31sxWhFp5
         ZH8jk+dGfzlREH1o3F76z3ImqIM5piCqC0V+gz/tsujiq4qKCJm72vrTXaDml6899aSR
         GvtQ==
X-Gm-Message-State: APjAAAWOQ7b4+lRBfUTdLkq2OkAZfQXkbGeFXI9XEVCL0YPeernsFebq
        ImsPCdYDFsL/f9ovQaDTIkh+bA==
X-Google-Smtp-Source: APXvYqx6UY5l/vYT32k/wTnl8SPfwuXYE5Fx1fiKKYFrCmOXi/6TIYwyn3yhKlGhO9HMcVXQYwiuNw==
X-Received: by 2002:ac8:3118:: with SMTP id g24mr4769493qtb.390.1565121837686;
        Tue, 06 Aug 2019 13:03:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g10sm35341761qki.37.2019.08.06.13.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 13:03:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv5ga-0003dB-O6; Tue, 06 Aug 2019 17:03:56 -0300
Date:   Tue, 6 Aug 2019 17:03:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH 15/15] amdgpu: remove CONFIG_DRM_AMDGPU_USERPTR
Message-ID: <20190806200356.GU11627@ziepe.ca>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-16-hch@lst.de>
 <20190806174437.GK11627@ziepe.ca>
 <587b1c3c-83c4-7de9-242f-6516528049f4@amd.com>
 <CADnq5_Puv-N=FVpNXhv7gOWZ8=tgBD2VjrKpVzEE0imWqJdD1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_Puv-N=FVpNXhv7gOWZ8=tgBD2VjrKpVzEE0imWqJdD1A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:58:58PM -0400, Alex Deucher wrote:
> On Tue, Aug 6, 2019 at 1:51 PM Kuehling, Felix <Felix.Kuehling@amd.com> wrote:
> >
> > On 2019-08-06 13:44, Jason Gunthorpe wrote:
> > > On Tue, Aug 06, 2019 at 07:05:53PM +0300, Christoph Hellwig wrote:
> > >> The option is just used to select HMM mirror support and has a very
> > >> confusing help text.  Just pull in the HMM mirror code by default
> > >> instead.
> > >>
> > >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >>   drivers/gpu/drm/Kconfig                 |  2 ++
> > >>   drivers/gpu/drm/amd/amdgpu/Kconfig      | 10 ----------
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  6 ------
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 12 ------------
> > >>   4 files changed, 2 insertions(+), 28 deletions(-)
> > > Felix, was this an effort to avoid the arch restriction on hmm or
> > > something? Also can't see why this was like this.
> >
> > This option predates KFD's support of userptrs, which in turn predates
> > HMM. Radeon has the same kind of option, though it doesn't affect HMM in
> > that case.
> >
> > Alex, Christian, can you think of a good reason to maintain userptr
> > support as an option in amdgpu? I suspect it was originally meant as a
> > way to allow kernels with amdgpu without MMU notifiers. Now it would
> > allow a kernel with amdgpu without HMM or MMU notifiers. I don't know if
> > this is a useful thing to have.
> 
> Right.  There were people that didn't have MMU notifiers that wanted
> support for the GPU.

?? Is that even a real thing? mmu_notifier does not have much kconfig
dependency.

Jason
