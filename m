Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4C145B34
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAVRy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 12:54:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41210 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVRy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:54:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so100846otc.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 09:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQmxC9X4r+WWMdR69BEdmLY43neqR0nbkfhFXKauHQA=;
        b=Dn/N9lxiAwfijL0tWnUM76PCTx/+rur46EmrSEiZlOr505Y4Q97r1MUrMVnQAyyxHe
         PtRe0b0W3qS4sS37LvqBgeXk4p7ilbUUxk5R/olpuk1RuWR9iSA7sl41bl29jvunuxKm
         wobbAtmF1ZaPF+GbcrebZzH/q/puvzLTNgoYy1/i1aVjr4tpSX23zh+ry8C+Sfdrgcr9
         ZBVpOj8SPPzABpwkevJIMd4opKiYJBg8oszoDXoiEgeY26LWo11ur3eGzdFeSxyfKGUn
         NJVxHgldfXN0x1qJO9MfaPJ2ohvDNs3fJ9WdEWYGC7Nxaa7TCBgTfE6H5nxPSzXnqQhh
         7mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQmxC9X4r+WWMdR69BEdmLY43neqR0nbkfhFXKauHQA=;
        b=UaRIsVCgp07B8uJmr139Eylo/V7O5iFdgR6ke6gNo5nYhmXCGYTUYqRO7E50oLA7+R
         zkxaRYa7Nv0aqVxvlCzh+hKYJqGqdgb7n8JZb1+KWozXc1gNkm2ZUddXMGrUThM/Np8f
         YzaIGx4UwxCZJolt9WU832h2+7/Be8kiTdLW4n6U7VQGHD9Sk7pdLo8xvjQwskpuE/N0
         um2c97BErIygYnYNP/+Sy8BNMB9Ubc9Nlu++vYI9swgsUVm3oWhfx5fC9U2AxVxP+Ogp
         HA625Ty4qwdiHqVI+YYyI5nBGQLEDyaEJJ8ZhRg5H5K8noXQDvi2abSPqthQAvXM9WA7
         IYSg==
X-Gm-Message-State: APjAAAXYXlX3iCoPh2qfj7bwuBilBhlhiyF6ULeXBhTx31SKFGz1AfR5
        HTQvmOqLBAGsxovnUtV+7PZHf6RDI1eTg7w7QR8=
X-Google-Smtp-Source: APXvYqzIQUzQ+2cCIMbAKbJ+MhOlaKku+7Ad2F1mpnuzicQFlvL4wxR/yma3uNXZnZh/w29+Gv72uKDWpsqFBX1wjvw=
X-Received: by 2002:a9d:da2:: with SMTP id 31mr7908183ots.319.1579715697465;
 Wed, 22 Jan 2020 09:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-2-xiyou.wangcong@gmail.com> <db1c7741-e280-7930-1659-2ca43e8aac15@arm.com>
 <CAM_iQpUmRKfiQ-P3G-PkRuumXqxN4TPuZtuqoT3+AFjhnkSwQQ@mail.gmail.com> <9033456d-1f17-44a3-2640-24de55421e79@arm.com>
In-Reply-To: <9033456d-1f17-44a3-2640-24de55421e79@arm.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 22 Jan 2020 09:54:46 -0800
Message-ID: <CAM_iQpXxbu+bwsW1MMjeG5feDAjhYjeuAwo6epDi22LJPo6X+Q@mail.gmail.com>
Subject: Re: [Patch v3 1/3] iommu: avoid unnecessary magazine allocations
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 9:07 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 21/01/2020 5:21 pm, Cong Wang wrote:
> > On Tue, Jan 21, 2020 at 3:11 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 18/12/2019 4:39 am, Cong Wang wrote:
> >>> The IOVA cache algorithm implemented in IOMMU code does not
> >>> exactly match the original algorithm described in the paper
> >>> "Magazines and Vmem: Extending the Slab Allocator to Many
> >>> CPUs and Arbitrary Resources".
> >>>
> >>> Particularly, it doesn't need to free the loaded empty magazine
> >>> when trying to put it back to global depot. To make it work, we
> >>> have to pre-allocate magazines in the depot and only recycle them
> >>> when all of them are full.
> >>>
> >>> Before this patch, rcache->depot[] contains either full or
> >>> freed entries, after this patch, it contains either full or
> >>> empty (but allocated) entries.
> >>
> >> How much additional memory overhead does this impose (particularly on
> >> systems that may have many domains mostly used for large, long-term
> >> mappings)? I'm wary that trying to micro-optimise for the "churn network
> >> packets as fast as possible" case may penalise every other case,
> >> potentially quite badly. Lower-end embedded systems are using IOMMUs in
> >> front of their GPUs, video codecs, etc. precisely because they *don't*
> >> have much memory to spare (and thus need to scrape together large
> >> buffers out of whatever pages they can find).
> >
> > The calculation is not complicated: 32 * 6 * 129 * 8 = 198144 bytes,
> > which is roughly 192K, per domain.
>
> Theoretically. On many architectures, kmalloc(1032,...) is going to
> consume rather more than 1032 bytes. Either way, it's rather a lot of
> memory to waste in the many cases where it will never be used at all.

If this is a concern, we can make IOVA_MAG_SIZE tunable in Kconfig.
I myself want a larger IOVA_MAG_SIZE at least for experiments.
You know, servers now have 100G+ memory, 192k is nearly nothing...


>
> >> But on the other hand, if we were to go down this route, then why is
> >> there any dynamic allocation/freeing left at all? Once both the depot
> >> and the rcaches are preallocated, then AFAICS it would make more sense
> >> to rework the overflow case in __iova_rcache_insert() to just free the
> >> IOVAs and swap the empty mag around rather than destroying and
> >> recreating it entirely.
> >
> > It's due to the algorithm requires a swap(), which can't be done with
> > statically allocated magzine. I had the same thought initially but gave it
> > up quickly when realized this.
>
> I'm not sure I follow... we're replacing a "full magazine" pointer with
> an "empty magazine" pointer regardless of where that empty magazine came
> from. It would be trivial to preallocate an 'overflow' magazine for the
> one remaining case of handling a full depot, although to be honest, at
> that point it's probably most efficient to just free the pfns directly
> from cpu_rcache->loaded while still under the percpu lock and be done
> with it.

I don't follow you either. I thought you are suggesting to completely
get rid of dynamic memory allocations like:

@@ -31,7 +31,7 @@ struct iova_cpu_rcache;
 struct iova_rcache {
        spinlock_t lock;
        unsigned long depot_size;
-       struct iova_magazine *depot[MAX_GLOBAL_MAGS];
+       struct iova_magazine depot[MAX_GLOBAL_MAGS];
        struct iova_cpu_rcache __percpu *cpu_rcaches;
 };

If it is so, I don't see how I can do swap() with pointers like
cpu_rcache->prev.

More importantly, this doesn't save any memory either for your embedded
case. So I don't know why you want to bring it up.

>
> > If you are suggesting to change the algorithm, it is not a goal of this
> > patchset. I do have plan to search for a better algorithm as the IOMMU
> > performance still sucks (comparing to no IOMMU) after this patchset,
> > but once again, I do not want to change it in this patchset.
>
> "Still sucks" is probably the most interesting thing here - the headline
> number for the original patch series was that it reached about 98% of
> bypass performance on Intel VT-d[1]. Sounds like it would be well worth
> digging in to what's different about your system and/or workload.

Just FYI: The latency is 10x/20x worse with IOMMU enabled on AMD
servers here. (mlx5 driver for ethernet, if matters.) The throughput
is roughly same. The patchset you linked only measures throughput.


>
> > (My ultimate goal is to find a spinlock-free algorithm, otherwise there is
> > no way to make it close to no-IOMMU performance.)
> >
> >>
> >> Perhaps there's a reasonable compromise wherein we don't preallocate,
> >> but still 'free' empty magazines back to the depot, such that busy
> >> domains will quickly reach a steady-state. In fact, having now dug up
> >> the paper at this point of writing this reply, that appears to be what
> >> fig. 3.1b describes anyway - I don't see any mention of preallocating
> >> the depot.
> >
> > That paper missed a lot of things, it doesn't even recommend a size
> > of a depot or percpu cache. For implementation, we still have to
> > think about those details, including whether to preallocate memory.
>
> Heh, "missed"... To my reading, the original design actually describes a
> depot consisting of two unbounded (but garbage-collected) lists and a
> dynamically-adjusted magazine size - I'd hardly blame the authors for

I must miss the dynamic size part, as I tried to tune IOVA_MAG_SIZE
manually when I initially thought it is overcached.

> not discussing an implementation from 15 years in the future of a
> fixed-size design *based on* their concept ;)

Are you saying fixed-size implementation is wrong? I'd like to hear
more! :) I am curious how to dynamically adjust the magzine size
too as I still don't believe IOVA_MAG_SIZE fits all, also how to
balance the percpu cache. Can you be more elaborate?

Thanks.
