Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B967DB541F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 19:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbfIQR0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 13:26:42 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50768 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfIQR0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:26:42 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iAHFQ-00028e-2l; Tue, 17 Sep 2019 11:26:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iAHFP-00085B-9T; Tue, 17 Sep 2019 11:26:39 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190917100350.GB1872@dhcp22.suse.cz>
        <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
        <20190917153830.GE1872@dhcp22.suse.cz>
Date:   Tue, 17 Sep 2019 12:26:18 -0500
In-Reply-To: <20190917153830.GE1872@dhcp22.suse.cz> (Michal Hocko's message of
        "Tue, 17 Sep 2019 17:38:30 +0200")
Message-ID: <87ftku96md.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iAHFP-00085B-9T;;;mid=<87ftku96md.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18xBhL9oDfoGmZ3rm6I4lqlaRWJ1t5MgDI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4774]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 398 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 3.0 (0.8%), b_tie_ro: 2.2 (0.5%), parse: 1.02
        (0.3%), extract_message_metadata: 5 (1.3%), get_uri_detail_list: 3.1
        (0.8%), tests_pri_-1000: 2.9 (0.7%), tests_pri_-950: 1.05 (0.3%),
        tests_pri_-900: 0.86 (0.2%), tests_pri_-90: 24 (6.1%), check_bayes: 23
        (5.7%), b_tokenize: 6 (1.5%), b_tok_get_all: 9 (2.1%), b_comp_prob:
        2.5 (0.6%), b_tok_touch_all: 2.8 (0.7%), b_finish: 0.63 (0.2%),
        tests_pri_0: 346 (86.8%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.3 (0.6%), poll_dns_idle: 0.96 (0.2%), tests_pri_10:
        1.69 (0.4%), tests_pri_500: 5 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: threads-max observe limits
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Tue 17-09-19 17:28:02, Heinrich Schuchardt wrote:
>> 
>> On 9/17/19 12:03 PM, Michal Hocko wrote:
>> > Hi,
>> > I have just stumbled over 16db3d3f1170 ("kernel/sysctl.c: threads-max
>> > observe limits") and I am really wondering what is the motivation behind
>> > the patch. We've had a customer noticing the threads_max autoscaling
>> > differences btween 3.12 and 4.4 kernels and wanted to override the auto
>> > tuning from the userspace, just to find out that this is not possible.
>> 
>> set_max_threads() sets the upper limit (max_threads_suggested) for
>> threads such that at a maximum 1/8th of the total memory can be occupied
>> by the thread's administrative data (of size THREADS_SIZE). On my 32 GiB
>> system this results in 254313 threads.
>
> This is quite arbitrary, isn't it? What would happen if the limit was
> twice as large?
>
>> With patch 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
>> a user cannot set an arbitrarily high number for
>> /proc/sys/kernel/threads-max which could lead to a system stalling
>> because the thread headers occupy all the memory.
>
> This is still a decision of the admin to make.  You can consume the
> memory by other means and that is why we have measures in place. E.g.
> memcg accounting.
>
>> When developing the patch I remarked that on a system where memory is
>> installed dynamically it might be a good idea to recalculate this limit.
>> If you have a system that boots with let's say 8 GiB and than
>> dynamically installs a few TiB of RAM this might make sense. But such a
>> dynamic update of thread_max_suggested was left out for the sake of
>> simplicity.
>> 
>> Anyway if more than 100,000 threads are used on a system, I would wonder
>> if the software should not be changed to use thread-pools instead.
>
> You do not change the software to overcome artificial bounds based on
> guessing.
>
> So can we get back to the justification of the patch. What kind of
> real life problem does it solve and why is it ok to override an admin
> decision?
> If there is no strong justification then the patch should be reverted
> because from what I have heard it has been noticed and it has broken
> a certain deployment. I am not really clear about technical details yet
> but it seems that there are workloads that believe they need to touch
> this tuning and complain if that is not possible.

Taking a quick look myself.

I am completely mystified by both sides of this conversation.

a) The logic to set the default number of threads in a system
   has not changed since 2.6.12-rc2 (the start of the git history).

The implementation has changed but we should still get the same
value.  So anyone seeing threads_max autoscaling differences
between kernels is either seeing a bug in the rewritten formula
or something else weird is going on.

Michal is it a very small effect your customers are seeing?
Is it another bug somewhere else?

b) Not being able to bump threads_max to the physical limit of
   the machine is very clearly a regression.

 Limiting threads_max to THREADS_MIN on the low end and THREAD_MAX on
 the high end is reasonable, because linux can't cope with values
 outside of that range.  Limiting threads_max to the auto-scaling value
 is a regression.

The point of limits like threads_max is to have something that 99%
of people won't hit and if they do it will indicate a bug in their
application.  And to generally keep the kernel working when an
application bug happens.

But there are always cases where heuristics fail so it is completely
reasonable to allow these values to be manually tuned.

Eric

