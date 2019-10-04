Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA11FCBB6A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfJDNP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 09:15:28 -0400
Received: from mail-yb1-f179.google.com ([209.85.219.179]:40105 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbfJDNP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:15:27 -0400
Received: by mail-yb1-f179.google.com with SMTP id g9so2086312ybi.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/UcVhX9GaoSfCR5Nzgmo8T8FLFMJ0xd65q4Shx2Kmts=;
        b=aVs4zyKIMELcbbp0OrZDIIRM6M9FqgqBWOj7D/V0OOVxjk/TCK1tb1H33aayEVT9Fq
         NOF79kJ75vl2d2aHQWCNVE3mdS8xv2agwN5v/GWtJcU0doJRauKDjzYg6Q6Aok4YYi3b
         mqNPN9hT3Q49dLWzDmTUjRAHeblmpVkFSji5wQrOx6/uMD4mWAJGCY15WvCoWVOEjYTY
         zLXisVJYNrNI9DPaiv0kVngz338cFFvM+h3OzJgZEFf8gZFZm7Iiy5tpDfP2d3CkVb0j
         V4Ux/4E3Ys8h0MioMBqFvf8jY+vH9oklDJ5qpoyn4dUJxko+npNTfqsfS9FFgD1YpKeU
         TCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/UcVhX9GaoSfCR5Nzgmo8T8FLFMJ0xd65q4Shx2Kmts=;
        b=nLnavJQRwEMTfAv3mvAYHBbmZqCI2jUpQ01QoMbmuapu/Myu4xyzza7lQCZRFVZ5T8
         oUXUiqK3bQLlUmcwZvGa8J68dkc5Oj2NSprSo6hshRFB9OFxTRTpP2R1bPM8pQHqaoi/
         oA3VwJogeGdA20fD/7ushiK9YMdiDTIzYqa5BXGb0BMuNpwunHQUmn8ZCklK5cj6Xgt/
         0lgFFkdIm0MI+nwlwRoIu2r3T4kGcJsAydy01mbhX/+KiGaTxZWe4ywIek4or0CdNnhg
         Xq0pylluo8w64SqRWh36oPnCS2BY2OXsZQjoN0YJRBNklFwOMlhtk3awkL1wP5chEAuO
         xsJg==
X-Gm-Message-State: APjAAAUvtuzIgSgQCgFbYC6blZybhCU7huooY4/cFoF7gofssDFWOluN
        8GyYAZcnpzAwBpmse6EeRPKnVKekpt6fSAHrQOcNa8ma7AN1zQ==
X-Google-Smtp-Source: APXvYqzwEQFavuGTQfqs5oMner1fD3hr86iQqTMlgoG4RfUPbRmbA3D9aQz/XYkIYsRESetVSOBhZBfVuAsxsNy+MeI=
X-Received: by 2002:a25:8149:: with SMTP id j9mr1749501ybm.132.1570194926383;
 Fri, 04 Oct 2019 06:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191003201858.11666-1-dave@stgolabs.net> <20191004002609.GB1492@ziepe.ca>
In-Reply-To: <20191004002609.GB1492@ziepe.ca>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 4 Oct 2019 06:15:11 -0700
Message-ID: <CANN689G3chM1FjFPdCNm9_OQxazs7YP1PuZLpqGtq=qzaZ0Hbw@mail.gmail.com>
Subject: Re: [PATCH -next 00/11] lib/interval-tree: move to half closed intervals
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, Oct 3, 2019 at 5:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> Hurm, this is not entirely accurate. Most users do actually want
> overlapping and multiple ranges. I just studied this extensively:

(Just curious, are you the person we discussed this with after the
Maple Tree talk at LPC 2019 ?)

I think we have two separate API problems there:
- overlapping vs non-overlapping intervals (the interval tree API
supports overlapping intervals, but some users are confused about
this)
- closed vs half-open interval definitions

It looks like you have been looking mostly at the first issue, which I
expect could simplify several interval tree users considerably, while
Davidlohr is addressing the second issue here.

> radeon_mn actually wants overlapping but seems to mis-understand the
> interval_tree API and actively tries hard to prevent overlapping at
> great cost and complexity. I have a patch to delete all of this and
> just be overlapping.
>
> amdgpu_mn copied the wrongness from radeon_mn
>
> All the DRM drivers are basically the same here, tracking userspace
> controlled VAs, so overlapping is essential
>
> hfi1/mmu_rb definitely needs overlapping as it is dealing with
> userspace VA ranges under control of userspace. As do the other
> infiniband users.

Do you have a handle on what usnic is doing with its intervals ?
usnic_uiom_insert_interval() has some complicated logic to avoid
having overlapping intervals, which is very confusing to me.

> vhost probably doesn't overlap in the normal case, but again userspace
> could trigger overlap in some pathalogical case.
>
> The [start,last] allows the interval to cover up to ULONG_MAX. I don't
> know if this is needed however. Many users are using userspace VAs
> here. Is there any kernel configuration where ULONG_MAX is a valid
> userspace pointer? Ie 32 bit 4G userspace? I don't know.
>
> Many users seemed to have bugs where they were taking a userspace
> controlled start + length and converting them into a start/end for
> interval tree without overflow protection (woops)
>
> Also I have a series already cooking to delete several of these
> interval tree users, which will terribly conflict with this :\
>
> Is it really necessary to make such churn for such a tiny API change?

My take is that this (Davidlohr's) patch series does not necessarily
need to be applied all at once - we could get the first change in
(adding the interval_tree_gen.h header), and convert the first few
users, without getting them all at once, as long as we have a plan for
finishing the work. So, if you have cleanups in progress in some of
the files, just tell us which ones and we can leave them out from the
first pass.

Thanks,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
