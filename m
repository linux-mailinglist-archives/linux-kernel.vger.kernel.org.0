Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA0D169988
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 20:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBWTBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 14:01:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43648 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726302AbgBWTBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582484477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWcZhHEavbPC3Qi6XM2pKSsf4FRLtu/oPmsWL6brHIY=;
        b=DyABcoB5XGDthvpfXpq25mwHpE9gstweJa4jxLT3cR49yKgborKNlPkAnSUpMIeUhEV2iT
        s47KJHPVmEBJ/pQyHekAfEgQZZfKw/6Ghs3TQTXWz00oig9w1GbpImcHNHXp5US5Z//5Ny
        kU7doOYUhxZHIEd/kutjVady4uWYeNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-bRjV9tBuNq-TaKDkKNi1mQ-1; Sun, 23 Feb 2020 14:01:13 -0500
X-MC-Unique: bRjV9tBuNq-TaKDkKNi1mQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE633477;
        Sun, 23 Feb 2020 19:01:11 +0000 (UTC)
Received: from localhost (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32B9C1001B30;
        Sun, 23 Feb 2020 19:01:10 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        paulmck@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] ipc: use a work queue to free_ipc
References: <20200217183627.4099690-1-gscrivan@redhat.com>
        <87lfov68a2.fsf@x220.int.ebiederm.org>
Date:   Sun, 23 Feb 2020 20:01:09 +0100
In-Reply-To: <87lfov68a2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 21 Feb 2020 13:37:57 -0600")
Message-ID: <871rqlt9fu.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Giuseppe Scrivano <gscrivan@redhat.com> writes:
>
>> it avoids blocking on synchronize_rcu() in kern_umount().
>>
>> the code:
>>
>> \#define _GNU_SOURCE
>> \#include <sched.h>
>> \#include <error.h>
>> \#include <errno.h>
>> \#include <stdlib.h>
>> int main()
>> {
>>   int i;
>>   for (i  = 0; i < 1000; i++)
>>     if (unshare (CLONE_NEWIPC) < 0)
>>       error (EXIT_FAILURE, errno, "unshare");
>> }
>>
>> gets from:
>>
>> 	Command being timed: "./ipc-namespace"
>> 	User time (seconds): 0.00
>> 	System time (seconds): 0.06
>> 	Percent of CPU this job got: 0%
>> 	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:08.05
>>
>> to:
>>
>> 	Command being timed: "./ipc-namespace"
>> 	User time (seconds): 0.00
>> 	System time (seconds): 0.02
>> 	Percent of CPU this job got: 96%
>> 	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.03
>
> I have a question.  You create 1000 namespaces in a single process
> and then free them.  So I expect that single process is busy waiting
> for that kern_umount 1000 types, and waiting for 1000 synchronize_rcu's.
>
> Does this ever show up in a real world work-load?
>
> Is the cost of a single synchronize_rcu a problem?

yes exactly, creating 1000 namespaces is not a real world use case (at
least in my experience) but I've used it only to show the impact of the
patch.

The cost of the single synchronize_rcu is the issue.

Most containers run in their own IPC namespace, so this is a constant
cost for each container.


> The code you are working to avoid is this.
>
> void kern_unmount(struct vfsmount *mnt)
> {
> 	/* release long term mount so mount point can be released */
> 	if (!IS_ERR_OR_NULL(mnt)) {
> 		real_mount(mnt)->mnt_ns = NULL;
> 		synchronize_rcu();	/* yecchhh... */
> 		mntput(mnt);
> 	}
> }
>
> Which makes me wonder if perhaps there might be a simpler solution
> involving just that code.  But I do realize such a solution
> would require analyzing all of the code after kern_unmount
> to see if any of it depends upon the synchronize_rcu.
>
>
> In summary, I see no correctness problems with your code.
> Code that runs faster is always nice.  In this case I just
> see the cost being shifted somewhere else not eliminated.
> I also see a slight increase in complexity.
>
> So I am wondering if this was an exercise to speed up a toy
> benchmark or if this is an effort to speed of real world code.

I've seen the issue while profiling real world work loads.


> At the very least some version of the motivation needs to be
> recorded so that the next time some one comes in an reworks
> the code they can look in the history and figure out what
> they need to do to avoid introducing a regeression.

Is it enough in the git commit message or should it be an inline
comment?

Thanks,
Giuseppe

