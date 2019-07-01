Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7445FDFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfD2KBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 06:01:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52180 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfD2KBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:01:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1DBF80D;
        Mon, 29 Apr 2019 03:01:11 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74FFC3F5AF;
        Mon, 29 Apr 2019 03:01:09 -0700 (PDT)
Subject: Re: [PATCH v2 11/19] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
To:     Auger Eric <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-12-git-send-email-jacob.jun.pan@linux.intel.com>
 <e542fd95-acbe-05e9-e441-27dff752c21a@redhat.com>
 <20190426140133.6d445315@jacob-builder>
 <f06a9675-278f-51db-f385-e1305b3795d6@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <7529f2ca-167b-5e65-9330-9093638e9f91@arm.com>
Date:   Mon, 29 Apr 2019 11:00:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f06a9675-278f-51db-f385-e1305b3795d6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2019 09:38, Auger Eric wrote:
>>>> --- a/drivers/iommu/intel-iommu.c
>>>> +++ b/drivers/iommu/intel-iommu.c
>>>> @@ -5153,7 +5153,7 @@ static void auxiliary_unlink_device(struct
>>>> dmar_domain *domain, domain->auxd_refcnt--;
>>>>  
>>>>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
>>>> -		intel_pasid_free_id(domain->default_pasid);
>>>> +		ioasid_free(domain->default_pasid);
>>>>  }
>>>>  
>>>>  static int aux_domain_add_dev(struct dmar_domain *domain,
>>>> @@ -5171,9 +5171,8 @@ static int aux_domain_add_dev(struct
>>>> dmar_domain *domain, if (domain->default_pasid <= 0) {
>>>>  		int pasid;
>>>>  
>>>> -		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
>>>> -
>>>> pci_max_pasids(to_pci_dev(dev)),
>>>> -					     GFP_KERNEL);
>>>> +		pasid = ioasid_alloc(NULL, PASID_MIN,
>>>> pci_max_pasids(to_pci_dev(dev)) - 1,
>>>> +				domain);
>>>>  		if (pasid <= 0) {  
>>> ioasid_t is a uint and returns INVALID_IOASID on error. Wouldn't it be
>>> simpler to make ioasid_alloc return an int?
>> Well, I think we still want the full uint range - 1(INVALID_IOASID).
>> Intel uses 20bit but I think SMMUs use 32 bits for streamID? I
>> should just check 
>> 	if (pasid == INVALID_IOASID) {
> Jean-Philippe may correct me but SMMU uses 20b SubstreamId which is a
> superset of PASIDs. StreamId is 32b.

Right, we use 20 bits for PASIDs (== SubstreamID really). Given the
choices that vendors are making for PASIDs (a global namespace rather
than per-VM), I wouldn't be surprised if they extend the size of PASIDs
in a couple of years, so I added the typedef ioasid_t to ease a possible
change from 32-bit to 64 in the future.

Thanks,
Jean
