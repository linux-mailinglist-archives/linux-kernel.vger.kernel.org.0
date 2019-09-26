Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF79BE9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 03:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfIZBLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 21:11:47 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36311 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbfIZBLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:11:46 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDIJr-000084-Uk; Wed, 25 Sep 2019 19:11:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDIJq-0002Ck-0j; Wed, 25 Sep 2019 19:11:43 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whej3MMKJBHKWp66djfEP5=kyncX7FoqJacYtmBXB6v9w@mail.gmail.com>
        <8736gu962r.fsf@x220.int.ebiederm.org>
        <20190925075155.GB4536@hirez.programming.kicks-ass.net>
Date:   Wed, 25 Sep 2019 20:11:11 -0500
In-Reply-To: <20190925075155.GB4536@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 25 Sep 2019 09:51:55 +0200")
Message-ID: <87lfub2768.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iDIJq-0002Ck-0j;;;mid=<87lfub2768.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/z7OLr3881IulGtujio+kS/TgqS6uSLzI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
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
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1318 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.8 (0.2%), b_tie_ro: 1.92 (0.1%), parse: 0.83
        (0.1%), extract_message_metadata: 14 (1.1%), get_uri_detail_list: 1.00
        (0.1%), tests_pri_-1000: 23 (1.7%), tests_pri_-950: 1.30 (0.1%),
        tests_pri_-900: 1.11 (0.1%), tests_pri_-90: 22 (1.7%), check_bayes: 21
        (1.6%), b_tokenize: 6 (0.5%), b_tok_get_all: 7 (0.5%), b_comp_prob:
        2.4 (0.2%), b_tok_touch_all: 3.1 (0.2%), b_finish: 0.66 (0.0%),
        tests_pri_0: 1240 (94.1%), check_dkim_signature: 0.53 (0.0%),
        check_dkim_adsp: 2.8 (0.2%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 7 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 0/4] task: Making tasks on the runqueue rcu protected
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Sep 17, 2019 at 12:38:04PM -0500, Eric W. Biederman wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> > Can anybody see anything wrong with the series? Because I'd love to
>> > have it for 5.4,
>> 
>> Peter,
>> 
>> I am more than happy for these to come through your tree.  However
>> if this is one thing to many I will be happy to send Linus a pull
>> request myself early next week.
>
> Yeah, sorry for being late, I fell ill after LPC and am only now
> getting back to things.
>
> I see nothing wrong with these patches; if they've not been picked up
> (and I'm not seeing them in Linus' tree yet) I'll pick them up now and
> munge them together with Mathieu's membarrier patches and get them to
> Linus in a few days.

Sounds good.  I had some distractions so I wasn't able to get this yet.
So I am more than happy for you to pick these up.  This is better coming
through your tree in any event.

Eric

