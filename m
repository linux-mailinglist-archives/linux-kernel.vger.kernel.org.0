Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFCEA18B88A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 15:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgCSODZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 10:03:25 -0400
Received: from 8bytes.org ([81.169.241.247]:53832 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgCSODY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:03:24 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 13DF71D4; Thu, 19 Mar 2020 15:03:23 +0100 (CET)
Date:   Thu, 19 Mar 2020 15:03:21 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/6] iommu: Configure default domain with
 def_domain_type
Message-ID: <20200319140321.GA5122@8bytes.org>
References: <20200314010705.30711-1-baolu.lu@linux.intel.com>
 <20200314010705.30711-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314010705.30711-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Sat, Mar 14, 2020 at 09:07:01AM +0800, Lu Baolu wrote:
> +static int iommu_group_change_def_domain(struct iommu_group *group, int type)
> +{
> +	struct group_device *grp_dev, *temp;
> +	struct iommu_domain *new, *old;
> +	const struct iommu_ops *ops;
> +	int ret = 0;
> +
> +	if ((type != IOMMU_DOMAIN_IDENTITY && type != IOMMU_DOMAIN_DMA) ||
> +	    !group->default_domain || type == group->default_domain->type ||
> +	    !group->default_domain->ops)
> +		return -EINVAL;
> +
> +	if (group->domain != group->default_domain)
> +		return -EBUSY;
> +
> +	iommu_group_ref_get(group);
> +	old = group->default_domain;
> +	ops = group->default_domain->ops;
> +
> +	/* Allocate a new domain of requested type. */
> +	new = ops->domain_alloc(type);
> +	if (!new) {
> +		ret = -ENOMEM;
> +		goto domain_out;
> +	}
> +	new->type = type;
> +	new->ops = ops;
> +	new->pgsize_bitmap = group->default_domain->pgsize_bitmap;
> +
> +	group->default_domain = new;
> +	group->domain = new;
> +	list_for_each_entry_safe(grp_dev, temp, &group->devices, list) {
> +		struct device *dev;
> +
> +		dev = grp_dev->dev;
> +		if (device_is_bound(dev)) {
> +			ret = -EINVAL;
> +			goto device_out;
> +		}
> +
> +		iommu_group_create_direct_mappings(group, dev);
> +		ret = __iommu_attach_device(group->domain, dev);
> +		if (ret)
> +			goto device_out;

In case of a failure here with a group containing multiple devices, the
other devices temporarily lose their mappings. Please only do the
device_is_bound() check in the loop and the actual re-attachment of the
group with a call to __iommu_attach_group().

Regards,

	Joerg
