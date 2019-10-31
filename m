Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56536EAFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 13:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfJaMDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 08:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfJaMDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:03:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D3A2086D;
        Thu, 31 Oct 2019 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572523412;
        bh=PCgpgl5TvROz0Gbm25l3kuycLpN7y37Y2PSEmcK//es=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=cES5yBB/8oCqueLi5bsvAcXmS39D5iPrOpxzDP624XUXSRf31gQ8Eq1XNIxWwWpx0
         zHeCfsdTPGGAG9UT2U1uTiJLtK7U3/b9WSHEu6JQNf3JVa9BUrxGtG5+FatO9RJuC6
         OcUF/8sJ7Qd4ScxdaqU8v64N8WjOx+RD4iIZxx6Q=
Date:   Thu, 31 Oct 2019 12:03:28 +0000
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 6/7] Revert "iommu/arm-smmu: Make arm-smmu explicitly
 non-modular"
Message-ID: <20191031120327.GD26059@willie-the-truck>
References: <20191030145112.19738-1-will@kernel.org>
 <20191030145112.19738-7-will@kernel.org>
 <20191030230941.GA8188@jcrouse1-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030230941.GA8188@jcrouse1-lnx.qualcomm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 05:09:41PM -0600, Jordan Crouse wrote:
> On Wed, Oct 30, 2019 at 02:51:11PM +0000, Will Deacon wrote:
> > @@ -2235,12 +2237,16 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
> >  
> >  static struct platform_driver arm_smmu_driver = {
> >  	.driver	= {
> > -		.name			= "arm-smmu",
> > -		.of_match_table		= of_match_ptr(arm_smmu_of_match),
> > -		.pm			= &arm_smmu_pm_ops,
> > -		.suppress_bind_attrs	= true,
> > +		.name		= "arm-smmu",
> > +		.of_match_table	= of_match_ptr(arm_smmu_of_match),
> > +		.pm		= &arm_smmu_pm_ops,
> >  	},
> >  	.probe	= arm_smmu_device_probe,
> > +	.remove	= arm_smmu_device_remove,
> >  	.shutdown = arm_smmu_device_shutdown,
> >  };
> > -builtin_platform_driver(arm_smmu_driver);
> > +module_platform_driver(arm_smmu_driver);
> 
> I know this is a revert, but wouldn't you still want to be at device_init()
> level for built in drivers? It always preferable to not defer if given the
> choice to do so and device_init() is the right level for this driver IMO.

Hmm, not sure I'm following you completely here. With this change,
module_init() is used to invoke platform_driver_register(). For builtin
drivers, module_initx() expands to __initcall(x), which itself expands
to device_initcall(x). Or are you referrring to something else?

Will
