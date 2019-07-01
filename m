Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC40DEEB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 04:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfD3CIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 22:08:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:30588 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfD3CIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:08:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 19:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,412,1549958400"; 
   d="scan'208";a="295649533"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2019 19:08:18 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-3-baolu.lu@linux.intel.com>
 <20190422164555.GA31181@lst.de>
 <0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com>
 <20190423061232.GB12762@lst.de>
 <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
 <20190424144532.GA21480@lst.de>
 <a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com>
 <20190426150433.GA19930@lst.de>
 <93b3d627-782d-cae0-2175-77a5a8b3fe6e@linux.intel.com>
 <90182d27-5764-7676-8ca6-b2773a40cfe1@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1361b6ab-c3cf-d8ab-5f6b-9d9b7797bf02@linux.intel.com>
Date:   Tue, 30 Apr 2019 10:02:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <90182d27-5764-7676-8ca6-b2773a40cfe1@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 4/29/19 7:06 PM, Robin Murphy wrote:
> On 29/04/2019 06:10, Lu Baolu wrote:
>> Hi Christoph,
>>
>> On 4/26/19 11:04 PM, Christoph Hellwig wrote:
>>> On Thu, Apr 25, 2019 at 10:07:19AM +0800, Lu Baolu wrote:
>>>> This is not VT-d specific. It's just how generic IOMMU works.
>>>>
>>>> Normally, IOMMU works in paging mode. So if a driver issues DMA with
>>>> IOVA  0xAAAA0123, IOMMU can remap it with a physical address 
>>>> 0xBBBB0123.
>>>> But we should never expect IOMMU to remap 0xAAAA0123 with physical
>>>> address of 0xBBBB0000. That's the reason why I said that IOMMU will not
>>>> work there.
>>>
>>> Well, with the iommu it doesn't happen.  With swiotlb it obviosuly
>>> can happen, so drivers are fine with it.  Why would that suddenly
>>> become an issue when swiotlb is called from the iommu code?
>>>
>>
>> I would say IOMMU is DMA remapping, not DMA engine. :-)
> 
> I'm not sure I really follow the issue here - if we're copying the 
> buffer to the bounce page(s) there's no conceptual difference from 
> copying it to SWIOTLB slot(s), so there should be no need to worry about 
> the original in-page offset.
> 
>  From the reply up-thread I guess you're trying to include an 
> optimisation to only copy the head and tail of the buffer if it spans 
> multiple pages, and directly map the ones in the middle, but AFAICS 
> that's going to tie you to also using strict mode for TLB maintenance, 
> which may not be a win overall depending on the balance between 
> invalidation bandwidth vs. memcpy bandwidth. At least if we use standard 
> SWIOTLB logic to always copy the whole thing, we should be able to 
> release the bounce pages via the flush queue to allow 'safe' lazy unmaps.
>

With respect, even we use the standard SWIOTLB logic, we need to use
the strict mode for TLB maintenance.

Say, some swiotbl slots are used by untrusted device for bounce page
purpose. When the device driver unmaps the IOVA, the slots are freed but
the mapping is still cached in IOTLB, hence the untrusted device is 
still able to access the slots. Then the slots are allocated to other
devices. This makes it possible for the untrusted device to access
the data buffer of other devices.

Best regards,
Lu Baolu

> Either way I think it would be worth just implementing the 
> straightforward version first, then coming back to consider 
> optimisations later.



