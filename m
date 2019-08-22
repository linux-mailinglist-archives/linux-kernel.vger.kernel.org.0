Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C68A099681
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 16:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfHVO1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 10:27:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46864 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbfHVO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:27:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so5570863otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxSEtX2z/ZJV/B0XcD4BCr1O2HbvzOrzKNcLT4JypFY=;
        b=bThEovQjDRPbGQci1oGNwl98knwGtDbVI9tycUtNpAD5WH/u71hGUtM2xhNVyI5R1f
         fOd+c1dN12ruUyXlb/wEqY3WTmbAJQU4afNsp98FtxyMr/7sUppyEdf1DRZ18OTqR0+C
         AIRU6Cjy4Kh+FYM1N/+/DUewnmCrWcZwia6BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxSEtX2z/ZJV/B0XcD4BCr1O2HbvzOrzKNcLT4JypFY=;
        b=RG7ryBfeSyN7ym1OgtFzv4zlL/hXBGABvU6tp4pxugpKmIcBiFPuaEl4hQh1DBzNHY
         ZxEw3GCl6gESIX/Ubxv1iLNWKvJtj4HCnJw0nl/DzIJfKbLArKa3s3KufICOwlin2d7+
         0L4I8iSCJEGH5EaX9oF+UC/U0HlHDndEn3Vp3YEH85Q9MfPc/bLQBSy3erH0URSqmJ2t
         CxDbS3khZMx5benrmmvHUJehknsr999Yphiyfsl1u0fyw6dvANFzMforRt/qdvBbE4bY
         GKptgTCGFCRHrAGA4r0FDPppdAU3iKQxP0JC8rirdv2viGEiPcNsvOiZQovwHZCIbuJ4
         dSLw==
X-Gm-Message-State: APjAAAWoyDzzrzcqO8QtyEcy4QfmKWjy8YxIp4mEH8KimK4wD3O9cZZx
        EVowru0/1N6PTUKLW0/JxJPLo9F2B6WeY+KZt7QxNQ==
X-Google-Smtp-Source: APXvYqzrWuV30uDAlQUdwtvK/fFSj1j/bZ180iv5Fx+HFnPaAc75KsLZP2Z8mNCZI4plTUPZzv1Ihu5g4y0wy4zzZSI=
X-Received: by 2002:a9d:7087:: with SMTP id l7mr1213445otj.281.1566484050304;
 Thu, 22 Aug 2019 07:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-5-daniel.vetter@ffwll.ch> <20190820133418.GG29246@ziepe.ca>
 <20190820151810.GG11147@phenom.ffwll.local> <20190821154151.GK11147@phenom.ffwll.local>
 <20190821161635.GC8653@ziepe.ca> <CAKMK7uERsmgFqDVHMCWs=4s_3fHM0eRr7MV6A8Mdv7xVouyxJw@mail.gmail.com>
 <20190822142410.GB8339@ziepe.ca>
In-Reply-To: <20190822142410.GB8339@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 22 Aug 2019 16:27:18 +0200
Message-ID: <CAKMK7uF5CMSUrG2jTYJ9M7tDK_Saxmxk6yLs62tfc-Ozj3p2BQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, notifier: Catch sleeping/blocking for !blockable
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 4:24 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Aug 22, 2019 at 10:42:39AM +0200, Daniel Vetter wrote:
>
> > > RDMA has a mutex:
> > >
> > > ib_umem_notifier_invalidate_range_end
> > >   rbt_ib_umem_for_each_in_range
> > >    invalidate_range_start_trampoline
> > >     ib_umem_notifier_end_account
> > >       mutex_lock(&umem_odp->umem_mutex);
> > >
> > > I'm working to delete this path though!
> > >
> > > nonblocking or not follows the start, the same flag gets placed into
> > > the mmu_notifier_range struct passed to end.
> >
> > Ok, makes sense.
> >
> > I guess that also means the might_sleep (I started on that) in
> > invalidate_range_end also needs to be conditional? Or not bother with
> > a might_sleep in invalidate_range_end since you're working on removing
> > the last sleep in there?
>
> I might suggest the same pattern as used for locked, the might_sleep
> unconditionally on the start, and a 2nd might sleep after the IF in
> __mmu_notifier_invalidate_range_end()
>
> Observing that by audit all the callers already have the same locking
> context for start/end

My question was more about enforcing that going forward, since you're
working to remove all the sleeps from invalidate_range_end. I don't
want to add debug annotations which are stricter than what the other
side actually expects. But since currently there is still sleeping
locks in invalidate_range_end I think I'll just stick them in both
places. You can then (re)move it when the cleanup lands.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
