Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3304614158A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 03:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgARCGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 21:06:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:57680 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgARCGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 21:06:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 18:06:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="214684983"
Received: from allen-box.sh.intel.com (HELO [10.239.159.138]) ([10.239.159.138])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2020 18:06:19 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] PCI: Add "pci=iommu_passthrough=" parameter for
 iommu passthrough
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200117232403.GA142078@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bce2cf6c-d030-3265-d8b7-0faa895e3d5a@linux.intel.com>
Date:   Sat, 18 Jan 2020 10:04:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117232403.GA142078@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 1/18/20 8:18 AM, Bjorn Helgaas wrote:
> On Wed, Jan 01, 2020 at 01:26:46PM +0800, Lu Baolu wrote:
>> The new parameter takes a list of devices separated by a semicolon.
>> Each device specified will have its iommu_passthrough bit in struct
>> device set. This is very similar to the existing 'disable_acs_redir'
>> parameter.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  5 +++
>>   drivers/pci/pci.c                             | 34 +++++++++++++++++++
>>   drivers/pci/pci.h                             |  1 +
>>   drivers/pci/probe.c                           |  2 ++
>>   4 files changed, 42 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index ade4e6ec23e0..d3edc2cb6696 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3583,6 +3583,11 @@
>>   				may put more devices in an IOMMU group.
>>   		force_floating	[S390] Force usage of floating interrupts.
>>   		nomio		[S390] Do not use MIO instructions.
>> +		iommu_passthrough=<pci_dev>[; ...]
>> +				Specify one or more PCI devices (in the format
>> +				specified above) separated by semicolons.
>> +				Each device specified will bypass IOMMU DMA
>> +				translation.
>>   
>>   	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>>   			Management.
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 90dbd7c70371..05bf3f4acc36 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6401,6 +6401,37 @@ void __weak pci_fixup_cardbus(struct pci_bus *bus)
>>   }
>>   EXPORT_SYMBOL(pci_fixup_cardbus);
>>   
>> +static const char *iommu_passthrough_param;
>> +bool pci_iommu_passthrough_match(struct pci_dev *dev)
>> +{
>> +	int ret = 0;
>> +	const char *p = iommu_passthrough_param;
>> +
>> +	if (!p)
>> +		return false;
>> +
>> +	while (*p) {
>> +		ret = pci_dev_str_match(dev, p, &p);
>> +		if (ret < 0) {
>> +			pr_info_once("PCI: Can't parse iommu_passthrough parameter: %s\n",
>> +				     iommu_passthrough_param);
>> +
>> +			break;
>> +		} else if (ret == 1) {
>> +			pci_info(dev, "PCI: IOMMU passthrough\n");
>> +			return true;
>> +		}
>> +
>> +		if (*p != ';' && *p != ',') {
>> +			/* End of param or invalid format */
>> +			break;
>> +		}
>> +		p++;
>> +	}
>> +
>> +	return false;
>> +}
> 
> This duplicates a lot of the code in pci_disable_acs_redir().  That
> needs to be factored out somehow so we don't duplicate it.
> 

Sure. I will try to refactor the code in the next version.

> Bjorn
> 

Best regards,
baolu
