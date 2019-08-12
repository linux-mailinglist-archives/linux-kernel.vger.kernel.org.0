Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70F38A3CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 18:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfHLQvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 12:51:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52108 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLQvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:51:48 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxDXf-0003Da-H4; Mon, 12 Aug 2019 16:51:31 +0000
Date:   Mon, 12 Aug 2019 18:51:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v5 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190812165130.d3b5smm45dpxk6m4@wittgenstein>
References: <20190811203327.5385-1-areber@redhat.com>
 <20190812163710.GC31560@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190812163710.GC31560@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 06:37:10PM +0200, Oleg Nesterov wrote:
> On 08/11, Adrian Reber wrote:
> >
> >  include/linux/pid.h        |  2 +-
> >  include/linux/sched/task.h |  1 +
> >  include/uapi/linux/sched.h |  1 +
> >  kernel/fork.c              | 22 ++++++++++++++++++++--
> >  kernel/pid.c               | 36 +++++++++++++++++++++++++++++-------
> >  5 files changed, 52 insertions(+), 10 deletions(-)
> 
> Looks good to me...
> 
> A couple of nits below, but I won't insist, feel free to ignore.
> 
> > +/*
> > + * Different sizes of struct clone_args
> > + */
> > +#define CLONE3_ARGS_SIZE_V0 64
> 
> I don't really understand why do we want the "size < CLONE3_ARGS_SIZE_V0"
> check in copy_clone_args_from_user(), but I won't argue.

To make sure a user can't give us a garbage sized struct that is smaller
than the initial version of the struct. Hm, maybe you did make a
suggestion how to detect this case that I missed in one of the previous
reviews or why it's not needed?
