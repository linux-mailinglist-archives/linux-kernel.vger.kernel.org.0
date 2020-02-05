Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5664A152474
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 02:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgBEB2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 20:28:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:45636 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbgBEB2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:28:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 17:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="225690656"
Received: from jingyilu-mobl2.ccr.corp.intel.com (HELO [10.254.209.127]) ([10.254.209.127])
  by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2020 17:28:10 -0800
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no
 IOMMU
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <20200203091009.196658-1-jian-hong@endlessm.com>
 <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com>
 <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <948da337-128f-22ae-7b2e-730b4b8da446@linux.intel.com>
Date:   Wed, 5 Feb 2020 09:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/2/4 17:25, Jian-Hong Pan wrote:
> Lu Baolu <baolu.lu@linux.intel.com> 於 2020年2月4日 週二 下午2:11寫道：
>>
>> Hi,
>>
>> On 2020/2/3 17:10, Jian-Hong Pan wrote:
>>> If the device has no IOMMU, it still invokes iommu_need_mapping during
>>> intel_alloc_coherent. However, iommu_need_mapping can only check the
>>> device is DUMMY_DEVICE_DOMAIN_INFO or not. This patch marks the device
>>> is a DUMMY_DEVICE_DOMAIN_INFO if the device has no IOMMU.
>>>
>>> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
>>> ---
>>>    drivers/iommu/intel-iommu.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>> index 35a4a3abedc6..878bc986a015 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -5612,8 +5612,10 @@ static int intel_iommu_add_device(struct device *dev)
>>>        int ret;
>>>
>>>        iommu = device_to_iommu(dev, &bus, &devfn);
>>> -     if (!iommu)
>>> +     if (!iommu) {
>>> +             dev->archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;
>>
>> Is this a DMA capable device?
> 
> Do you mean is the device in DMA Remapping table?
> Dump DMAR from ACPI table.  The device is not in the table.
> So, it does not support DMAR, Intel IOMMU.
> 
> Or, should device_to_iommu be invoked in iommu_need_mapping to check
> IOMMU feature again?
> 

Normally intel_iommu_add_device() should only be called for PCI devices
and APCI name space devices (reported in ACPI/DMAR table). In both
cases, device_to_iommu() should always return a corresponding iommu. I
just tried to understand why it failed for your case.

Best regards,
baolu
