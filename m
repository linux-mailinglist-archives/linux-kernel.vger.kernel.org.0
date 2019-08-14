Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F48D738
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 17:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfHNPa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 11:30:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42255 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfHNPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:30:26 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxvEG-0004eJ-M8; Wed, 14 Aug 2019 15:30:24 +0000
Date:   Wed, 14 Aug 2019 17:30:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        alistair23@gmail.com, ebiederm@xmission.com, arnd@arndb.de,
        dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v2 1/1] waitid: Add support for waiting for the current
 process group
Message-ID: <20190814153023.ruf6m3kxiskhefsv@wittgenstein>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814130732.23572-1-christian.brauner@ubuntu.com>
 <20190814130732.23572-2-christian.brauner@ubuntu.com>
 <20190814141956.GC11595@redhat.com>
 <20190814143545.tu6xfp2mxmnzwkx4@wittgenstein>
 <20190814152712.GE11595@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814152712.GE11595@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:27:12PM +0200, Oleg Nesterov wrote:
> On 08/14, Christian Brauner wrote:
> >
> > On Wed, Aug 14, 2019 at 04:19:57PM +0200, Oleg Nesterov wrote:
> > > On 08/14, Christian Brauner wrote:
> > > >
> > > > +static struct pid *find_get_pgrp(pid_t nr)
> > > > +{
> > > > +	struct pid *pid;
> > > > +
> > > > +	if (nr)
> > > > +		return find_get_pid(nr);
> > > > +
> > > > +	rcu_read_lock();
> > > > +	pid = get_pid(task_pgrp(current));
> > > > +	rcu_read_unlock();
> > > > +
> > > > +	return pid;
> > > > +}
> > >
> > > I can't say I like this helper... even its name doesn't look good to me.
> >
> > Well, naming scheme obviously stolen from find_get_pid(). Not sure if
> > that doesn't look good as well. ;)
> 
> find_get_pid() actually tries to find a pid. The helper above does "find"
> or "use current" depending on nr != 0.
> 
> > > I forgot that we already have get_task_pid() when I replied to the previous
> > > version... How about
> > >
> > > 	case P_PGID:
> > >
> > > 		if (upid)
> > > 			pid = find_get_pid(upid);
> > > 		else
> > > 			pid = get_task_pid(current, PIDTYPE_PGID);
> > >
> > > ?
> >
> > Hmyeah, that works but wouldn't it still be nicer to simply have:
> >
> > static struct pid *get_pgrp(pid_t nr)
> > {
> > 	if (nr)
> > 		return find_get_pid(nr);
> >
> > 	return get_task_pid(current, PIDTYPE_PGID);
> > }
> 
> Who else can ever use it?
> 
> It saves 4 lines in kernel_waitid() but adds 7 lines outside, and you
> need another ^] to see these lines if you try to understand what
> PIDTYPE_PGID actually does. IOW, I think this helper will make waitid
> less readable for no reason.
> 
> 
> Christian, I try to never argue when it comes to cosmetic issues, and
> in this case I won't insist too.

Yeah, I know. I'm not insisisting either. We can do your thing since you
do after all seem to care at least a tiny bit. ;)

Christian
