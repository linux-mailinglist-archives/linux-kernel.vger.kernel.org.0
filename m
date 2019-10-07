Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71774CDFA3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfJGKuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 06:50:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44275 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfJGKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:50:51 -0400
Received: from [185.66.195.251] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iHQbH-00040P-0C; Mon, 07 Oct 2019 10:50:47 +0000
Date:   Mon, 7 Oct 2019 12:50:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     bsingharora@gmail.com, elver@google.com,
        linux-kernel@vger.kernel.org,
        syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] taskstats: fix data-race
Message-ID: <20191007105044.x7srxpcedfo3o5m4@wittgenstein>
References: <20191005112806.13960-1-christian.brauner@ubuntu.com>
 <20191006235216.7483-1-christian.brauner@ubuntu.com>
 <20191007104039.GA16085@andrea.guest.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007104039.GA16085@andrea.guest.corp.microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 12:40:39PM +0200, Andrea Parri wrote:
> Hi Christian,
> 
> On Mon, Oct 07, 2019 at 01:52:16AM +0200, Christian Brauner wrote:
> > When assiging and testing taskstats in taskstats_exit() there's a race
> > when writing and reading sig->stats when a thread-group with more than
> > one thread exits:
> > 
> > cpu0:
> > thread catches fatal signal and whole thread-group gets taken down
> >  do_exit()
> >  do_group_exit()
> >  taskstats_exit()
> >  taskstats_tgid_alloc()
> > The tasks reads sig->stats holding sighand lock seeing garbage.
> > 
> > cpu1:
> > task calls exit_group()
> >  do_exit()
> >  do_group_exit()
> >  taskstats_exit()
> >  taskstats_tgid_alloc()
> > The task takes sighand lock and assigns new stats to sig->stats.
> > 
> > Fix this by using READ_ONCE() and smp_store_release().
> > 
> > Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> FYI, checkpatch.pl says:
> 
> WARNING: memory barrier without comment
> #62: FILE: kernel/taskstats.c:568:
> +		smp_store_release(&sig->stats, stats_new);
> 
> Maybe you can make checkpatch.pl happy  ;-) and add a comment to stress
> the 'pairing' between this barrier and the added READ_ONCE() (as Dmitry
> was alluding to in a previous post)?

Of course. I totally forgot the memory barrier documentation requirement.

Christian
