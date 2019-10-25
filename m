Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2CE50BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 18:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503928AbfJYQEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 12:04:42 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2055 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393851AbfJYQEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:04:41 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 94AABB4AC11B0F9A709A;
        Fri, 25 Oct 2019 17:04:39 +0100 (IST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 25 Oct 2019 17:04:39 +0100
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 25 Oct
 2019 17:04:39 +0100
Subject: Re: [PATCH 0/6] hisi_sas: Expose multiple hw queues for v3 hw as
 experimental
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <hare@suse.com>,
        <ming.lei@redhat.com>
References: <1571926881-75524-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <dfbee75d-a223-9ff5-db37-16c00a5667bd@huawei.com>
Date:   Fri, 25 Oct 2019 17:04:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1571926881-75524-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2019 15:21, John Garry wrote:
> This series adds support to expose multiple hw queues for SCSI mid-layer
> as an experimental feature.
> 
> For now it is experimental due to known CPU hotplug issue for managed
> interrupts.
> 
> So now we have two module parameters to enable managed interrupts for v3
> hw driver:
> - auto_affine_msi_experimental:
> Use managed interrupts plus and manage reply map internally. Use
> request tag for IPTT (apart from reserved commands).
> - expose_mq_experimental
> Use managed interrupts plus and expose multipe hw queues. Manage IPTT
> internally with sbitmap.
> 
> Paramater auto_affine_msi_experimental shows better performance (than
> expose_mq_experimental), so we need to maintain it for now to stop
> complaints about performance regression (even though enabling this
> parameter is unsafe).
> 
> I want to remove these module parameters ASAP.
> 
> This series also includes a change to convert the driver to use sbitmap
> where possible for managing IPTT.

Hi Martin,

Can we hold off on this series until Ming has had a look?

Thanks,
John

> 
> This series is based on 5.4 + [0], even though being advertised for
> topic-sas-5.4 dev branch. Sorry for send before that is merged, but I just
> wanted to get these posted.
> 
> [0] https://lore.kernel.org/linux-scsi/1571674935-108326-1-git-send-email-john.garry@huawei.com/T/#t
> 
> 
> John Garry (6):
>    scsi: hisi_sas: Use sbitmap for IPTT management
>    scsi: hisi_sas: Pass scsi_cmnd pointer to hisi_sas_hw.slot_index_alloc
>    scsi: hisi_sas: Add bitmaps_alloc_v3_hw()
>    scsi: hisi_sas: Add slot_index_alloc_v3_hw() and
>      slot_index_free_v3_hw()
>    scsi: hisi_sas: Split interrupt_init_v3_hw()
>    scsi: hisi_sas: Expose multiple hw queues for v3 as experimental
> 
>   drivers/scsi/hisi_sas/hisi_sas.h       |  12 ++-
>   drivers/scsi/hisi_sas/hisi_sas_main.c  | 135 ++++++++++++-------------
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 110 +++++++++++++-------
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 100 ++++++++++++++++--
>   4 files changed, 242 insertions(+), 115 deletions(-)
> 

