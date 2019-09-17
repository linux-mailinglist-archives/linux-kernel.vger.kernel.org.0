Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D641B5462
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 19:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfIQRic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 13:38:32 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59377 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfIQRib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:38:31 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iAHQo-0005xA-Ok; Tue, 17 Sep 2019 11:38:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iAHQn-0001k7-Ob; Tue, 17 Sep 2019 11:38:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
        <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
        <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
        <20190830160957.GC2634@redhat.com>
        <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
        <87o906wimo.fsf@x220.int.ebiederm.org>
        <20190902134003.GA14770@redhat.com>
        <87tv9uiq9r.fsf@x220.int.ebiederm.org>
        <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
        <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
        <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whej3MMKJBHKWp66djfEP5=kyncX7FoqJacYtmBXB6v9w@mail.gmail.com>
Date:   Tue, 17 Sep 2019 12:38:04 -0500
In-Reply-To: <CAHk-=whej3MMKJBHKWp66djfEP5=kyncX7FoqJacYtmBXB6v9w@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 14 Sep 2019 10:43:59 -0700")
Message-ID: <8736gu962r.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iAHQn-0001k7-Ob;;;mid=<8736gu962r.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/RFHzV/wcSYCSYXdS/J/heIs1ylgpLA98=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 544 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.9 (0.5%), b_tie_ro: 2.0 (0.4%), parse: 0.82
        (0.2%), extract_message_metadata: 14 (2.5%), get_uri_detail_list: 1.29
        (0.2%), tests_pri_-1000: 22 (4.1%), tests_pri_-950: 1.32 (0.2%),
        tests_pri_-900: 1.36 (0.3%), tests_pri_-90: 23 (4.3%), check_bayes: 21
        (3.9%), b_tokenize: 7 (1.3%), b_tok_get_all: 7 (1.3%), b_comp_prob:
        2.2 (0.4%), b_tok_touch_all: 2.8 (0.5%), b_finish: 0.66 (0.1%),
        tests_pri_0: 467 (85.8%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 0/4] task: Making tasks on the runqueue rcu protected
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Sep 14, 2019 at 5:30 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> I have reworked these patches one more time to make it clear that the
>> first 3 patches only fix task_struct so that it experiences a rcu grace
>> period after it leaves the runqueue for the last time.
>
> I remain a fan of these patches, and the added comment on the last one
> is I think a sufficient clarification of the issue.
>
> But it's patch 3 that makes me go "yeah, this is the right approach",
> because it just removes subtle code in favor of something that is
> understandable.
>
> Yes, most of the lines removed may be comments, and so it doesn't
> actually remove a lot of _code_, but I think the comments are a result
> of just how subtle and fragile our current approach is, and the new
> model not needing them as much is I think a real issue (rather than
> just Eric being less verbose in the new comments and removing lines of
> code that way).

In fact the comments I add are orthogonal to the comments I removed.
My last patch stands on it's own.  It can be applied with or without the
rest.   I just needed to know which of the ordinary rcu guarantees were
or were not present in the code.

> Can anybody see anything wrong with the series? Because I'd love to
> have it for 5.4,

Peter,

I am more than happy for these to come through your tree.  However
if this is one thing to many I will be happy to send Linus a pull
request myself early next week.

Eric
