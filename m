Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83A533ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 00:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfFCWFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 18:05:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:1031 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfFCWFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:05:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 15:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,548,1549958400"; 
   d="scan'208";a="181310106"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 15:05:38 -0700
Date:   Mon, 3 Jun 2019 15:08:42 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, eric.auger@redhat.com,
        ashok.raj@intel.com, yi.l.liu@intel.com, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 2/4] iommu: Introduce device fault data
Message-ID: <20190603150842.11070cfd@jacob-builder>
In-Reply-To: <20190603145749.46347-3-jean-philippe.brucker@arm.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
        <20190603145749.46347-3-jean-philippe.brucker@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Jun 2019 15:57:47 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> +/**
> + * struct iommu_fault_page_request - Page Request data
> + * @flags: encodes whether the corresponding fields are valid and
> whether this
> + *         is the last page in group (IOMMU_FAULT_PAGE_REQUEST_*
> values)
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
> + * @addr: page address
> + * @private_data: device-specific private information
> + */
> +struct iommu_fault_page_request {
> +#define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
> +#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
> +#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
> +	__u32	flags;
> +	__u32	pasid;
> +	__u32	grpid;
> +	__u32	perm;
> +	__u64	addr;
> +	__u64	private_data[2];
> +};
> +

Just a thought, for non-identity G-H PASID management. We could pass on
guest PASID in PRQ to save a lookup in QEMU. In this case, QEMU
allocate a GPASID for vIOMMU then a host PASID for pIOMMU. QEMU has a
G->H lookup. When PRQ comes in to the pIOMMU with HPASID, IOMMU driver
can retrieve GPASID from the bind data then report to the guest via
VFIO. In this case QEMU does not need to do a H->G PASID lookup.

Should we add a gpasid field here? or we can add a flag and field
later, up to you.

Thanks,

Jacob
