Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D057716AAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 17:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgBXQM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 11:12:29 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:44952 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbgBXQM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:12:28 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6GLL-0002i1-K1; Mon, 24 Feb 2020 09:12:27 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6GLK-0004FA-GG; Mon, 24 Feb 2020 09:12:27 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        paulmck@kernel.org, viro@zeniv.linux.org.uk
References: <20200217183627.4099690-1-gscrivan@redhat.com>
        <87lfov68a2.fsf@x220.int.ebiederm.org> <871rqlt9fu.fsf@redhat.com>
Date:   Mon, 24 Feb 2020 10:10:25 -0600
In-Reply-To: <871rqlt9fu.fsf@redhat.com> (Giuseppe Scrivano's message of "Sun,
        23 Feb 2020 20:01:09 +0100")
Message-ID: <87v9nw2cge.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j6GLK-0004FA-GG;;;mid=<87v9nw2cge.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+smKAMqGSbcwiR5RPIOEc9LaQPhdKGbSI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4740]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Giuseppe Scrivano <gscrivan@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 704 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.8 (0.4%), b_tie_ro: 1.84 (0.3%), parse: 1.45
        (0.2%), extract_message_metadata: 18 (2.6%), get_uri_detail_list: 3.7
        (0.5%), tests_pri_-1000: 21 (2.9%), tests_pri_-950: 1.66 (0.2%),
        tests_pri_-900: 1.00 (0.1%), tests_pri_-90: 65 (9.3%), check_bayes: 63
        (9.0%), b_tokenize: 14 (2.0%), b_tok_get_all: 21 (2.9%), b_comp_prob:
        4.8 (0.7%), b_tok_touch_all: 19 (2.7%), b_finish: 0.77 (0.1%),
        tests_pri_0: 576 (81.8%), check_dkim_signature: 0.97 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 0.49 (0.1%), tests_pri_10:
        3.3 (0.5%), tests_pri_500: 10 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] ipc: use a work queue to free_ipc
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Scrivano <gscrivan@redhat.com> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Giuseppe Scrivano <gscrivan@redhat.com> writes:
>>
>>> it avoids blocking on synchronize_rcu() in kern_umount().
>>>
>>> the code:
>>>
>>> \#define _GNU_SOURCE
>>> \#include <sched.h>
>>> \#include <error.h>
>>> \#include <errno.h>
>>> \#include <stdlib.h>
>>> int main()
>>> {
>>>   int i;
>>>   for (i  = 0; i < 1000; i++)
>>>     if (unshare (CLONE_NEWIPC) < 0)
>>>       error (EXIT_FAILURE, errno, "unshare");
>>> }
>>>
>>> gets from:
>>>
>>> 	Command being timed: "./ipc-namespace"
>>> 	User time (seconds): 0.00
>>> 	System time (seconds): 0.06
>>> 	Percent of CPU this job got: 0%
>>> 	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:08.05
>>>
>>> to:
>>>
>>> 	Command being timed: "./ipc-namespace"
>>> 	User time (seconds): 0.00
>>> 	System time (seconds): 0.02
>>> 	Percent of CPU this job got: 96%
>>> 	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.03
>>
>> I have a question.  You create 1000 namespaces in a single process
>> and then free them.  So I expect that single process is busy waiting
>> for that kern_umount 1000 types, and waiting for 1000 synchronize_rcu's.
>>
>> Does this ever show up in a real world work-load?
>>
>> Is the cost of a single synchronize_rcu a problem?
>
> yes exactly, creating 1000 namespaces is not a real world use case (at
> least in my experience) but I've used it only to show the impact of the
> patch.

I know running 1000 containers is a real use case, and I would not be
surprised if their are configurations that go higher.

> The cost of the single synchronize_rcu is the issue.
>
> Most containers run in their own IPC namespace, so this is a constant
> cost for each container.

Agreed.

>> The code you are working to avoid is this.
>>
>> void kern_unmount(struct vfsmount *mnt)
>> {
>> 	/* release long term mount so mount point can be released */
>> 	if (!IS_ERR_OR_NULL(mnt)) {
>> 		real_mount(mnt)->mnt_ns = NULL;
>> 		synchronize_rcu();	/* yecchhh... */
>> 		mntput(mnt);
>> 	}
>> }
>>
>> Which makes me wonder if perhaps there might be a simpler solution
>> involving just that code.  But I do realize such a solution
>> would require analyzing all of the code after kern_unmount
>> to see if any of it depends upon the synchronize_rcu.
>>
>>
>> In summary, I see no correctness problems with your code.
>> Code that runs faster is always nice.  In this case I just
>> see the cost being shifted somewhere else not eliminated.
>> I also see a slight increase in complexity.
>>
>> So I am wondering if this was an exercise to speed up a toy
>> benchmark or if this is an effort to speed of real world code.
>
> I've seen the issue while profiling real world work loads.

So the question is how to remove this delay.

>> At the very least some version of the motivation needs to be
>> recorded so that the next time some one comes in an reworks
>> the code they can look in the history and figure out what
>> they need to do to avoid introducing a regeression.
>
> Is it enough in the git commit message or should it be an inline
> comment?

The git commit message should be enough to record the motivation.

A comment in the code that about the work queue that says something
like "used to avoid the cost of synchronize_rcu in kern_unmount" would
also be nice.

Eric
