Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17BA013949E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 16:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAMPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 10:18:45 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:34966 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgAMPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:18:44 -0500
X-Greylist: delayed 1224 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jan 2020 10:18:44 EST
Received: from mx01.mta.xmission.com ([166.70.13.211])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1ir1AZ-0002H6-B6; Mon, 13 Jan 2020 07:58:19 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1ir1AY-0003LR-Ud; Mon, 13 Jan 2020 07:58:19 -0700
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 46CFF21B2BC;
        Mon, 13 Jan 2020 14:58:18 +0000 (UTC)
Date:   Mon, 13 Jan 2020 09:57:55 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Message-ID: <20200113145755.GA3846@hacktheplanet>
References: <20200110215646.15930-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110215646.15930-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1ir1AY-0003LR-Ud;;;mid=<20200113145755.GA3846@hacktheplanet>;;;hst=mx01.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_UncommonTLD01
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3233]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_UncommonTLD01 Less-common TLD
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jon Derrick <jonathan.derrick@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 241 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 2.6 (1.1%), b_tie_ro: 1.81 (0.8%), parse: 0.96
        (0.4%), extract_message_metadata: 16 (6.4%), get_uri_detail_list: 0.98
        (0.4%), tests_pri_-1000: 16 (6.8%), tests_pri_-950: 1.06 (0.4%),
        tests_pri_-900: 0.81 (0.3%), tests_pri_-90: 16 (6.7%), check_bayes: 15
        (6.2%), b_tokenize: 3.4 (1.4%), b_tok_get_all: 4.7 (1.9%),
        b_comp_prob: 1.36 (0.6%), b_tok_touch_all: 2.5 (1.0%), b_finish: 0.62
        (0.3%), tests_pri_0: 160 (66.3%), check_dkim_signature: 0.34 (0.1%),
        check_dkim_adsp: 4.0 (1.7%), poll_dns_idle: 16 (6.8%), tests_pri_10:
        2.6 (1.1%), tests_pri_500: 23 (9.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] MAINTAINERS: Add Revanth Rajashekar as a SED-Opal
 maintainer
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 02:56:46PM -0700, Jon Derrick wrote:
> Scott hasn't worked for Intel for some time and has already given us his
> blessing.
> 
> CC: Scott Bauer <sbauer@plzdonthack.me>
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

This is fine.  Jens can you take this into your tree this week please?

As always I'll be around to look at patches but will become more and
more useless as the spec evolves.
