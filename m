Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D80D62DD1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 04:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfGIB65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 21:58:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727165AbfGIB64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:58:56 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C95E01D72EB7A611C55D;
        Tue,  9 Jul 2019 09:58:53 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 9 Jul 2019
 09:58:51 +0800
Subject: Re: [PATCH] scsi: libsas: remove the exporting of sas_wait_eh
To:     Denis Efremov <efremov@linux.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190708164339.14465-1-efremov@linux.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <00489583-ff52-d9b7-5e46-478aa361758e@huawei.com>
Date:   Tue, 9 Jul 2019 09:58:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190708164339.14465-1-efremov@linux.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/9 0:43, Denis Efremov wrote:
> The function sas_wait_eh is declared static and marked
> EXPORT_SYMBOL, which is at best an odd combination. Because the
> function is not used outside of the drivers/scsi/libsas/sas_scsi_host.c
> file it is defined in, this commit removes the EXPORT_SYMBOL() marking.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>   drivers/scsi/libsas/sas_scsi_host.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index ede0674d8399..5564d3f1243a 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -414,7 +414,6 @@ static void sas_wait_eh(struct domain_device *dev)
>   		goto retry;
>   	}
>   }
> -EXPORT_SYMBOL(sas_wait_eh);
>   
>   static int sas_queue_reset(struct domain_device *dev, int reset_type,
>   			   u64 lun, int wait)
> 

Reviewed-by: Jason Yan <yanaijie@huawei.com>

