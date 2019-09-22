Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19010BABFF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbfIVWcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 18:32:41 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34961 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfIVWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:32:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iC9bB-00016O-4Z; Sun, 22 Sep 2019 15:40:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iC9bA-0006lK-5E; Sun, 22 Sep 2019 15:40:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190917100350.GB1872@dhcp22.suse.cz>
        <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
        <20190917153830.GE1872@dhcp22.suse.cz>
        <87ftku96md.fsf@x220.int.ebiederm.org>
        <20190918071541.GB12770@dhcp22.suse.cz>
        <87h8585bej.fsf@x220.int.ebiederm.org>
        <20190922065801.GB18814@dhcp22.suse.cz>
        <f1b89360-a70c-0a30-6a7b-9bafe74701ed@gmx.de>
Date:   Sun, 22 Sep 2019 16:40:26 -0500
In-Reply-To: <f1b89360-a70c-0a30-6a7b-9bafe74701ed@gmx.de> (Heinrich
        Schuchardt's message of "Sun, 22 Sep 2019 17:31:16 +0200")
Message-ID: <875zlk2enp.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iC9bA-0006lK-5E;;;mid=<875zlk2enp.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+dpU+wrMcpwUJyGndmWILCcP3mbhZWntQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=8.0 tests=ALL_TRUSTED,BAYES_00,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -3.0 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0012]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 404 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 4.2 (1.0%), b_tie_ro: 2.7 (0.7%), parse: 1.36
        (0.3%), extract_message_metadata: 17 (4.1%), get_uri_detail_list: 1.97
        (0.5%), tests_pri_-1000: 16 (4.0%), tests_pri_-950: 1.50 (0.4%),
        tests_pri_-900: 1.20 (0.3%), tests_pri_-90: 26 (6.4%), check_bayes: 24
        (5.9%), b_tokenize: 7 (1.8%), b_tok_get_all: 6 (1.6%), b_comp_prob:
        2.4 (0.6%), b_tok_touch_all: 2.5 (0.6%), b_finish: 3.9 (1.0%),
        tests_pri_0: 318 (78.9%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.6 (0.6%), poll_dns_idle: 0.73 (0.2%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 11 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: threads-max observe limits
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heinrich Schuchardt <xypron.glpk@gmx.de> writes:

> Did this patch when applied to the customer's kernel solve any problem?
>
> WebSphere MQ is a messaging application. If it hits the current limits
> of threads-max, there is a bug in the software or in the way that it has
> been set up at the customer. Instead of messing around with the kernel
> the application should be fixed.

While it is true that almost every workload will be buggy if it exceeds
1/8 of memory with just the kernel data structures for threads.  It is
not necessary true of every application.  I can easily imagine cases
up around 1/2 of memory where things could work reasonably.

Further we can exhaust all of memory much more simply in a default
configuration by malloc'ing more memory that in physically present
and zeroing it all.

Henrich, you were the one messed with the kernel by breaking a
reasonable kernel tunable.  AKA you caused a regression.  That violates
the no regression rule.

As much as possible we fix regressions so software that used to work
continues to work.  Removing footguns is not a reason to introduce a
regression.

I do agree that Michal's customer's problem sounds like it is something
else but if the kernel did not have a regression we could focus on the
real problem instead of being side tracked by the regression.

> With this patch you allow administrators to set values that will crash
> their system. And they will not even have a way to find out the limits
> which he should adhere to. So expect a lot of systems to be downed
> this way.

Nope.  The system administrator just setting a higher value whon't crash
their system.  Only using that many resources would crash the system.

Nor is a sysctl like this for discovering the physical limits of a
machine.  Which the current value is vastly inappropriate for.  As
the physical limits of many machines are much higher than 1/8 of memory.

Eric
