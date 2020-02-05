Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEF0153BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 00:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBEXa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 18:30:59 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:60756 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBEXa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:30:59 -0500
X-Greylist: delayed 1756 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Feb 2020 18:30:58 EST
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@gmail.com>)
        id 1izTfx-0003qf-3V; Wed, 05 Feb 2020 16:01:41 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@gmail.com>)
        id 1izTfw-0003aP-3A; Wed, 05 Feb 2020 16:01:40 -0700
From:   ebiederm@gmail.com (Eric W. Biederman)
To:     madhuparnabhowmik10@gmail.com
Cc:     ebiederm@xmission.com, oleg@redhat.com,
        christian.brauner@ubuntu.com, guro@fb.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, frextrite@gmail.com
In-Reply-To: <20200205172437.10113-1-madhuparnabhowmik10@gmail.com>
        (madhuparnabhowmik's message of "Wed, 5 Feb 2020 22:54:37 +0530")
References: <20200205172437.10113-1-madhuparnabhowmik10@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 05 Feb 2020 16:59:52 -0600
Message-ID: <87wo90myhj.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1izTfw-0003aP-3A;;;mid=<87wo90myhj.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@gmail.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19SlWeMtxZF3em6BGlwGbQs4O7QcR8gtuc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@gmail.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,
        NML_ADSP_CUSTOM_MED,T_TM2_M_HEADER_IN_MSG,XM_SPF_SoftFail
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 FORGED_GMAIL_RCVD 'From' gmail.com does not match 'Received'
        *      headers
        *  0.0 DKIM_ADSP_CUSTOM_MED No valid author signature, adsp_override
        *      is CUSTOM_MED
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  2.5 XM_SPF_SoftFail SPF-SoftFail
        *  0.9 NML_ADSP_CUSTOM_MED ADSP custom_med hit, and not from a mailing
        *       list
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;madhuparnabhowmik10@gmail.com
X-Spam-Relay-Country: 
X-Spam-Timing: total 245 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (1.1%), b_tie_ro: 1.86 (0.8%), parse: 0.65
        (0.3%), extract_message_metadata: 2.5 (1.0%), get_uri_detail_list:
        1.09 (0.4%), tests_pri_-1000: 3.0 (1.2%), tests_pri_-950: 1.00 (0.4%),
        tests_pri_-900: 0.75 (0.3%), tests_pri_-90: 25 (10.2%), check_bayes:
        24 (9.8%), b_tokenize: 5 (2.2%), b_tok_get_all: 7 (2.8%), b_comp_prob:
        1.28 (0.5%), b_tok_touch_all: 7 (2.9%), b_finish: 0.58 (0.2%),
        tests_pri_0: 196 (80.0%), check_dkim_signature: 0.38 (0.2%),
        tests_pri_10: 1.67 (0.7%), tests_pri_500: 5 (2.1%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] signal.c: Fix sparse warnings
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

madhuparnabhowmik10@gmail.com writes:

> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> This patch fixes the following two sparse warnings caused due to
> accessing RCU protected pointer tsk->parent without rcu primitives.
>
> kernel/signal.c:1948:65: warning: incorrect type in argument 1 (different address spaces)
> kernel/signal.c:1948:65:    expected struct task_struct *tsk
> kernel/signal.c:1948:65:    got struct task_struct [noderef] <asn:4> *parent
> kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
> kernel/signal.c:1949:40:    expected void const volatile *p
> kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
> kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
> kernel/signal.c:1949:40:    expected void const volatile *p
> kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  kernel/signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9ad8dea93dbb..8227058ea8c4 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1945,8 +1945,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  	 * correct to rely on this
>  	 */
>  	rcu_read_lock();
> -	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(tsk->parent));
> -	info.si_uid = from_kuid_munged(task_cred_xxx(tsk->parent, user_ns),
> +	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(rcu_dereference(tsk->parent)));
> +	info.si_uid = from_kuid_munged(task_cred_xxx(rcu_dereference(tsk->parent), user_ns),
>  				       task_uid(tsk));
>  	rcu_read_unlock();


Still wrong because that access fundamentally depends upon the
task_list_lock no the rcu_read_lock.  Things need to be consistent for
longer than the rcu_read_lock is held.

This patch makes sparse happy and confuses programmers who are trying to
read the code.


Eric
