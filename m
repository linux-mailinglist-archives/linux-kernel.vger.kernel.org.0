Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9698D365
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfHNMpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 08:45:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37416 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfHNMpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:45:55 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxsf2-0001rt-Q7; Wed, 14 Aug 2019 12:45:52 +0000
Date:   Wed, 14 Aug 2019 14:45:51 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        alistair23@gmail.com, ebiederm@xmission.com, arnd@arndb.de,
        dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v1 1/1] waitid: Add support for waiting for the current
 process group
Message-ID: <20190814124551.hnt363g3blhuf2pv@wittgenstein>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814113822.9505-1-christian.brauner@ubuntu.com>
 <20190814113822.9505-2-christian.brauner@ubuntu.com>
 <20190814122909.GA11595@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814122909.GA11595@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 02:29:10PM +0200, Oleg Nesterov wrote:
> On 08/14, christian.brauner@ubuntu.com wrote:
> >
> >  	case P_PGID:
> >  		type = PIDTYPE_PGID;
> > -		if (upid <= 0)
> > +		if (upid < 0)
> >  			return -EINVAL;
> > +
> > +		if (upid == 0)
> > +			pid = get_pid(task_pgrp(current));
> 
> this needs rcu lock or tasklist_lock, this can race with another thread
> doing sys_setpgid/setsid (see change_pid(PIDTYPE_PGID)).

Oh, I naively assumed task_pgrp() would take an rcu lock...

kernel/sys.c takes both, i.e.

rcu_read_lock();
write_lock_irq(&tasklist_lock);

though I think we should be fine with just rcu_read_lock(). setpgid()
indicates that it wants to check real_parent and needs the
write_lock_irq() because it might change behind its back which we don't
care about since we're not changing the pgrp.

Christian
