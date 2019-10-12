Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC1D4C39
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 04:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfJLCts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 22:49:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727072AbfJLCts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 22:49:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9FE7F4877BBA4613FA4E;
        Sat, 12 Oct 2019 10:49:46 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sat, 12 Oct 2019
 10:49:45 +0800
Message-ID: <5DA13F48.4010406@huawei.com>
Date:   Sat, 12 Oct 2019 10:49:44 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <Jerome.Pouiller@silabs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2] staging: wfx: fix an undefined reference error
 when CONFIG_MMC=m
References: <1570811647-64905-1-git-send-email-zhongjiang@huawei.com> <20191011170331.GA1296994@kroah.com>
In-Reply-To: <20191011170331.GA1296994@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/12 1:03, Greg KH wrote:
> On Sat, Oct 12, 2019 at 12:34:07AM +0800, zhong jiang wrote:
>> I hit the following error when compile the kernel.
>>
>> drivers/staging/wfx/main.o: In function `wfx_core_init':
>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: undefined reference to `sdio_register_driver'
>> drivers/staging/wfx/main.o: In function `wfx_core_exit':
>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: undefined reference to `sdio_unregister_driver'
>> drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to `sdio_register_driver'
>> drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to `sdio_unregister_driver'
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/staging/wfx/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> What changed from v1?  Always put that below the --- line.
>
> v3 please?
Fine,  I will repost in v3.  Thanks,

Sincerely,
zhong jiang
> thanks,
>
> greg k-h
>
> .
>


