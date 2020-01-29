Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90E14D2A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 22:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgA2Vk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 16:40:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28256 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726222AbgA2Vk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580334055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8pjsr+8GgeZRx08ogbJ32q6tJdvfyOSXMDX5qngbmsc=;
        b=DQmNA8ZEhs7sdGr0Bzf29Ar8KJ/RnSYZwakAkdsbBW4NHJDznSIOGtH+NpYx5uB4jUlcXu
        sXyCmjAfljWqI1upTaf6OA1SXCbqJ0YcDCfhLwOgrO9hnn95Qu++9eVMXWzP2zYbNtdnwM
        vXVoAheN5Kx+PVznQ0ktO7V/dzNLYNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-BKFe_yzwM1CxZrLAq07h-g-1; Wed, 29 Jan 2020 16:40:53 -0500
X-MC-Unique: BKFe_yzwM1CxZrLAq07h-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ECCA18A6EC1;
        Wed, 29 Jan 2020 21:40:51 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE8F687B07;
        Wed, 29 Jan 2020 21:40:47 +0000 (UTC)
Date:   Wed, 29 Jan 2020 14:40:46 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Message-ID: <20200129144046.3f91e4c1@w520.home>
In-Reply-To: <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 22:02:04 -0800
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> IOMMU UAPI can be extended in the future by adding new
> fields at the end of each user data structure. Since we use
> a unified UAPI version for compatibility checking, a lookup
> function is needed to find the correct user data size to copy
> from user.
> 
> This patch adds a helper function based on a 2D lookup with
> version and type as input arguments.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
>  include/linux/iommu.h |  6 ++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 7dd51c5d2ba1..9e5de9abebdf 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1696,6 +1696,28 @@ int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
>  
> +
> +/**
> + * Maintain a UAPI version to user data structure size lookup for each
> + * API function types we support. e.g. bind guest pasid, cache invalidation.
> + * As data structures being extended with new members, the offsetofend()
> + * will identify the new sizes.
> + */
> +const static int iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
> +	/* IOMMU_UAPI_BIND_GPASID */
> +	{offsetofend(struct iommu_gpasid_bind_data, vtd)},
> +	/* IOMMU_UAPI_CACHE_INVAL */
> +	{offsetofend(struct iommu_cache_invalidate_info, addr_info)},
> +	/* IOMMU_UAPI_PAGE_RESP */
> +	{offsetofend(struct iommu_page_response, code)},
> +};
> +
> +int iommu_uapi_get_data_size(int type, int version)
> +{

Seems like this is asking for a bounds check,

  if (type >= NR_IOMMU_UAPI_TYPE || version > IOMMU_UAPI_VERSION)
  	return -EINVAL;

If we add new types in future versions, I assume we'd back fill the
table with -EINVAL as well (rather than zero).  Thanks,

Alex

> +	return iommu_uapi_data_size[type][version - 1];
> +}
> +EXPORT_SYMBOL_GPL(iommu_uapi_get_data_size);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9718c109ea0a..416fe02160ba 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -500,6 +500,7 @@ extern int iommu_report_device_fault(struct device *dev,
>  				     struct iommu_fault_event *evt);
>  extern int iommu_page_response(struct device *dev,
>  			       struct iommu_page_response *msg);
> +extern int iommu_uapi_get_data_size(int type, int version);
>  
>  extern int iommu_group_id(struct iommu_group *group);
>  extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> @@ -885,6 +886,11 @@ static inline int iommu_page_response(struct device *dev,
>  	return -ENODEV;
>  }
>  
> +static int iommu_uapi_get_data_size(int type, int version)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline int iommu_group_id(struct iommu_group *group)
>  {
>  	return -ENODEV;

