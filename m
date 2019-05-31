Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F5C30D05
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfEaLFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 07:05:44 -0400
Received: from foss.arm.com ([217.140.101.70]:50138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfEaLFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 07:05:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6DE0341;
        Fri, 31 May 2019 04:05:41 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EC033F59C;
        Fri, 31 May 2019 04:05:40 -0700 (PDT)
Subject: Re: [PATCH 4/4] iommu: Add recoverable fault reporting
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     yi.l.liu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20190523180613.55049-1-jean-philippe.brucker@arm.com>
 <20190523180613.55049-5-jean-philippe.brucker@arm.com>
 <20190524111444.676a4df1@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <9df2db3b-3892-f4ae-c7de-dbb27a12b293@arm.com>
Date:   Fri, 31 May 2019 12:05:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190524111444.676a4df1@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2019 19:14, Jacob Pan wrote:
> On Thu, 23 May 2019 19:06:13 +0100
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index d546f7baa0d4..b09b3707f0e4 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -872,7 +872,14 @@
>> EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
>>   * @data: private data passed as argument to the handler
>>   *
>>   * When an IOMMU fault event is received, this handler gets called
>> with the
>> - * fault event and data as argument. The handler should return 0 on
>> success.
>> + * fault event and data as argument. The handler should return 0 on
>> success. If
>> + * the fault is recoverable (IOMMU_FAULT_PAGE_REQ), the handler
>> should also
>> + * complete the fault by calling iommu_page_response() with one of
>> the following
> nit, in case of injecting into the guest, handler does not have to call
> iommu_page_response() directly.

True, I'll think of a better wording. Maybe just s/handler/consumer/
although we didn't define consumer anywhere


>> IOMMU_PAGE_RESP_PASID_VALID : 0; +
>> +		ret = domain->ops->page_response(dev, msg,
>> evt->iommu_private);
> I guess here you could drop iommu_private in favor of prm such that
> drivers such as vt-d can recover private data as needed?

Yes, will change this

Thanks,
Jean
