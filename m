Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E2FC405
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 11:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKNKX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 05:23:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34861 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfKNKX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:23:57 -0500
Received: from [79.140.120.64] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iVCI0-0004Z2-Iy; Thu, 14 Nov 2019 10:23:48 +0000
Date:   Thu, 14 Nov 2019 11:23:47 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        alpha <linux-alpha@vger.kernel.org>, fweimer@redhat.com,
        libc-alpha@sourceware.org
Subject: Re: [PATCH 11/23] y2038: rusage: use __kernel_old_timeval
Message-ID: <20191114102346.bjwsz2iup7pg7mgd@wittgenstein>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108211323.1806194-2-arnd@arndb.de>
 <20191112210915.GD5130@uranus>
 <CAK8P3a03FRfTsXADH+xfLsWxCu54JXvXbb-OdyGXXf88RNP34w@mail.gmail.com>
 <20191114003822.6fjji26vm7yplaw2@wittgenstein>
 <CAK8P3a2JtyfFifSWNd2MA-J=6-NdgPd4eNva+u193bzQTX6Qig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2JtyfFifSWNd2MA-J=6-NdgPd4eNva+u193bzQTX6Qig@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc Florian, libc-alpha]

On Thu, Nov 14, 2019 at 11:18:15AM +0100, Arnd Bergmann wrote:
> On Thu, Nov 14, 2019 at 1:38 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > On Wed, Nov 13, 2019 at 11:02:12AM +0100, Arnd Bergmann wrote:
> > > On Tue, Nov 12, 2019 at 10:09 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 08, 2019 at 10:12:10PM +0100, Arnd Bergmann wrote:
> > >
> > > > > ---
> > > > > Question: should we also rename 'struct rusage' into 'struct __kernel_rusage'
> > > > > here, to make them completely unambiguous?
> > > >
> > > > The patch looks ok to me. I must confess I looked into rusage long ago
> > > > so __kernel_timespec type used in uapi made me nervious at first,
> > > > but then i found that we've this type defined in time_types.h uapi
> > > > so userspace should be safe. I also like the idea of __kernel_rusage
> > > > but definitely on top of the series.
> > >
> > > There are clearly too many time types at the moment, but I'm in the
> > > process of throwing out the ones we no longer need now.
> > >
> > > I do have a number patches implementing other variants for the syscall,
> > > and I suppose that if we end up adding __kernel_rusage, that would
> > > have to go with a set of syscalls using 64-bit seconds/nanoseconds
> > > rather than the old 32/64 microseconds. I don't know what other
> > > changes remain that anyone would want from sys_waitid() now that
> > > it does support pidfd.
> > >
> > > If there is still a need for a new waitid() replacement, that should take
> > > that new __kernel_rusage I think, but until then I hope we are fine
> > > with today's getrusage+waitid based on the current struct rusage.
> >
> > Note, that glibc does _not_ expose the rusage argument, i.e. most of
> > userspace is unaware that waitid() does allow you to get rusage
> > information. So users first need to know that waitid() has an rusage
> > argument and then need to call the waitid() syscall directly.
> 
> On architectures that don't have a wait4 syscall (riscv32 for now),
> glibc uses waitid to implement wait4 and wait3.

Yes, and there's an ongoing discussion to implement wait4() on all
arches through waitid(), I think. I haven't followed it too closely.

> 
> > > BSD has wait6() to return separate rusage structures for 'self' and
> > > 'children', but I could not find any application (using the freebsd
> > > sources and debian code search) that actually uses that information,
> > > so there might not be any demand for that.
> >
> > Speaking specifically for Linux now, I think that rusage does not
> > actually expose the information most relevant users are interested in.
> > On Linux nowadays it is _way_ more interesting to retrieve stats
> > relative to the cgroup the task lived in etc.
> > Doing a git grep -i rusage in the systemd source code shows that rusage
> > is used _nowhere_. And I consider an init system to be the most likely
> > candidate to be interested in rusage.
> 
> I looked at a couple of implementations of time(1), this is one example
> that sometimes uses wait3(), though other implementations just call
> getrusage() in the parent process before the fork/exec. None of them
> actually seem to report better than millisecond resolution, so there is
> not a strict reason to do a timespec replacement for these.

Right, though I have to say that for the sake of consistency I'd much
rather have a replacement. We're doing all this work right now so we
might as well. But I get the point.

	Christian
