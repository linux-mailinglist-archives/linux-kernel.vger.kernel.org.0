Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6217D12EA14
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 19:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgABSvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 13:51:31 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18446 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgABSvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 13:51:31 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0e3ba20000>; Thu, 02 Jan 2020 10:51:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 Jan 2020 10:51:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 Jan 2020 10:51:30 -0800
Received: from [10.19.66.63] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jan
 2020 18:51:27 +0000
Subject: Re: [PATCH V1] nvmem: core: fix memory abort in cleanup path
To:     Thierry Reding <treding@nvidia.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <1577592162-14817-1-git-send-email-bbiswas@nvidia.com>
 <20200102124445.GB1924669@ulmo>
From:   Bitan Biswas <bbiswas@nvidia.com>
Message-ID: <7abb79c6-b497-98b3-45ff-44d751f1c781@nvidia.com>
Date:   Thu, 2 Jan 2020 10:51:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200102124445.GB1924669@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577991075; bh=LKWul6VuIcqOmJe2hTl+48jJBrbC7VDeo7XRKHTaOJ0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BLJ//U7liEBkIdDIa89X8zJh1f6ilvsj5JxAq+u9GmX9K7/A/+Z+IOt+HfmTdsqaK
         Nwmw6U+dEUE9kC3rDRAxMfY7E0kyqEWITj03tbz5nP3qG9IBNdMiXsnHPznsSyPkKu
         RBAgUg4jsiWqinQpU4PrYYGZjjrgcOFykvpUr/qU5cSaSWd87BxlZX2aleVfNamuMX
         jX9MgkKrolkg15/scLbQI2kbjBM2FukdWyE6FMCYUdXW8/Q6KaSDBDs0DMZYvuftHJ
         CRosZkrSv2aOd+0eDKOYpvfy6P9o41fteIhflElFLdcT5eCaQD4RpbVnSQFH/CqK6u
         b7J4NbfFJIHjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thierry,

On 1/2/20 4:44 AM, Thierry Reding wrote:
> On Sat, Dec 28, 2019 at 08:02:42PM -0800, Bitan Biswas wrote:
>> nvmem_cell_info_to_nvmem_cell implementation has static
>> allocation of name. nvmem_add_cells_from_of() call may
>> return error and kfree name results in memory abort. Use
>> kasprintf() instead of assigning pointer and prevent kfree crash.
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 9f1ee9c..0fc66e1 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -110,7 +110,7 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
>>   	cell->nvmem = nvmem;
>>   	cell->offset = info->offset;
>>   	cell->bytes = info->bytes;
>> -	cell->name = info->name;
>> +	cell->name = kasprintf(GFP_KERNEL, "%s", info->name);

> 
> kstrdup() seems more appropriate here.
Thanks. I shall update the patch as suggested.

> 
> A slightly more efficient way to do this would be to use a combination
> of kstrdup_const() and kfree_const(), which would allow read-only
> strings to be replicated by simple assignment rather than duplication.
> Note that in that case you'd need to carefully replace all kfree() calls
> on cell->name by a kfree_const() to ensure they do the right thing.
kfree(cell->name) is also called for allocations in function 
nvmem_add_cells_from_of() through below call
kasprintf(GFP_KERNEL, "%pOFn", child);

My understanding is kfree_const may not work for above allocation.



-regards,
  Bitan

