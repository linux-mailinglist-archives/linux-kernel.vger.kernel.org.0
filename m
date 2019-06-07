Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6AD38BA6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfFGNaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 09:30:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18097 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728019AbfFGNaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:30:00 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C4E4424121957BF78DDF;
        Fri,  7 Jun 2019 21:29:57 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Jun 2019
 21:29:51 +0800
Subject: Re: [PATCH] scsi: libsas, lldds: Use dev_is_expander()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1559751143-168560-1-git-send-email-john.garry@huawei.com>
 <yq1k1dymkyh.fsf@oracle.com> <yq1v9xhjzl9.fsf@oracle.com>
CC:     <jejb@linux.ibm.com>, <intel-linux-scu@intel.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@profitbricks.com>,
        <lindar_liu@usish.com>, <yanaijie@huawei.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fcc8598c-00c7-52be-3bb3-5296c825658a@huawei.com>
Date:   Fri, 7 Jun 2019 14:29:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq1v9xhjzl9.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2019 14:26, Martin K. Petersen wrote:
>
> John,
>
>>> Many times in libsas, and in LLDDs which use libsas, the check for an
>>> expander device is re-implemented or open coded.
>>
>> Applied to 5.3/scsi-queue, thanks.
>
> Dropped again. Breaks isci. Please fix.
>

Hi Martin,

I assume that you mean that it breaks the isci build. I thought that I 
did build it. Anyway, I'll check.

Thanks,
john



