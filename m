Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA86E18A3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 21:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgCRUYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 16:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgCRUYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:24:02 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B07F2077A;
        Wed, 18 Mar 2020 20:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584563041;
        bh=8+isRKIpD31NteyXOn+rVN6+vqq+smaVnpeboarmzRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2J+KYlaa9WCmGtmPy+aN4+DmQ30/aLbe+Vz44pF/bohc88X+K5kdbGYHEJtpSymwo
         rTqUCddn+HabtoBjAR59pFFKFihqJDBCAbBR7ntYTq78f5HRMau2AkgC6xYs4tTa7q
         Jmi23uZGmd8WZhdo/yrGt/nHiYC2Y2Vcg1BL8/YI=
Date:   Wed, 18 Mar 2020 20:23:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller.
Message-ID: <20200318202356.GB7463@willie-the-truck>
References: <1584491381-31492-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200318160202.0000032c@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318160202.0000032c@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 04:02:02PM +0000, Jonathan Cameron wrote:
> On Tue, 17 Mar 2020 17:29:38 -0700
> Tuan Phan <tuanphan@os.amperecomputing.com> wrote:
> > +/* User ABI */
> > +#define ATTR_CFG_FLD_mask_CFG		config
> > +#define ATTR_CFG_FLD_mask_LO		0
> > +#define ATTR_CFG_FLD_mask_HI		44
> > +#define ATTR_CFG_FLD_match_CFG		config1
> > +#define ATTR_CFG_FLD_match_LO		0
> > +#define ATTR_CFG_FLD_match_HI		44
> > +#define ATTR_CFG_FLD_invert_CFG		config2
> > +#define ATTR_CFG_FLD_invert_LO		0
> > +#define ATTR_CFG_FLD_invert_HI		0
> > +#define ATTR_CFG_FLD_incr_CFG		config2
> > +#define ATTR_CFG_FLD_incr_LO		1
> > +#define ATTR_CFG_FLD_incr_HI		2
> > +#define ATTR_CFG_FLD_event_CFG		config2
> > +#define ATTR_CFG_FLD_event_LO		3
> > +#define ATTR_CFG_FLD_event_HI		8
> > +
> > +#define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
> > +	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
> > +
> > +#define _GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
> > +	__GEN_PMU_FORMAT_ATTR(cfg, lo, hi)
> > +
> > +#define GEN_PMU_FORMAT_ATTR(name)				\
> > +	PMU_FORMAT_ATTR(name,					\
> > +	_GEN_PMU_FORMAT_ATTR(ATTR_CFG_FLD_##name##_CFG,		\
> > +			     ATTR_CFG_FLD_##name##_LO,		\
> > +			     ATTR_CFG_FLD_##name##_HI))
> > +
> > +#define _ATTR_CFG_GET_FLD(attr, cfg, lo, hi)			\
> > +	((((attr)->cfg) >> lo) & GENMASK(hi - lo, 0))
> 
> Hmm. I see this came form SPE pmu.
> 
> Personally I'd argue this makes the code harder to read than doing
> most of it long hand.  Ah well.

I agree that it's harder to read, but I did it this way in the SPE driver
so that the user ABI is always in sync with what the driver thinks, because
the accessors and the sysfs bits are all generated from the same constants.
If you screw that up, then it's really hard to fix without breaking
userspace.

Will
