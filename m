Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE59BE8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 01:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfIYXBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 19:01:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48340 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfIYXBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:01:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDGHV-0000Wk-OZ; Wed, 25 Sep 2019 17:01:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDGHU-00035i-Ok; Wed, 25 Sep 2019 17:01:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20190922115247.GA2679387@kroah.com>
        <20190923200818.GA116090@gmail.com> <20190924113135.GA82089@gmail.com>
        <874l11u30y.fsf@x220.int.ebiederm.org>
        <20190924184159.GA47127@gmail.com>
Date:   Wed, 25 Sep 2019 18:00:39 -0500
In-Reply-To: <20190924184159.GA47127@gmail.com> (Ingo Molnar's message of
        "Tue, 24 Sep 2019 20:41:59 +0200")
Message-ID: <87sgok3rs8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iDGHU-00035i-Ok;;;mid=<87sgok3rs8.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18rghQVtRaShzp5a40Flk4ceYmB9eIJRB0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,T_XMDrugObfuBody_08,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Ingo Molnar <mingo@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 622 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 7 (1.1%), b_tie_ro: 6 (1.0%), parse: 0.87 (0.1%),
        extract_message_metadata: 13 (2.1%), get_uri_detail_list: 3.2 (0.5%),
        tests_pri_-1000: 12 (2.0%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 33 (5.3%), check_bayes: 31
        (5.0%), b_tokenize: 10 (1.7%), b_tok_get_all: 11 (1.8%), b_comp_prob:
        3.7 (0.6%), b_tok_touch_all: 3.3 (0.5%), b_finish: 0.60 (0.1%),
        tests_pri_0: 535 (86.0%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.71 (0.1%), tests_pri_10:
        2.5 (0.4%), tests_pri_500: 13 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [Tree, v2] De-clutter the top level directory, move ipc/ => kernel/ipc/, samples/ => Documentation/samples/ and sound/ => drivers/sound/
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> Ingo Molnar <mingo@kernel.org> writes:
>> 
>> >  - Split it into finer grained steps (3 instead of 2 patches per 
>> >    movement), for easier review and bisection testing:
>> >
>> >      toplevel: Move ipc/ to kernel/ipc/: move the files
>> >      toplevel: Move ipc/ to kernel/ipc/: adjust the build system
>> >      toplevel: Move ipc/ to kernel/ipc/: adjust comments and documentation
>> 
>> Can we not mess with ipc/ please.
>> 
>> I know that will mess with my muscle memory and I don't see the point.
>> Especially as long as it is named ipc and not sysvipc.
>> 
>> A half cleanup really looks worse than a real cleanup.
>> 
>> SysV IPC really is a side car on the kernel and on unix in general
>> and having the directory structure reflect that seems completely sensible.
>
> While such objections are I think valid for scripts/, the situation is 
> very different for ipc/:
>
>  - ipc/ is a tiny subsystem of just ~9k lines of code, and it's in the 
>    top level directory for historical reasons.
>
>  - ipc/ is an established subsystem of old interfaces with comparatively 
>    very few changes these days: there were just about 16 commits added in 
>    the last 12 months that changed the code and had 'ipc' in the title. 
>    Somewhat ironically, the biggest commit of all was a "system call 
>    renaming" commit:
>
>      275f22148e87: ipc: rename old-style shmctl/semctl/msgctl syscalls
>      14 files changed, 137 insertions(+), 62 deletions(-)
>
>    Many of the remaining 15 commits were simple in nature - and there 
>    were 9 different authors, i.e. the per author frequency of changes for 
>    ipc/ is even lower: around one per year for those 9 developers who are 
>    interested in ipc/ changes. I doubt there's much muscle memory even 
>    for them as a result.
>

*snort*  Given how long some of those changes took to review.  No they
were not all simple.   Maybe the final result was but the amount of work
was not simple.
 
>  - The 'muscle memory' argument has to be weighted by probability of 
>    interest (linecount), probability of change (frequency of commits) and 
>    number of authors. These factors add up to a very low change frequency 
>    for ipc/. We've moved and consolidated much, much bigger and higher 
>    frequency subsystems in the recent past, such as kernel/sched/ or 
>    kernel/locking/.

With I presume with the consent and the input of the developers of those
subsystems.  Quite frankly digging into kernel/sched to understand what
is happening right now is a real mess.  It has not made the code any
easier to understand (from my outside perspective).  But if the
developers of the subsystem are fine with it that is their lookout.

>  - The ipc/ location is arguably random and idiosynchratic - it's a 
>    leftover from old times nobody really bothered to clean up - but that 
>    fact shouldn't be a permanent barrier IMO.

Most of the kernel interfaces are random and idiosyncratic.  Most of the
files and most of their contents as well.  That doesn't make them wrong.
It does mean that changing them for the sake of change just increases
the cognitive load on people who have to look after things like that for
no reason.

I figure I have some say in the matter because I am one of the
developers doing some of that looking after.

>  - While uncluttering the top level directory for aesthethic and 
>    documentation reasons is one technical factor, there's another reason 
>    for my ipc/ movement: I have the secret hope to be able to move init/ 
>    to kernel/init/ as well, in which case there's a big muscle memory 
>    advantage for the future: 'i<tab>' would expand to include/ in a 
>    single step! :-) Now *that* is perhaps the highest frequency muscle 
>    memory location in the kernel. ;-)


> Or looking at it from another angle: if we applied your ipc/ benchmark 
> then basically almost *nothing* could be moved from the toplevel 
> directory or any other location, pretty much *ever*.

Please if it ain't broke don't fix it.


On the other hand we still have a terrible mess from the introduction of
threads into the kernel in the 2.5 era.  The cleanup code for tasks is
in terrible shape.  By terrible shape I mean we have data that should be
in signal_struct sill in task_struct, and we have code in release_task
(called when we reap (aka wait on a zombie)) that can very reasonably be
run much sooner, and free up resources in a timely manner.  The worst
part are zombie thread group leaders that are essentially untested in
practice but are a recurring source of errors in kernel code.

Want to help me clean up that code and get rid of zombie thread group
leaders?

Especially if you aren't interested in helping please stay away from the
code I feel responsible for so I can focus on picking up the messes like
that.

Eric

