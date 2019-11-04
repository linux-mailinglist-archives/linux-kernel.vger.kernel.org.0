Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FB4EE494
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 17:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfKDQXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 11:23:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfKDQXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:23:46 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF922089C;
        Mon,  4 Nov 2019 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572884625;
        bh=P2/hAu6NNY+cjTFhjvZ4bPAmXxxRjGf1KyyYpDXKzSA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=s/rTSMP7Roq4fVQZaSrLiaBxNurgYto8bR1HNyD6jophzl/s9U18Bbd+Bk9gA6aT4
         /OQryltJXB8bd3HxxomMbpo7Tmab4aDQosybNQ3UKTvdAHBU9FQI6K/u3gkD9MryQN
         KVPF6v9BrHMP4wDJqLlJYFiBNmnvwjmh4ByVoqqA=
Date:   Mon, 4 Nov 2019 16:23:39 +0000
From:   Will Deacon <will@kernel.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        bjorn.andersson@linaro.org, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCHv7 0/3] QCOM smmu-500 wait-for-safe handling for sdm845
Message-ID: <20191104162339.GD24909@willie-the-truck>
References: <cover.1568966170.git.saiprakash.ranjan@codeaurora.org>
 <20191101163136.GC3603@willie-the-truck>
 <af7e9a14ae7512665f0cae32e08c8b06@codeaurora.org>
 <20191101172508.GB3983@willie-the-truck>
 <119d4bcf5989d1aa0686fd674c6a3370@codeaurora.org>
 <20191104051925.GC5299@hector.lan>
 <20191104151506.GB24909@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104151506.GB24909@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 03:15:06PM +0000, Will Deacon wrote:
> On Sun, Nov 03, 2019 at 11:19:25PM -0600, Andy Gross wrote:
> > On Fri, Nov 01, 2019 at 11:01:59PM +0530, Sai Prakash Ranjan wrote:
> > > >>> What's the plan for getting this merged? I'm not happy taking the
> > > >>> firmware
> > > >>> bits without Andy's ack, but I also think the SMMU changes should go via
> > > >>> the IOMMU tree to avoid conflicts.
> > > >>>
> > > >>> Andy?
> > > >>>
> > > >>
> > > >>Bjorn maintains QCOM stuff now if I am not wrong and he has already
> > > >>reviewed
> > > >>the firmware bits. So I'm hoping you could take all these through IOMMU
> > > >>tree.
> > > >
> > > >Oh, I didn't realise that. Is there a MAINTAINERS update someplace? If I
> > > >run:
> > > >
> > > >$ ./scripts/get_maintainer.pl -f drivers/firmware/qcom_scm-64.c
> > > >
> > > >in linux-next, I get:
> > > >
> > > >Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> > > >linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
> > > >linux-kernel@vger.kernel.org (open list)
> > > >
> > > 
> > > It hasn't been updated yet then. I will leave it to Bjorn or Andy to comment
> > > on this.
> > 
> > The rumors of my demise have been greatly exaggerated.  All kidding aside, I
> > ack'ed both.  Bjorn will indeed be coming on as a co-maintener at some point.
> > He has already done a lot of yeomans work in helping me out the past 3 months.
> 
> Cheers Andy, and I'm pleased to hear that you're still with us! I've queued
> this lot for 5.5 and I'll send to Joerg this week.

Bah, in doing so I spotted that the existing code doesn't handle error codes
properly because 'a0' is unsigned. I'll queue the patch below at the start
of the series.

Will

--->8

From a9a1047f08de0eff249fb65e2d5d6f6f8b2a87f0 Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Mon, 4 Nov 2019 15:58:15 +0000
Subject: [PATCH] firmware: qcom: scm: Ensure 'a0' status code is treated as
 signed

The 'a0' member of 'struct arm_smccc_res' is declared as 'unsigned long',
however the Qualcomm SCM firmware interface driver expects to receive
negative error codes via this field, so ensure that it's cast to 'long'
before comparing to see if it is less than 0.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/firmware/qcom_scm-64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 91d5ad7cf58b..25e0f60c759a 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -150,7 +150,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 		kfree(args_virt);
 	}
 
-	if (res->a0 < 0)
+	if ((long)res->a0 < 0)
 		return qcom_scm_remap_error(res->a0);
 
 	return 0;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

