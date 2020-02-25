Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7616BBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 09:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgBYIcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 03:32:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46522 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbgBYIcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582619551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgKQtRV01Bi8I2OWDhHoJzlNxr2o35DwN7ZNxHQ2pcE=;
        b=EWIIwc1rwxjLMWLXVRxtPQGUg5qm4mQrvv26p0iJwfgqcUr5oNgpcYpmpbclA0TvKAcvyk
        qPj5blpuFmU13LvcUqkox9jLKRI+cdpjl3z3+ekm/aFl1ai1HdowsYe1wAsuT9oka4cZgo
        Kv/MQSboxwACkgDgnWQS2gORv9orVXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-aLC00U-3MtC6YXxGwaGXZA-1; Tue, 25 Feb 2020 03:32:23 -0500
X-MC-Unique: aLC00U-3MtC6YXxGwaGXZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D08BB107ACC7;
        Tue, 25 Feb 2020 08:32:21 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 448B660BF7;
        Tue, 25 Feb 2020 08:32:16 +0000 (UTC)
Subject: Re: [PATCH V9 05/10] iommu/vt-d: Support flushing more translation
 cache types
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277713-66934-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <11add211-dec0-1932-c29c-22cbbf145bd4@redhat.com>
 <20200214152701.18f76ce1@jacob-builder>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <5e7841c4-28df-7a4a-e801-f42b62de1e3d@redhat.com>
Date:   Tue, 25 Feb 2020 09:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200214152701.18f76ce1@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 2/15/20 12:27 AM, Jacob Pan wrote:
> Hi Eric,
> 
> On Wed, 12 Feb 2020 13:55:25 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Jacob,
>>
>> On 1/29/20 7:01 AM, Jacob Pan wrote:
>>> When Shared Virtual Memory is exposed to a guest via vIOMMU,
>>> scalable IOTLB invalidation may be passed down from outside IOMMU
>>> subsystems. This patch adds invalidation functions that can be used
>>> for additional translation cache types.
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
>>>  drivers/iommu/dmar.c        | 33 +++++++++++++++++++++++++++++++++
>>>  drivers/iommu/intel-pasid.c |  3 ++-
>>>  include/linux/intel-iommu.h | 20 ++++++++++++++++----
>>>  3 files changed, 51 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>>> index 071bb42bbbc5..206733ec8140 100644
>>> --- a/drivers/iommu/dmar.c
>>> +++ b/drivers/iommu/dmar.c
>>> @@ -1411,6 +1411,39 @@ void qi_flush_piotlb(struct intel_iommu
>>> *iommu, u16 did, u32 pasid, u64 addr, qi_submit_sync(&desc, iommu);
>>>  }
>>>  
>>> +/* PASID-based device IOTLB Invalidate */
>>> +void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid,
>>> u16 pfsid,
>>> +		u32 pasid,  u16 qdep, u64 addr, unsigned
>>> size_order, u64 granu) +{
>>> +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
>>> +
>>> +	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) |
>>> QI_DEV_EIOTLB_SID(sid) |
>>> +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
>>> +		QI_DEV_IOTLB_PFSID(pfsid);
>>> +	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
>>> +
>>> +	/* If S bit is 0, we only flush a single page. If S bit is
>>> set,
>>> +	 * The least significant zero bit indicates the
>>> invalidation address
>>> +	 * range. VT-d spec 6.5.2.6.
>>> +	 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates
>>> 16KB.
>>> +	 */
>>> +	if (!size_order) {
>>> +		desc.qw0 |= QI_DEV_EIOTLB_ADDR(addr) &
>>> ~QI_DEV_EIOTLB_SIZE;
>>> +	} else {
>>> +		unsigned long mask = 1UL << (VTD_PAGE_SHIFT +
>>> size_order);
>>> +		desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr & ~mask) |
>>> QI_DEV_EIOTLB_SIZE;
>>> +	}
>>> +	qi_submit_sync(&desc, iommu);  
>> I made some comments in
>> https://lkml.org/lkml/2019/8/14/1311
>> that do not seem to have been taken into account. Or do I miss
>> something?
>>
> I missed adding these changes. At the time Baolu was doing cache flush
> consolidation so I wasn't sure if I could use his code completely. This
> patch is on top of his consolidated flush code with what is still
> needed for vSVA. Then I forgot to address your comments. Sorry about
> that.
no problem
> 
>> More generally having an individual history log would be useful and
>> speed up the review.
>>
> Will add history to each patch, e.g. like this?
> ---
> v8 -> v9
yes thanks. You're not obliged to list every little thing but to me, it
helps to see at first sight if you took into account major comments and
in case you did not - on purpose -, you can also indicate it.

Thanks

Eric
> ---
>> Thanks
>>
>> Eric
>>> +}
>>> +
>>> +void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64
>>> granu, int pasid) +{
>>> +	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
>>> +
>>> +	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) |
>>> QI_PC_GRAN(granu) | QI_PC_TYPE;
>>> +	qi_submit_sync(&desc, iommu);
>>> +}
>>> +
>>>  /*
>>>   * Disable Queued Invalidation interface.
>>>   */
>>> diff --git a/drivers/iommu/intel-pasid.c
>>> b/drivers/iommu/intel-pasid.c index bd067af4d20b..b100f51407f9
>>> 100644 --- a/drivers/iommu/intel-pasid.c
>>> +++ b/drivers/iommu/intel-pasid.c
>>> @@ -435,7 +435,8 @@ pasid_cache_invalidation_with_pasid(struct
>>> intel_iommu *iommu, {
>>>  	struct qi_desc desc;
>>>  
>>> -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL |
>>> QI_PC_PASID(pasid);
>>> +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
>>> +		QI_PC_PASID(pasid) | QI_PC_TYPE;
>>>  	desc.qw1 = 0;
>>>  	desc.qw2 = 0;
>>>  	desc.qw3 = 0;
>>> diff --git a/include/linux/intel-iommu.h
>>> b/include/linux/intel-iommu.h index b0ffecbc0dfc..dd9fa61689bc
>>> 100644 --- a/include/linux/intel-iommu.h
>>> +++ b/include/linux/intel-iommu.h
>>> @@ -332,7 +332,7 @@ enum {
>>>  #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >>
>>> (DMA_TLB_FLUSH_GRANU_OFFSET-4)) #define QI_IOTLB_ADDR(addr)
>>> (((u64)addr) & VTD_PAGE_MASK) #define
>>> QI_IOTLB_IH(ih)		(((u64)ih) << 6) -#define
>>> QI_IOTLB_AM(am)		(((u8)am)) +#define
>>> QI_IOTLB_AM(am)		(((u8)am) & 0x3f) 
>>>  #define QI_CC_FM(fm)		(((u64)fm) << 48)
>>>  #define QI_CC_SID(sid)		(((u64)sid) << 32)
>>> @@ -351,16 +351,21 @@ enum {
>>>  #define QI_PC_DID(did)		(((u64)did) << 16)
>>>  #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
>>>  
>>> -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
>>> -#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
>>> +/* PASID cache invalidation granu */
>>> +#define QI_PC_ALL_PASIDS	0
>>> +#define QI_PC_PASID_SEL		1
>>>  
>>>  #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
>>>  #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
>>> -#define QI_EIOTLB_AM(am)	(((u64)am))
>>> +#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
>>>  #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
>>>  #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
>>>  #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
>>>  
>>> +/* QI Dev-IOTLB inv granu */
>>> +#define QI_DEV_IOTLB_GRAN_ALL		1
>>> +#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
>>> +
>>>  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>>>  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
>>>  #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
>>> @@ -660,8 +665,15 @@ extern void qi_flush_iotlb(struct intel_iommu
>>> *iommu, u16 did, u64 addr, unsigned int size_order, u64 type);
>>>  extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid,
>>> u16 pfsid, u16 qdep, u64 addr, unsigned mask);
>>> +
>>>  void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32
>>> pasid, u64 addr, unsigned long npages, bool ih);
>>> +
>>> +extern void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
>>> u16 sid, u16 pfsid,
>>> +			u32 pasid, u16 qdep, u64 addr, unsigned
>>> size_order, u64 granu); +
>>> +extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16
>>> did, u64 granu, int pasid); +
>>>  extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu
>>> *iommu); 
>>>  extern int dmar_ir_support(void);
>>>   
>>
> 
> [Jacob Pan]
> 

