Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6EF784B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 17:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKKQEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 11:04:07 -0500
Received: from foss.arm.com ([217.140.110.172]:47478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKQEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:04:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FEDE31B;
        Mon, 11 Nov 2019 08:04:06 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2A9B3F534;
        Mon, 11 Nov 2019 08:04:05 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:04:03 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] firmware: arm_scmi: Remove set but not used variable
 'val'
Message-ID: <20191111160403.GB10020@bogus>
References: <20191110103010.117132-1-zhengyongjun3@huawei.com>
 <64a46661-40a6-eb7e-d225-1085b86572d0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a46661-40a6-eb7e-d225-1085b86572d0@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 03:49:55PM +0000, Robin Murphy wrote:
> On 10/11/2019 10:30, Zheng Yongjun wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> >
> > drivers/firmware/arm_scmi/perf.c: In function scmi_perf_fc_ring_db:
> > drivers/firmware/arm_scmi/perf.c:323:7: warning: variable val set but not used [-Wunused-but-set-variable]
> >
> > val is never used, so remove it.
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> > ---
> >   drivers/firmware/arm_scmi/perf.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> > index 4a8012e3cb8c..efa98d2ee045 100644
> > --- a/drivers/firmware/arm_scmi/perf.c
> > +++ b/drivers/firmware/arm_scmi/perf.c
> > @@ -319,10 +319,8 @@ static void scmi_perf_fc_ring_db(struct scmi_fc_db_info *db)
> >   		SCMI_PERF_FC_RING_DB(64);
> >   #else
> >   	{
> > -		u64 val = 0;
> > -
> >   		if (db->mask)
> > -			val = ioread64_hi_lo(db->addr) & db->mask;
> > +			ioread64_hi_lo(db->addr) & db->mask;
> >   		iowrite64_hi_lo(db->set, db->addr);
>
> FWIW, compared to the SCMI_PERF_FC_RING_DB() macro, this looks like the
> wrong "fix".
>

Yes, no idea how I didn't spot this earlier. That could be because this
was just added to fix 32-bit build and wasn't tested.

The below patch should fix the warning and also fixes the real bug.

Regards,
Sudeep

diff --git i/drivers/firmware/arm_scmi/perf.c w/drivers/firmware/arm_scmi/perf.c
index 4a8012e3cb8c..601af4edad5e 100644
--- i/drivers/firmware/arm_scmi/perf.c
+++ w/drivers/firmware/arm_scmi/perf.c
@@ -323,7 +323,7 @@ static void scmi_perf_fc_ring_db(struct scmi_fc_db_info *db)

                if (db->mask)
                        val = ioread64_hi_lo(db->addr) & db->mask;
-               iowrite64_hi_lo(db->set, db->addr);
+               iowrite64_hi_lo(db->set | val, db->addr);
        }
 #endif
 }

