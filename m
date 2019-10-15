Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3DED71CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 11:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfJOJIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 05:08:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfJOJIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:08:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E49F951A1DF59C7F64F8;
        Tue, 15 Oct 2019 17:08:10 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 17:08:01 +0800
Subject: Re: [RFC PATCH 1/6] ACPI/IORT: Set PMCG device parent
To:     Hanjun Guo <guohanjun@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>, <robin.murphy@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>
References: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
 <1569854031-237636-2-git-send-email-john.garry@huawei.com>
 <ae9a1c8a-d84b-95ab-9a6b-87a7c89c68d9@huawei.com>
CC:     <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <nleeder@codeaurora.org>,
        <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c7bfc6ac-71a1-50d2-e18f-4d352837b93b@huawei.com>
Date:   Tue, 15 Oct 2019 10:07:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <ae9a1c8a-d84b-95ab-9a6b-87a7c89c68d9@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanjun,

Thanks for checking this.

>>   */
>>  static int __init iort_add_platform_device(struct acpi_iort_node *node,
>> -					   const struct iort_dev_config *ops)
>> +					   const struct iort_dev_config *ops, struct device *parent)
>
> Since you added a input for this function, could you please update
> the comments of this function as well?

Right, that can be updated. Indeed, the current comment omit the @ops 
argument also.

>
>>  {
>>  	struct fwnode_handle *fwnode;
>>  	struct platform_device *pdev;
>> @@ -1466,6 +1466,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>>  	if (!pdev)
>>  		return -ENOMEM;
>>
>> +	pdev->dev.parent = parent;
>> +
>>  	if (ops->dev_set_proximity) {
>>  		ret = ops->dev_set_proximity(&pdev->dev, node);
>>  		if (ret)
>> @@ -1573,6 +1575,11 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
>>  static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
>>  #endif
>>
>> +static int iort_fwnode_match(struct device *dev, const void *fwnode)
>> +{
>> +	return dev->fwnode == fwnode;
>> +}
>> +
>>  static void __init iort_init_platform_devices(void)
>>  {
>>  	struct acpi_iort_node *iort_node, *iort_end;
>> @@ -1594,11 +1601,34 @@ static void __init iort_init_platform_devices(void)
>>  				iort_table->length);
>>
>>  	for (i = 0; i < iort->node_count; i++) {
>> +		struct device *parent = NULL;
>> +
>>  		if (iort_node >= iort_end) {
>>  			pr_err("iort node pointer overflows, bad table\n");
>>  			return;
>>  		}
>>
>> +		/* Fixme: handle parent declared in IORT after PMCG */
>> +		if (iort_node->type == ACPI_IORT_NODE_PMCG) {
>> +			struct acpi_iort_node *iort_assoc_node;
>> +			struct acpi_iort_pmcg *pmcg;
>> +			u32 node_reference;
>> +
>> +			pmcg = (struct acpi_iort_pmcg *)iort_node->node_data;
>> +
>> +			node_reference = pmcg->node_reference;
>> +			iort_assoc_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
>> +				 node_reference);
>> +
>> +			if (iort_assoc_node->type == ACPI_IORT_NODE_SMMU_V3) {
>> +				struct fwnode_handle *assoc_fwnode;
>> +
>> +				assoc_fwnode = iort_get_fwnode(iort_assoc_node);
>> +
>> +				parent = bus_find_device(&platform_bus_type, NULL,
>> +				      assoc_fwnode, iort_fwnode_match);
>> +			}
>> +		}
>
> How about using a function to include those new added code to make this
> function (iort_init_platform_devices()) a bit cleaner?
>

Can do. But I still need to add code to deal with the scenario of the 
parent PMCG not being an SMMU, which is supported in the spec as I recall.

Note that I would not have FW to test that, so maybe can omit support 
for now as long as there's no regression.

>>  		iort_enable_acs(iort_node);
>>
>>  		ops = iort_get_dev_cfg(iort_node);
>> @@ -1609,7 +1639,7 @@ static void __init iort_init_platform_devices(void)
>>
>>  			iort_set_fwnode(iort_node, fwnode);
>>
>> -			ret = iort_add_platform_device(iort_node, ops);
>> +			ret = iort_add_platform_device(iort_node, ops, parent);
>
> This function is called if ops is valid, so retrieve the parent
> can be done before this function I think.

Ah, yes

Thanks,
John

>

> Thanks
> Hanjun
>
>
> .
>


