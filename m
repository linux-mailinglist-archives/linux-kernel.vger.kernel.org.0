Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDFB1903BE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 04:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgCXC75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 22:59:57 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47478 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgCXC75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 22:59:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jGZn8-0005r7-OH; Mon, 23 Mar 2020 20:59:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jGZn7-0005bB-OL; Mon, 23 Mar 2020 20:59:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
References: <20200322110901.GA25108@redhat.com>
        <87lfnsh3tm.fsf@x220.int.ebiederm.org>
        <20200322202929.GA1614@redhat.com>
        <87imivc92n.fsf@x220.int.ebiederm.org>
        <20200323191214.81a60c4ae1a59fdbd5c5d46d@linux-foundation.org>
Date:   Mon, 23 Mar 2020 21:57:14 -0500
In-Reply-To: <20200323191214.81a60c4ae1a59fdbd5c5d46d@linux-foundation.org>
        (Andrew Morton's message of "Mon, 23 Mar 2020 19:12:14 -0700")
Message-ID: <87bloma29h.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jGZn7-0005bB-OL;;;mid=<87bloma29h.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18X0LNZ347AoJx56b1D2zQeeFKGzC+6jys=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4993]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andrew Morton <akpm@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 409 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 9 (2.3%), parse: 0.83 (0.2%),
         extract_message_metadata: 14 (3.3%), get_uri_detail_list: 1.40 (0.3%),
         tests_pri_-1000: 23 (5.6%), tests_pri_-950: 1.23 (0.3%),
        tests_pri_-900: 0.99 (0.2%), tests_pri_-90: 64 (15.8%), check_bayes:
        63 (15.5%), b_tokenize: 6 (1.5%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 2.3 (0.6%), b_tok_touch_all: 44 (10.8%), b_finish: 0.79
        (0.2%), tests_pri_0: 280 (68.6%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 0.89 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] ipc/mqueue.c: change __do_notify() to bypass check_kill_permission()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 23 Mar 2020 11:47:12 -0500 ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> I really just want to be certain that things are fixed well enough that
>> we don't risk a regressing again the next time someone touches the code.
>
> That would be nice ;)
>
> But as Oleg indicated, please let's have something minimal for -stable
> backporting friendliness.  A more comprehensive change can then be
> merged following the regular processes.

So far what we have is a report Oleg has read somewhere that some
program doing something regressed, and his patch to fix that specific
program.  This problem was not noticed for several years.

Presumably the problem is that a message queue was written to by one
user and was read by another user to cause check_kill_permission to
fail. Can someone tell me if that was the case?

At this point all we have are my vague hand wavy readings of the unix98
that even says not checking permissions is correct.

I could reheat the silly arguments I have seen around pdeath_signal and
why pdeath_signal needs a permission check to say that this mq_notify
also needs a permission check to prevent signaling a processes we should
not be able to signal.

So I am looking for something that makes it clear we are not removing
a permission checking and backporting a security hole.

Further even if in the common case it is the right thing to do to remove
the permission check, the handling around exec looks bad enough that we
will be backporting a security hole if we don't fix that and backport
that at the same time.

Eric

p.s. I am grouchy as temporary fixes in this part of the code base
     don't tend to be temporary  and the entire signal/exec/ptrace world
     is bordering on unmaintainble and incomprehensible as a result.













