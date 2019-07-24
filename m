Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828B573E52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 22:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390992AbfGXUYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 16:24:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39150 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389760AbfGXUYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:24:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so32370438wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QhT2aDY6DDwFo4u6pSSbFcjckneqY/fJmJSPh2en2QU=;
        b=exDKJ9fgAtICWDsB/RyvdCl1jI5YfgCIMwTNcxzkx1dyGll/JyL2AkvfnRrYbEirOB
         SEerS90nbZ0Y7uMtaafsNIrKrn2E8fDeOQgPH6N7PGG/abR8nOS6fvcaIr90v+MoUQKL
         Ya6XED0C/nS/Tu4DavDXSBDkL98MKY8aQ7cX7xm2OvAUaFe02AX21Q5ZVMnonR86zf17
         jiYfPhij00tvovhGp4mpN1FJt4aO8yIzLriVTZilkdXv0YgY3MVNNVFA64d7rNVzPt7/
         uDoAdw/I9wt7F4M+AoQ+DsbgfrLlirjsYmK30WF8s1pOpJ9mOGqbMiO76979hv3CBGmj
         6/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhT2aDY6DDwFo4u6pSSbFcjckneqY/fJmJSPh2en2QU=;
        b=iesNvni7DuHBSeYLqR9Y8/gvDzlq/9zBOcVbULmfLoocF+I3BHONXN8dQiUM4NZ9TP
         9SkaAwO7hHSQU5RzdQRy/Eoph4B86IdIUbE5L58yD4LDp8ByX70/RSfMNPd68sAMvMN/
         N2EdMDNedEOtglKq4+XuhFjdaloJousfMTcOSsTgvefDEkRxEGvvYdh0YQpjb6s4TWhg
         S25gENY3QUfWfdxBw6UE4FoXh7Mvv7BpQFkEgVlbT9nHUQ604UMn5GUbi4U2Iik6D9Hi
         6+jmjyEel1rADGaHIuSdxBPQVv1iuKRZQ67Jo7KWDOHCuymUWdgp1trMhdYTi3wTDae6
         xH1Q==
X-Gm-Message-State: APjAAAX3a0ZZfU7MueKoMGEa084DiF1Pcq3f2lv3zuADK3OwQk0lCDqd
        hlZQfC8s7tSGQl2Lvu5nj5641waWAUEJNR5KCdIwRQ==
X-Google-Smtp-Source: APXvYqxenlGpviTUKajhjd5h70fbVtfBZYjpg7adyab446NPvnKr6jujmjoqrk0eooFifFaFDgKzniRhKNTV1qCOUmI=
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr78697953wmg.164.1563999842462;
 Wed, 24 Jul 2019 13:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <3b922aa4-c6d4-e4a4-766d-f324ff77f7b5@linux.com>
 <40f8b7d8-fafa-ad99-34fb-9c63e34917e2@redhat.com> <CALAqxLU199ATrMFa2ARmHOZ3K6ZnOuDLSAqNrTfwOWJaYiW7Yg@mail.gmail.com>
In-Reply-To: <CALAqxLU199ATrMFa2ARmHOZ3K6ZnOuDLSAqNrTfwOWJaYiW7Yg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 24 Jul 2019 13:23:50 -0700
Message-ID: <CALAqxLU0VUp=PGx5=JuVp6c5gwLqpSZJxs7ieL631QhdzNQTyA@mail.gmail.com>
Subject: Re: Limits for ION Memory Allocator
To:     Laura Abbott <labbott@redhat.com>
Cc:     alex.popov@linux.com, Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Riley Andrews <riandrews@android.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Linux-MM <linux-mm@kvack.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Hridya Valsaraju <hridya@google.com>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 1:18 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Jul 24, 2019 at 12:36 PM Laura Abbott <labbott@redhat.com> wrote:
> >
> > On 7/17/19 12:31 PM, Alexander Popov wrote:
> > > Hello!
> > >
> > > The syzkaller [1] has a trouble with fuzzing the Linux kernel with ION Memory
> > > Allocator.
> > >
> > > Syzkaller uses several methods [2] to limit memory consumption of the userspace
> > > processes calling the syscalls for testing the kernel:
> > >   - setrlimit(),
> > >   - cgroups,
> > >   - various sysctl.
> > > But these methods don't work for ION Memory Allocator, so any userspace process
> > > that has access to /dev/ion can bring the system to the out-of-memory state.
> > >
> > > An example of a program doing that:
> > >
> > >
> > > #include <sys/types.h>
> > > #include <sys/stat.h>
> > > #include <fcntl.h>
> > > #include <stdio.h>
> > > #include <linux/types.h>
> > > #include <sys/ioctl.h>
> > >
> > > #define ION_IOC_MAGIC         'I'
> > > #define ION_IOC_ALLOC         _IOWR(ION_IOC_MAGIC, 0, \
> > >                                     struct ion_allocation_data)
> > >
> > > struct ion_allocation_data {
> > >       __u64 len;
> > >       __u32 heap_id_mask;
> > >       __u32 flags;
> > >       __u32 fd;
> > >       __u32 unused;
> > > };
> > >
> > > int main(void)
> > > {
> > >       unsigned long i = 0;
> > >       int fd = -1;
> > >       struct ion_allocation_data data = {
> > >               .len = 0x13f65d8c,
> > >               .heap_id_mask = 1,
> > >               .flags = 0,
> > >               .fd = -1,
> > >               .unused = 0
> > >       };
> > >
> > >       fd = open("/dev/ion", 0);
> > >       if (fd == -1) {
> > >               perror("[-] open /dev/ion");
> > >               return 1;
> > >       }
> > >
> > >       while (1) {
> > >               printf("iter %lu\n", i);
> > >               ioctl(fd, ION_IOC_ALLOC, &data);
> > >               i++;
> > >       }
> > >
> > >       return 0;
> > > }
> > >
> > >
> > > I looked through the code of ion_alloc() and didn't find any limit checks.
> > > Is it currently possible to limit ION kernel allocations for some process?
> > >
> > > If not, is it a right idea to do that?
> > > Thanks!
> > >
> >
> > Yes, I do think that's the right approach. We're working on moving Ion
> > out of staging and this is something I mentioned to John Stultz. I don't
> > think we've thought too hard about how to do the actual limiting so
> > suggestions are welcome.
>
> In part the dmabuf heaps allow for separate heap devices, so we can
> have finer grained permissions to the specific heaps.  But that
> doesn't provide any controls on how much memory one process could
> allocate using the device if it has permission.
>
> I suspect the same issue is present with any of the dmabuf exporters
> (gpu/display drivers, etc), so this is less of an ION/dmabuf heap
> issue and more of a dmabuf core accounting issue.
>

Also, do unmapped memfd buffers have similar accounting issues?

thanks
-john
