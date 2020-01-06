Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85474131854
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 20:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgAFTJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 14:09:09 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40184 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:09:09 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so49725702iop.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 11:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LH1xkVKc5EmMqeCGdpuKvcGOfW0/ozEbE45hEhF4UA=;
        b=YGpWi9upKyMIuvYn59/QrEvmLOsGoRa1tYwvj3DPI5FDHXO0/xaYjHOeYlvIjm31DK
         xlcugAawJk+kBE/WTcATHWiXwm5T6LPDwEZ04bKvrPJRsZeD2YRSMi6+v7KWUbZr1JT/
         epWy670GKSSckBH4+6m0GiimaibaQ8c5y7u/wcRIgCqtwh8808Mbgj/gdFbU075XLA1U
         sT4QP4BfL0p26lBTQVIfg2Wl+g0uqeiUuF0pfN+FhBi5siuMfqKrhPFol7llh5mHdAdZ
         qAAhNhyHws8aEovt1GpT0KRZZ48Rsxcifr0uDfrdWYnSc4w3Ce7la/KJ5CaagEKj5RVI
         ioMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LH1xkVKc5EmMqeCGdpuKvcGOfW0/ozEbE45hEhF4UA=;
        b=XufwpPrB8HqRGzz2sLXIJO2HVfJyDEh5ilG0z10c5JoQbhsLxCMi7c1DK8cqpwwPMJ
         QMdI3uc6+ehvulyk5C3ZvvqU2wEoc8FzGs758vMCdCFHgEaeKCKzJr9eOyaGpskz2o9o
         EMYja3JInPSsUL93uvT9qqpQOTn0GMG65Zb1M8PLn0Qy6yNaLO5XzHRTDiBBz63j09Ve
         n5NghP9JSC1KEjd7Mqb6ujG7p5JFDcV6g1xmALvRrTZa7eIfseXFRq22yDvalnsF/geq
         rSej1N5YA/Epp/GQDG6NoMXjl00vlKEmdDS+PpreSHwdf/Fy80d+1GE+N5JLoyHGpoiw
         8QUg==
X-Gm-Message-State: APjAAAV9BfINFUQtH3e+cF3oSYK6WLDue9l2bPh7QU2B3St2ny7BPCLf
        GyT+IaYm6/ZczPx5L66JX8CX4ksr7a3Nc9v6ww7tlQ==
X-Google-Smtp-Source: APXvYqwqP+NtxtTdTXYzk0kr4E4hPHW59SC50OrvliLIAV6AcRYlhCflxv2wBey1Y+3ca6PlDxBYzCqvWnibi2J8Rlw=
X-Received: by 2002:a02:910a:: with SMTP id a10mr79638858jag.134.1578337748167;
 Mon, 06 Jan 2020 11:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20191226220205.128664-1-semenzato@google.com> <20191226220205.128664-2-semenzato@google.com>
 <20200106125352.GB9198@dhcp22.suse.cz>
In-Reply-To: <20200106125352.GB9198@dhcp22.suse.cz>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Mon, 6 Jan 2020 11:08:56 -0800
Message-ID: <CAA25o9S7EzQ0xcoxuWtYr2dd0WB4KSQNP4OxPb2gAeaz0EgomA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: clarify limitations of hibernation
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 4:53 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 26-12-19 14:02:04, Luigi Semenzato wrote:
> [...]
> > +Limitations of Hibernation
> > +==========================
> > +
> > +When entering hibernation, the kernel tries to allocate a chunk of memory large
> > +enough to contain a copy of all pages in use, to use it for the system
> > +snapshot.  If the allocation fails, the system cannot hibernate and the
> > +operation fails with ENOMEM.  This will happen, for instance, when the total
> > +amount of anonymous pages (process data) exceeds 1/2 of total RAM.
> > +
> > +One possible workaround (besides terminating enough processes) is to force
> > +excess anonymous pages out to swap before hibernating.  This can be achieved
> > +with memcgroups, by lowering memory usage limits with ``echo <new limit> >
> > +/dev/cgroup/memory/<group>/memory.mem.usage_in_bytes``.  However, the latter
> > +operation is not guaranteed to succeed.
>
> I am not familiar with the hibernation process much. But what prevents
> those allocations to reclaim memory and push out the anonymous memory to
> the swap on demand during the hibernation's allocations?

Good question, thanks.

The hibernation image is stored into a swap device (or partition), so
I suppose one could set up two swap devices, giving a lower priority
to the hibernation device, so that it remains unused while the kernel
reclaims pages for the hibernation image.

If that works, then it may be appropriate to describe this technique
in Documentation/power/swsusp.rst.  There's a brief mention of this
situation in the Q/A section, but maybe this deserves more visibility.

In my experience, the page allocator is prone to giving up in this
kind of situation.  But my experience is up to 4.X kernels.  Is this
guaranteed to work now?

Note that I removed the cgroup suggestion in later versions of this patch:
https://marc.info/?l=linux-pm&m=157800718520897

Also, there was some related discussion here:
https://marc.info/?l=linux-kernel&m=157177497015315

Thanks!



> --
> Michal Hocko
> SUSE Labs
