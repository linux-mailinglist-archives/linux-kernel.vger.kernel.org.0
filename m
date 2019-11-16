Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B96FF613
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 00:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfKPW42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 17:56:28 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:32807 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfKPW42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 17:56:28 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iW6zR-00045u-Lo; Sat, 16 Nov 2019 15:56:25 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iW6zQ-00013I-9s; Sat, 16 Nov 2019 15:56:25 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
References: <20191114142707.1608679-1-areber@redhat.com>
        <20191114191538.GC171963@gmail.com>
        <20191115093419.GA25528@redhat.com>
        <20191115095854.4vr6bgfz6ny5zbpd@wittgenstein>
        <20191115104909.GB25528@redhat.com>
        <20191115130800.zntefr5ptabdngph@wittgenstein>
Date:   Sat, 16 Nov 2019 16:55:59 -0600
In-Reply-To: <20191115130800.zntefr5ptabdngph@wittgenstein> (Christian
        Brauner's message of "Fri, 15 Nov 2019 14:08:01 +0100")
Message-ID: <87wobz5t34.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iW6zQ-00013I-9s;;;mid=<87wobz5t34.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+4XRjpnruo5pIuKkWB7ifyFXo5kT+vzeM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4986]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 565 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.5 (0.6%), b_tie_ro: 2.5 (0.4%), parse: 0.99
        (0.2%), extract_message_metadata: 11 (2.0%), get_uri_detail_list: 1.45
        (0.3%), tests_pri_-1000: 4.1 (0.7%), tests_pri_-950: 1.13 (0.2%),
        tests_pri_-900: 0.85 (0.2%), tests_pri_-90: 19 (3.4%), check_bayes: 18
        (3.2%), b_tokenize: 4.8 (0.9%), b_tok_get_all: 6 (1.1%), b_comp_prob:
        1.74 (0.3%), b_tok_touch_all: 3.2 (0.6%), b_finish: 0.63 (0.1%),
        tests_pri_0: 224 (39.6%), check_dkim_signature: 0.36 (0.1%),
        check_dkim_adsp: 2.1 (0.4%), poll_dns_idle: 277 (49.0%), tests_pri_10:
        1.64 (0.3%), tests_pri_500: 296 (52.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v10 1/2] fork: extend clone3() to support setting a PID
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Fri, Nov 15, 2019 at 11:49:10AM +0100, Oleg Nesterov wrote:
>> On 11/15, Christian Brauner wrote:
>> >
>> > +static int set_tid_next(pid_t *set_tid, size_t *size, int idx)
>> > +{
>> > +	int tid = 0;
>> > +
>> > +	if (*size) {
>> > +		tid = set_tid[idx];
>> > +		if (tid < 1 || tid >= pid_max)
>> > +			return -EINVAL;
>> > +
>> > +		/*
>> > +		 * Also fail if a PID != 1 is requested and
>> > +		 * no PID 1 exists.
>> > +		 */
>> > +		if (tid != 1 && !tmp->child_reaper)
>> > +			return -EINVAL;
>> > +
>> > +		if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
>> > +			return -EPERM;
>> > +
>> > +		(*size)--;
>> > +	}
>> 
>> this needs more args, struct pid_namespace *tmp + pid_t pid_max
>> 		if (set_tid_size) {
>> 			tid = set_tid[ns->level - i];
>> 
>> 			retval = -EINVAL;
>> 			if (tid < 1 || tid >= pid_max)
>> 				goto out_free;
>
> I'm not a fan of this pattern of _not_ setting error codes in the actual
> error path t but I won't object.

If you can show a compiler that actually manages to reliably perform
that code motion it is worth discussing making it go away.  Last I
checked gcc will emit an extra basic block just to handle setting
the error code before jumping to the out_free.  That extra basic block
because of the extra jump tends to be costly.

Not a huge cost but in these days when branches are getting increasingly
expensive and Moore's law wrapping up I prefer code patterns that
generate cood code.

Eric
