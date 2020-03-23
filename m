Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08DD18FA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 17:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCWQtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 12:49:49 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58558 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgCWQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:49:48 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jGQGp-0000hN-4P; Mon, 23 Mar 2020 10:49:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jGQGl-0002wd-IJ; Mon, 23 Mar 2020 10:49:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
References: <20200322110901.GA25108@redhat.com>
        <87lfnsh3tm.fsf@x220.int.ebiederm.org>
        <20200322202929.GA1614@redhat.com>
Date:   Mon, 23 Mar 2020 11:47:12 -0500
In-Reply-To: <20200322202929.GA1614@redhat.com> (Oleg Nesterov's message of
        "Sun, 22 Mar 2020 21:29:29 +0100")
Message-ID: <87imivc92n.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jGQGl-0002wd-IJ;;;mid=<87imivc92n.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/UEZwbnQBg29S5yKyQ6nXK8u3mucJOtHA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3150 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.3 (0.1%), b_tie_ro: 2.9 (0.1%), parse: 1.20
        (0.0%), extract_message_metadata: 6 (0.2%), get_uri_detail_list: 3.4
        (0.1%), tests_pri_-1000: 2.3 (0.1%), tests_pri_-950: 1.04 (0.0%),
        tests_pri_-900: 0.86 (0.0%), tests_pri_-90: 104 (3.3%), check_bayes:
        102 (3.2%), b_tokenize: 7 (0.2%), b_tok_get_all: 8 (0.3%),
        b_comp_prob: 2.3 (0.1%), b_tok_touch_all: 81 (2.6%), b_finish: 0.76
        (0.0%), tests_pri_0: 3013 (95.6%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 2371 (75.3%), poll_dns_idle: 2368 (75.2%),
        tests_pri_10: 2.7 (0.1%), tests_pri_500: 8 (0.3%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] ipc/mqueue.c: change __do_notify() to bypass check_kill_permission()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 03/22, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > Commit cc731525f26a ("signal: Remove kernel interal si_code magic")
>> > changed the value of SI_FROMUSER(SI_MESGQ), this means that mq_notify()
>> > no longer works if the sender doesn't have rights to send a signal.
>> >
>> > Change __do_notify() to use do_send_sig_info() instead of kill_pid_info()
>> > to avoid check_kill_permission().
>>
>> I totally see why you are doing this.  To avoid the permission check,
>> and since this process requested the signal it makes sense to bypass the
>> permission checks.
>
> And this is what we had before cc731525f26a, so this patch tries to fix
> the regression.

I was intending to suggest a new function that took a pid and did not do
the permission checks.

Looking a little further I think there is a reasonbly strong argument
that this code should be using send_sigqueue with a preallocated signal,
just like timers do.

>> The code needs to make certain that this signal is
>> canceled or otherwise won't be sent after an exec.
>
> not sure I understand this part, but see below.
>
>> That said I don't like it.  I would really like to remove the signal
>> sending interfaces that take a task_struct.
>
> Oh, can we discuss the possible cleanups separately? On top of this fix,
> if possible.

I was saying that from my perspective your proposed fix appears to make
the code more of a mess, and harder to maintain.

That is relevant, because if we can't maintain the code it will just
break again or perhaps get worse.

>> Looking at the code I currently see several places where we have this
>> kind of semantic (sending a requested signal to a process from the
>> context of another process): do_notify_parent, pdeath_signal, f_setown,
>> and mq_notify.
>
> To me they all differ, I am not sure I understand how exactly you want
> to unify them...

The common thread is they all are requested by the receiver of the
signal (so don't need permission checks) and thus need to be canceled by
appropriate versions of exec.


>> Especially with the concerns about being able to send a signal after
>> exec, and cause havoc.
> ...
>> Espeically
>> with concerns about being able to send signals to a suid process that
>> would normally fail I think there is an issue here.
>
> I can easily misread this code, never looked into ipc/mqueue.c before.
> But it seems that it is not possible to send a signal after exec, suid
> or not,
>
> 	- sys_mq_open() uses O_CLOEXEC
>
> 	- mqueue_flush_file() does
> 	
> 		if (task_tgid(current) == info->notify_owner)
> 			remove_notification(info);

That is weird.  It looks like we are attempt to handle file descriptor
passing.  The unix98 description of exec says all mq file descriptors
shall be closed, but I can't find a word about file descriptor passing
with af_unix sockets.

>> At the very least can you add a big fat comment about the semantics
>> that userspace expects in this case?
>
> Me? You are kidding ;)
>
> I know absolutely nothing about ipc/mqueue, and when I read this code
> or manpage I find the semantics of mq_notify is very strange.

Well at least a small comment please that says the code started
performing the permission check and userspace code regressed.

Perhaps with the description of the userspace code in the commit log.
Perhaps a test case?

While someone knows what broke I would very much like to capture as much
detail as we can avoid breaking things again in the future.  If we don't
do that now we risk breaking something the next time that code is
changed.

My old copy of unix98 shows no permission checking, and permission
checking does not make sense to me.  So I think it is very much a
problem that I added permission checking by accident.

I really just want to be certain that things are fixed well enough that
we don't risk a regressing again the next time someone touches the code.

Eric
