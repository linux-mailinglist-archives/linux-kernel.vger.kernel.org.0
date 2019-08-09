Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2117F88414
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 22:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfHIUcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 16:32:10 -0400
Received: from 8bytes.org ([81.169.241.247]:48622 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfHIUcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:32:10 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DA0543D0; Fri,  9 Aug 2019 22:32:08 +0200 (CEST)
Date:   Fri, 9 Aug 2019 22:32:08 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "bp@alien8.de" <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 3/3] iommu: Disable passthrough mode when SME is active
Message-ID: <20190809203208.GB1213@8bytes.org>
References: <20190809152233.2829-1-joro@8bytes.org>
 <20190809152233.2829-4-joro@8bytes.org>
 <7f383631-ce2c-e7c2-ceff-e7418bf8ff29@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f383631-ce2c-e7c2-ceff-e7418bf8ff29@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tom,

On Fri, Aug 09, 2019 at 04:50:48PM +0000, Lendacky, Thomas wrote:
> On 8/9/19 10:22 AM, Joerg Roedel wrote:
> > +	if ((iommu_def_domain_type == IOMMU_DOMAIN_IDENTITY) &&
> > +	    sme_active()) {
> > +		pr_info("SME detected - Disabling default IOMMU passthrough\n");
> > +		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
> 
> Should this also clear the iommu_pass_through variable (the one set by the
> iommu kernel parameter in arch/x86/kernel/pci-dma.c)?

This code is used on different architectures, so I can't cleanly access
architecture specific variables here.

> I guess this is more applicable to the original patchset that created the
> CONFIG_IOMMU_DEFAULT_PASSTHROUGH option, but should the default
> passthrough support be modified so that you don't have to specify multiple
> kernel parameters to change it?
> 
> Right now, if CONFIG_IOMMU_DEFAULT_PASSTHROUGH is set to yes, you can't
> just specify iommu=nopt to enable the IOMMU. You have to also specify
> iommu.passthrough=0. Do we want to fix that so that just specifying
> iommu=nopt or iommu.passthrough=0 does what is needed?

Yeah, that is currently a mess and I think cleaning that up is at least
partly in the scope of this patch-set. I'll look into that next week.


Regards,

	Joerg

