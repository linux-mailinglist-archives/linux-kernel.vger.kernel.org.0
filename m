Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E111C76A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 13:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfENLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 07:02:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfENLCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:02:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81E9C3079B80;
        Tue, 14 May 2019 11:02:54 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 006701018A2E;
        Tue, 14 May 2019 11:02:49 +0000 (UTC)
Subject: Re: [PATCH v3 02/16] iommu: Introduce cache_invalidate API
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <d32d3d19-11c9-4af9-880b-bb8ebefd4f7f@redhat.com>
 <44d5ba37-a9e9-cc7a-2a3a-d32b840afa29@arm.com>
 <7807afe9-efab-9f48-4ca0-2332a7a54950@redhat.com>
 <1a5a5fad-ed21-5c79-9a9e-ff21fadfb95f@arm.com>
 <1edd45e6-4da3-e393-36b2-9e63cd5f7607@redhat.com>
 <4094baf1-6cf5-a33b-4717-08ced0673c50@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <5d2c0279-7fa9-3d11-9999-583f9ed329ba@redhat.com>
Date:   Tue, 14 May 2019 13:02:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4094baf1-6cf5-a33b-4717-08ced0673c50@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 14 May 2019 11:02:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 5/14/19 12:42 PM, Jean-Philippe Brucker wrote:
> On 14/05/2019 08:46, Auger Eric wrote:
>> Hi Jean,
>>
>> On 5/13/19 7:09 PM, Jean-Philippe Brucker wrote:
>>> On 13/05/2019 17:50, Auger Eric wrote:
>>>>> struct iommu_inv_pasid_info {
>>>>> #define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
>>>>> #define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
>>>>> 	__u32	flags;
>>>>> 	__u32	archid;
>>>>> 	__u64	pasid;
>>>>> };
>>>> I agree it does the job now. However it looks a bit strange to do a
>>>> PASID based invalidation in my case - SMMUv3 nested stage - where I
>>>> don't have any PASID involved.
>>>>
>>>> Couldn't we call it context based invalidation then? A context can be
>>>> tagged by a PASID or/and an ARCHID.
>>>
>>> I think calling it "context" would be confusing as well (I shouldn't
>>> have used it earlier), since VT-d uses that name for device table
>>> entries (=STE on Arm SMMU). Maybe "addr_space"?
>> yes you're right. Well we already pasid table table terminology so we
>> can use it here as well - as long as we understand what purpose it
>> serves ;-) - So OK for iommu_inv_pasid_info.
>>
>> I think Jean understood we would keep pasid standalone field in
I meant Jacob here.
>> iommu_cache_invalidate_info's union. I understand the struct
>> iommu_inv_pasid_info now would replace it, correct?

Thank you for the confirmation.

Eric

> 
> Yes
> 
> Thanks,
> Jean
> 
