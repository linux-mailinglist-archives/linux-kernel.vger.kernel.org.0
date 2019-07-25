Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD8874E76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389233AbfGYMrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 08:47:06 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44761 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387824AbfGYMrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:47:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqd9C-0004AP-9n; Thu, 25 Jul 2019 06:47:02 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqd9B-0003uL-6T; Thu, 25 Jul 2019 06:47:02 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
References: <20190724144651.28272-1-christian@brauner.io>
        <20190724144651.28272-2-christian@brauner.io>
        <CAHk-=wjOLjnZdZBSDwNbaWp3uGLGQkgxe-2HmNG5gE4TLbED_w@mail.gmail.com>
Date:   Thu, 25 Jul 2019 07:46:50 -0500
In-Reply-To: <CAHk-=wjOLjnZdZBSDwNbaWp3uGLGQkgxe-2HmNG5gE4TLbED_w@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 24 Jul 2019 10:37:34 -0700")
Message-ID: <87zhl2wabp.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hqd9B-0003uL-6T;;;mid=<87zhl2wabp.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18nF5KW5veMCAros5c3iAikNdUWJfnC4t0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 679 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.7 (0.7%), b_tie_ro: 1.74 (0.3%), parse: 0.85
        (0.1%), extract_message_metadata: 15 (2.2%), get_uri_detail_list: 2.7
        (0.4%), tests_pri_-1000: 26 (3.8%), tests_pri_-950: 1.34 (0.2%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 38 (5.6%), check_bayes: 36
        (5.4%), b_tokenize: 11 (1.7%), b_tok_get_all: 11 (1.6%), b_comp_prob:
        3.4 (0.5%), b_tok_touch_all: 3.5 (0.5%), b_finish: 0.60 (0.1%),
        tests_pri_0: 581 (85.6%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.4 (0.4%), poll_dns_idle: 0.82 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 6 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH 1/5] exit: kill struct waitid_info
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner <christian@brauner.io> wrote:
>>
>> The code here uses a struct waitid_info to catch basic information about
>> process exit including the pid, uid, status, and signal that caused the
>> process to exit. This information is then stuffed into a struct siginfo
>> for the waitid() syscall. That seems like an odd thing to do. We can
>> just pass down a siginfo_t struct directly which let's us cleanup and
>> simplify the whole code quite a bit.
>
> Ack. Except I'd like the commit message to explain where this comes
> from instead of that "That seems like an odd thing to do".
>
> The _original_ reason for "struct waitid_info" was that "siginfo_t" is
> huge because of all the insane padding that various architectures do.
>
> So it was introduced by commit 67d7ddded322 ("waitid(2): leave copyout
> of siginfo to syscall itself") very much to avoid stack usage issues.
> And I quote:
>
>     collect the information needed for siginfo into
>     a small structure (waitid_info)
>
> simply because "sigset_t" was big.
>
> But that size came from the explicit "pad it out to 128 bytes for
> future expansion that will never happen", and the kernel using the
> same exact sigset_t that was exposed to user space.
>
> Then in commit 4ce5f9c9e754 ("signal: Use a smaller struct siginfo in
> the kernel") we got rid of the insane padding for in-kernel use,
> exactly because it causes issues like this.
>
> End result: that "struct waitid_info" no longer makes sense. It's not
> appreciably smaller than kernel_siginfo_t is today, but it made sense
> at the time.

Apologies.  I meant to reply yesterday but I was preempted by baby
issues.

I strongly disagree that this direction makes sense.  The largest
value that I see from struct waitid_info is that it makes it possible to
reason about which values are returned where struct kernel_siginfo does
not.

One of the details the existence of struct waitid_info makes clear is
that unlike the related child death path the wait code does not
fillin si_utime and si_stime.  Which is very important to know when you
are dealing with y2038 issues and Arnd Bergmann is.

The most egregious example I know of using siginfo wrong is:
70f1b0d34bdf ("signal/usb: Replace kill_pid_info_as_cred with
kill_pid_usb_asyncio").  But just by moving struct siginfo out of the
program logic and into dedicated little functions that just deal with
the craziness of struct siginfo I have found lots of little bugs.

We don't need that kind of invitation to bugs in the wait logic.
Especially since it is already known that the wait logic is subtely
wrong in corner cases dealing with threads.  Especially since we have
not fixed those bugs since we don't have enough people who understand
the code well enough to review those fixes.

I think a better direction for cleanups would be to merge struct
waitid_info into struct wait_opts so that we could remove unnecessary
conditionals from the wait code, and maybe make the whole thing less
subtle.



I took a look at this change and the only reduction in code size
or complexity comes from using copy_siginfo_to_user instead of
multiple lines of unsafe_put_user.  That seems to be a worth while
change.  However that can be done by just modifying waitid and
compat_waitid.


There is also a bug in these changes.  The issue is using structure
initializers of struct kernel_siginfo and then copying the structure to
userspace.  I believe KASAN can warn about that now but it might be
sensitive to the architecture specific details of struct kernel_siginfo.

So instead of doing:

+	kernel_siginfo_t kinfo = {
+		.si_signo = 0,
+	};
...
+	if (infop && copy_siginfo_to_user(infop, &kinfo))
 		return -EFAULT;

The code should do:
+	kernel_siginfo_t kinfo;
+	clear_siginfo(&kinfo);
...
+	if (infop && copy_siginfo_to_user(infop, &kinfo))
 		return -EFAULT;


Oleg raised a valid concern about copy_signfo_to_user32 when WNOHANG is
specified.   In that case all of the the siginfo fields should be
set to 0.  Although posix only requires si_pid and si_signo to be zero.

Return without a process due to WNOHANG would probably be clearer if the
code just called clear_user on the whole of the user siginfo.

Eric
