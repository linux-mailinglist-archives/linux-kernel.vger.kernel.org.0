Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE99BBDD1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 23:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503033AbfIWVYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 17:24:09 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34567 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388395AbfIWVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:24:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iCVoW-0001PW-Bn; Mon, 23 Sep 2019 15:24:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iCVoV-0001wk-Qg; Mon, 23 Sep 2019 15:24:08 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190917100350.GB1872@dhcp22.suse.cz>
        <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
        <20190917153830.GE1872@dhcp22.suse.cz>
        <87ftku96md.fsf@x220.int.ebiederm.org>
        <20190918071541.GB12770@dhcp22.suse.cz>
        <87h8585bej.fsf@x220.int.ebiederm.org>
        <20190922065801.GB18814@dhcp22.suse.cz>
        <875zlk3tz9.fsf@x220.int.ebiederm.org>
        <20190923080808.GA6016@dhcp22.suse.cz>
Date:   Mon, 23 Sep 2019 16:23:40 -0500
In-Reply-To: <20190923080808.GA6016@dhcp22.suse.cz> (Michal Hocko's message of
        "Mon, 23 Sep 2019 10:08:08 +0200")
Message-ID: <87mueuu2oz.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iCVoV-0001wk-Qg;;;mid=<87mueuu2oz.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+hxpSDtOo3FHzcbUiojMZiFj7TaPT97BQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1956]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 185 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.7 (1.5%), b_tie_ro: 1.90 (1.0%), parse: 0.72
        (0.4%), extract_message_metadata: 1.97 (1.1%), get_uri_detail_list:
        0.27 (0.1%), tests_pri_-1000: 3.4 (1.9%), tests_pri_-950: 1.27 (0.7%),
        tests_pri_-900: 1.05 (0.6%), tests_pri_-90: 14 (7.4%), check_bayes: 12
        (6.6%), b_tokenize: 3.5 (1.9%), b_tok_get_all: 3.9 (2.1%),
        b_comp_prob: 1.22 (0.7%), b_tok_touch_all: 1.86 (1.0%), b_finish: 0.63
        (0.3%), tests_pri_0: 141 (76.4%), check_dkim_signature: 0.46 (0.3%),
        check_dkim_adsp: 2.3 (1.3%), poll_dns_idle: 0.84 (0.5%), tests_pri_10:
        3.2 (1.7%), tests_pri_500: 8 (4.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: threads-max observe limits
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michal,

Thinking about this I have a hunch about what changed.  I think at some
point we changed from 4k to 8k kernel stacks.  So I suspect if your
client is seeing a lower threads-max it is because the size of the
kernel data structures increased.

Eric

