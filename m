Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB06619359C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 03:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgCZCMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 22:12:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:15386 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbgCZCMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 22:12:41 -0400
IronPort-SDR: xNnx5/Kg62OXFyqtHJs2MiopOA6R7/ol0K22jZRSzvaRbMP3yoJBV2zvvRPKvAmcTjRe2OW+cK
 PMC4Hmdxd+JQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 19:12:40 -0700
IronPort-SDR: zqkx0+f/2/EY+63IZ2XidSntJ6hpqgyVyvr7HQgHtVL6PvIemjVyU5bwMxC73QHGcYIXxGJKRW
 vfxvAvNYgKAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="238675450"
Received: from taoli1-mobl.ccr.corp.intel.com (HELO [10.254.215.75]) ([10.254.215.75])
  by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2020 19:12:37 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 03/10] iommu/ioasid: Introduce per set allocation APIs
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8abd6586-e110-1487-034b-c59e4275cae9@linux.intel.com>
Date:   Thu, 26 Mar 2020 10:12:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/26 1:55, Jacob Pan wrote:
> IOASID set defines a group of IDs that share the same token. The
> ioasid_set concept helps to do permission checking among users as in the
> current code.
> 
> With guest SVA usage, each VM has its own IOASID set. More
> functionalities are needed:
> 1. Enforce quota, each guest may be assigned limited quota such that one
> guest cannot abuse all the system resource.
> 2. Stores IOASID mapping between guest and host IOASIDs
> 3. Per set operations, e.g. free the entire set
> 
> For each ioasid_set token, a unique set ID is assigned. This makes
> reference of the set and data lookup much easier to implement.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/ioasid.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/ioasid.h |  13 +++++
>   2 files changed, 160 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 4026e52855b9..27ee57f7079b 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -10,6 +10,25 @@
>   #include <linux/spinlock.h>
>   #include <linux/xarray.h>
>   
> +static DEFINE_XARRAY_ALLOC(ioasid_sets);
> +/**
> + * struct ioasid_set_data - Meta data about ioasid_set
> + *
> + * @token:	Unique to identify an IOASID set
> + * @xa:		XArray to store subset ID and IOASID mapping
> + * @size:	Max number of IOASIDs can be allocated within the set
> + * @nr_ioasids	Number of IOASIDs allocated in the set
> + * @sid		ID of the set
> + */
> +struct ioasid_set_data {
> +	struct ioasid_set *token;
> +	struct xarray xa;
> +	int size;
> +	int nr_ioasids;
> +	int sid;
> +	struct rcu_head rcu;
> +};
> +
>   struct ioasid_data {
>   	ioasid_t id;
>   	struct ioasid_set *set;
> @@ -388,6 +407,111 @@ void ioasid_free(ioasid_t ioasid)
>   EXPORT_SYMBOL_GPL(ioasid_free);
>   
>   /**
> + * ioasid_alloc_set - Allocate a set of IOASIDs
> + * @token:	Unique token of the IOASID set
> + * @quota:	Quota allowed in this set
> + * @sid:	IOASID set ID to be assigned
> + *
> + * Return 0 upon success. Token will be stored internally for lookup,
> + * IOASID allocation within the set and other per set operations will use
> + * the @sid assigned.
> + *
> + */
> +int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid)
> +{
> +	struct ioasid_set_data *sdata;
> +	ioasid_t id;
> +	int ret = 0;
> +
> +	if (quota > ioasid_capacity_avail) {
> +		pr_warn("Out of IOASID capacity! ask %d, avail %d\n",
> +			quota, ioasid_capacity_avail);
> +		return -ENOSPC;
> +	}
> +
> +	sdata = kzalloc(sizeof(*sdata), GFP_KERNEL);
> +	if (!sdata)
> +		return -ENOMEM;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +
> +	ret = xa_alloc(&ioasid_sets, &id, sdata,
> +		       XA_LIMIT(0, ioasid_capacity_avail - quota),
> +		       GFP_KERNEL);
> +	if (ret) {
> +		kfree(sdata);
> +		goto error;
> +	}
> +
> +	sdata->token = token;
> +	sdata->size = quota;
> +	sdata->sid = id;
> +
> +	/*
> +	 * Set Xarray is used to store IDs within the set, get ready for
> +	 * sub-set ID and system-wide IOASID allocation results.
> +	 */
> +	xa_init_flags(&sdata->xa, XA_FLAGS_ALLOC);
> +
> +	ioasid_capacity_avail -= quota;
> +	*sid = id;
> +
> +error:
> +	spin_unlock(&ioasid_allocator_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_alloc_set);
> +
> +/**
> + * ioasid_free_set - Free all IOASIDs within the set
> + *
> + * @sid:		The IOASID set ID to be freed
> + * @destroy_set:	Whether to keep the set for further allocation.
> + *			If true, the set will be destroyed.
> + *
> + * All IOASIDs allocated within the set will be freed upon return.
> + */
> +void ioasid_free_set(int sid, bool destroy_set)
> +{
> +	struct ioasid_set_data *sdata;
> +	struct ioasid_data *entry;
> +	unsigned long index;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	sdata = xa_load(&ioasid_sets, sid);
> +	if (!sdata) {
> +		pr_err("No IOASID set found to free %d\n", sid);
> +		goto done_unlock;
> +	}
> +
> +	if (xa_empty(&sdata->xa)) {
> +		pr_warn("No IOASIDs in the set %d\n", sdata->sid);
> +		goto done_destroy;
> +	}
> +
> +	/* Just a place holder for now */
> +	xa_for_each(&sdata->xa, index, entry) {
> +		/* Free from per sub-set pool */
> +		xa_erase(&sdata->xa, index);
> +	}
> +
> +done_destroy:
> +	if (destroy_set) {
> +		xa_erase(&ioasid_sets, sid);
> +
> +		/* Return the quota back to system pool */
> +		ioasid_capacity_avail += sdata->size;
> +		kfree_rcu(sdata, rcu);
> +	}
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_free_set);
> +
> +
> +/**
>    * ioasid_find - Find IOASID data
>    * @set: the IOASID set
>    * @ioasid: the IOASID to find
> @@ -431,6 +555,29 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>   }
>   EXPORT_SYMBOL_GPL(ioasid_find);
>   
> +/**
> + * ioasid_find_sid - Retrieve IOASID set ID from an ioasid
> + *                   Caller must hold a reference to the set.
> + *
> + * @ioasid: IOASID associated with the set
> + *
> + * Return IOASID set ID or error
> + */
> +int ioasid_find_sid(ioasid_t ioasid)
> +{
> +	struct ioasid_data *ioasid_data;
> +	int ret = 0;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> +	ret = (ioasid_data) ? ioasid_data->sdata->sid : -ENOENT;
> +
> +	spin_unlock(&ioasid_allocator_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_find_sid);
> +
>   MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
>   MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
>   MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 9711fa0dc357..be158e03c034 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -41,6 +41,9 @@ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>   void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>   int ioasid_set_data(ioasid_t ioasid, void *data);
>   void ioasid_install_capacity(ioasid_t total);
> +int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
> +void ioasid_free_set(int sid, bool destroy_set);
> +int ioasid_find_sid(ioasid_t ioasid);
>   #else /* !CONFIG_IOASID */
>   static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
>   				    ioasid_t max, void *private)
> @@ -52,6 +55,15 @@ static inline void ioasid_free(ioasid_t ioasid)
>   {
>   }
>   
> +static inline int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void ioasid_free_set(int sid, bool destroy_set)
> +{
> +}
> +

static inline int ioasid_find_sid(ioasid_t ioasid)
{
	return INVALID_IOASID;
}

Best regards,
baolu

>   static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>   				bool (*getter)(void *))
>   {
> @@ -75,5 +87,6 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
>   static inline void ioasid_install_capacity(ioasid_t total)
>   {
>   }
> +
>   #endif /* CONFIG_IOASID */
>   #endif /* __LINUX_IOASID_H */
> 
