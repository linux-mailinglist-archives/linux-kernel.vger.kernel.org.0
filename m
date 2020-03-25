Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D40F192200
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 08:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCYHyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 03:54:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbgCYHyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:54:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DD25C3C7575C8B8A45B8;
        Wed, 25 Mar 2020 15:54:02 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Mar 2020
 15:53:52 +0800
Subject: Re: [PATCH] mtd:Fix issue where write_cached_data() fails but write()
 still returns success
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zhangweimin12@huawei.com>, <wangle6@huawei.com>
References: <1584674111-101462-1-git-send-email-nixiaoming@huawei.com>
 <20200324230620.174db1a7@xps13>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <b37235a2-d949-7f78-770b-4a69d9d7aaaa@huawei.com>
Date:   Wed, 25 Mar 2020 15:53:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200324230620.174db1a7@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/25 6:06, Miquel Raynal wrote:
> Hi Xiaoming,
> 
> Xiaoming Ni <nixiaoming@huawei.com> wrote on Fri, 20 Mar 2020 11:15:11
> +0800:
> 
>> mtdblock_flush()
>> 	-->write_cached_data()
>> 		--->erase_write()
>> 		     mtdblock: erase of region [0x40000, 0x20000] on "xxx" failed
>>
>> Because mtdblock_flush() always returns 0,
>> even if write_cached_data() fails and data is not written to the device,
>> syscall_write() still returns success
> 
> I reworded a bit the commit log and also added a ' ' after 'mtd:' in
> the title when applying.
> 
> Thanks,
> Miquèl

Your revised commit log is more accurate and clearer, thanks for your 
correction
Thanks.
Xiaoming Ni


