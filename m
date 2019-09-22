Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F8DBAC00
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbfIVWcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 18:32:42 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34961 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388618AbfIVWcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:32:41 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iC9LR-0008N2-IH; Sun, 22 Sep 2019 15:24:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iC9LQ-0005B3-SS; Sun, 22 Sep 2019 15:24:37 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190917100350.GB1872@dhcp22.suse.cz>
        <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
        <20190917153830.GE1872@dhcp22.suse.cz>
        <87ftku96md.fsf@x220.int.ebiederm.org>
        <20190918071541.GB12770@dhcp22.suse.cz>
        <87h8585bej.fsf@x220.int.ebiederm.org>
        <20190922065801.GB18814@dhcp22.suse.cz>
Date:   Sun, 22 Sep 2019 16:24:10 -0500
In-Reply-To: <20190922065801.GB18814@dhcp22.suse.cz> (Michal Hocko's message
        of "Sun, 22 Sep 2019 08:58:01 +0200")
Message-ID: <875zlk3tz9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iC9LQ-0005B3-SS;;;mid=<875zlk3tz9.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1976R+De7cUhIv9x7RdCVrOgZXcs3liSwU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 315 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.5 (1.1%), b_tie_ro: 2.5 (0.8%), parse: 1.02
        (0.3%), extract_message_metadata: 14 (4.4%), get_uri_detail_list: 2.3
        (0.7%), tests_pri_-1000: 16 (5.0%), tests_pri_-950: 1.00 (0.3%),
        tests_pri_-900: 0.81 (0.3%), tests_pri_-90: 20 (6.3%), check_bayes: 19
        (5.9%), b_tokenize: 5 (1.7%), b_tok_get_all: 7 (2.2%), b_comp_prob:
        1.66 (0.5%), b_tok_touch_all: 2.9 (0.9%), b_finish: 0.61 (0.2%),
        tests_pri_0: 250 (79.3%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.2 (0.7%), poll_dns_idle: 0.70 (0.2%), tests_pri_10:
        1.68 (0.5%), tests_pri_500: 5 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: threads-max observe limits
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> From 711000fdc243b6bc68a92f9ef0017ae495086d39 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Sun, 22 Sep 2019 08:45:28 +0200
> Subject: [PATCH] kernel/sysctl.c: do not override max_threads provided by
>  userspace
>
> Partially revert 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
> because the patch is causing a regression to any workload which needs to
> override the auto-tuning of the limit provided by kernel.
>
> set_max_threads is implementing a boot time guesstimate to provide a
> sensible limit of the concurrently running threads so that runaways will
> not deplete all the memory. This is a good thing in general but there
> are workloads which might need to increase this limit for an application
> to run (reportedly WebSpher MQ is affected) and that is simply not
> possible after the mentioned change. It is also very dubious to override
> an admin decision by an estimation that doesn't have any direct relation
> to correctness of the kernel operation.
>
> Fix this by dropping set_max_threads from sysctl_max_threads so any
> value is accepted as long as it fits into MAX_THREADS which is important
> to check because allowing more threads could break internal robust futex
> restriction. While at it, do not use MIN_THREADS as the lower boundary
> because it is also only a heuristic for automatic estimation and admin
> might have a good reason to stop new threads to be created even when
> below this limit.
>
> Fixes: 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---
>  kernel/fork.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2852d0e76ea3..ef865be37e98 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2929,7 +2929,7 @@ int sysctl_max_threads(struct ctl_table *table, int write,
>  	struct ctl_table t;
>  	int ret;
>  	int threads = max_threads;
> -	int min = MIN_THREADS;
> +	int min = 1;
>  	int max = MAX_THREADS;
>  
>  	t = *table;
> @@ -2941,7 +2941,7 @@ int sysctl_max_threads(struct ctl_table *table, int write,
>  	if (ret || !write)
>  		return ret;
>  
> -	set_max_threads(threads);
> +	max_threads = threads;
>  
>  	return 0;
>  }
> -- 
> 2.20.1
