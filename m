Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E32F8341
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 00:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKKXJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 18:09:21 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:57235 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfKKXJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:09:21 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iUIoB-0004rx-HK; Mon, 11 Nov 2019 16:09:19 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iUIoA-0008RC-Bb; Mon, 11 Nov 2019 16:09:19 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
References: <20191111131704.656169-1-areber@redhat.com>
        <20191111152514.GA11389@redhat.com>
        <20191111154028.GF514519@dcbz.redhat.com>
        <20191111161458.fjodxyx566dar6ob@wittgenstein>
Date:   Mon, 11 Nov 2019 17:08:57 -0600
In-Reply-To: <20191111161458.fjodxyx566dar6ob@wittgenstein> (Christian
        Brauner's message of "Mon, 11 Nov 2019 17:14:59 +0100")
Message-ID: <87ftiuau46.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iUIoA-0008RC-Bb;;;mid=<87ftiuau46.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18M7A0AmO9aQgTEDeULWKj2+UuWeRV17Xc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_12,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3130]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 753 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.3%), b_tie_ro: 1.72 (0.2%), parse: 0.69
        (0.1%), extract_message_metadata: 9 (1.3%), get_uri_detail_list: 2.0
        (0.3%), tests_pri_-1000: 4.1 (0.5%), tests_pri_-950: 1.10 (0.1%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 27 (3.6%), check_bayes: 26
        (3.5%), b_tokenize: 8 (1.0%), b_tok_get_all: 10 (1.3%), b_comp_prob:
        2.1 (0.3%), b_tok_touch_all: 3.9 (0.5%), b_finish: 0.56 (0.1%),
        tests_pri_0: 352 (46.8%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 2.00 (0.3%), poll_dns_idle: 336 (44.6%),
        tests_pri_10: 1.68 (0.2%), tests_pri_500: 350 (46.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v7 1/2] fork: extend clone3() to support setting a PID
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Mon, Nov 11, 2019 at 04:40:28PM +0100, Adrian Reber wrote:
>> On Mon, Nov 11, 2019 at 04:25:15PM +0100, Oleg Nesterov wrote:
>> > On 11/11, Adrian Reber wrote:
>> > >
>> > > v7:
>> > >  - changed set_tid to be an array to set the PID of a process
>> > >    in multiple nested PID namespaces at the same time as discussed
>> > >    at LPC 2019 (container MC)
>> > 
>> > cough... iirc you convinced me this is not needed when we discussed
>> > the previous version ;) Nevermind, probably my memory fools me.
>> 
>> You are right. You suggested the same thing and we didn't listen ;)
>> 
>> > So far I only have some cosmetic nits,
>> 
>> Thanks for the quick review. I will try to apply your suggestions.
>> 
>> > > @@ -175,6 +187,18 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>> > >
>> > >  	for (i = ns->level; i >= 0; i--) {
>> > >  		int pid_min = 1;
>> > > +		int t_pos = 0;
>> >                     ^^^^^
>> > 
>> > I won't insist, but I'd suggest to cache set_tid[t_pos] instead to make
>> > the code a bit more simple.
>> > 
>> > > @@ -186,12 +210,24 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>> > >  		if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
>> > >  			pid_min = RESERVED_PIDS;
>> > 
>> > You can probably move this code into the "else" branch below.
>> > 
>> > IOW, something like
>> > 
>> > 
>> > 	for (i = ns->level; i >= 0; i--) {
>> > 		int xxx = 0;
>> > 
>> > 		if (set_tid_size) {
>> > 			int pos = ns->level - i;
>> > 
>> > 			xxx = set_tid[pos];
>> > 			if (xxx < 1 || xxx >= pid_max)
>> > 				return ERR_PTR(-EINVAL);
>> > 			/* Also fail if a PID != 1 is requested and no PID 1 exists */
>> > 			if (xxx != 1 && !tmp->child_reaper)
>> > 				return ERR_PTR(-EINVAL);
>> > 			if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
>> > 				return ERR_PTR(-EPERM);
>> > 			set_tid_size--;
>> > 		}
>> > 
>> > 		idr_preload(GFP_KERNEL);
>> > 		spin_lock_irq(&pidmap_lock);
>> > 
>> > 		if (xxx) {
>> > 			nr = idr_alloc(&tmp->idr, NULL, xxx, xxx + 1,
>> > 					GFP_ATOMIC);
>> > 			/*
>> > 			 * If ENOSPC is returned it means that the PID is
>> > 			 * alreay in use. Return EEXIST in that case.
>> > 			 */
>> > 			if (nr == -ENOSPC)
>> > 				nr = -EEXIST;
>> > 		} else {
>> > 			int pid_min = 1;
>> > 			/*
>> > 			 * init really needs pid 1, but after reaching the
>> > 			 * maximum wrap back to RESERVED_PIDS
>> > 			 */
>> > 			if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
>> > 				pid_min = RESERVED_PIDS;
>> > 			/*
>> > 			 * Store a null pointer so find_pid_ns does not find
>> > 			 * a partially initialized PID (see below).
>> > 			 */
>> > 			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
>> > 					      pid_max, GFP_ATOMIC);
>> > 		}
>> > 
>> > 		...
>> > 
>> > This way only the "if (set_tid_size)" block has to play with set_tid_size/set_tid.
>> > 
>> > note also that this way we can easily allow set_tid[some_level] == 0, we can
>> > simply do
>> > 
>> > 	-	if (xxx < 1 || xxx >= pid_max)
>> > 	+	if (xxx < 0 || xxx >= pid_max)
>> > 
>> > although I don't think this is really useful.
>> 
>> Yes. I explicitly didn't allow 0 as a PID as I didn't thought it would
>> be useful (or maybe even valid).

I agree not allowing 0 sounds very reasonable.

> How do you express: I don't care about a specific pid in pidns level
> <n>, just give me a random one? For example,
>
> set_tid[0] = 1234
> set_tid[1] = 5678
> set_tid[2] = random_pid()
> set_tid[3] = 9
>
> Wouldn't that be potentially useful?

I can't imagine how.

At least in my head the fundamental concept is picking up a container on
one machine and moving it to another machine.  For that operation you
will know starting with the most nested pid namespace the pids that you
want up to some point.  Farther up you don't know.

I can't imagine in what scenario you would not know a pid at outer level
but want a specified pid at an ever farther removed outer level.  What
scenario are you thinking about that could lead to such a situation?

For the me the question is: Are you restoring what you know or not?

Eric
