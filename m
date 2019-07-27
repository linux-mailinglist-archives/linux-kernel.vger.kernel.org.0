Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB087759C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 03:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfG0Bde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 21:33:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726571AbfG0Bdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 21:33:33 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 20E38F91DBEA4105D4E7;
        Sat, 27 Jul 2019 09:33:31 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Jul 2019
 09:33:29 +0800
Subject: Re: [PATCH v2 -next] staging: vc04_services: fix
 used-but-set-variable warning
To:     Stefan Wahren <wahrenst@gmx.net>, <eric@anholt.net>,
        <gregkh@linuxfoundation.org>, <inf.braun@fau.de>,
        <nishkadg.linux@gmail.com>
References: <20190725142716.49276-1-yuehaibing@huawei.com>
 <20190726092621.27972-1-yuehaibing@huawei.com>
 <229b2d16-9623-6005-2e1b-4d1f239643a2@gmx.net>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <25f56fd6-17b7-a8aa-6a51-97677eb8785f@huawei.com>
Date:   Sat, 27 Jul 2019 09:33:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <229b2d16-9623-6005-2e1b-4d1f239643a2@gmx.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/26 23:57, Stefan Wahren wrote:
> Hi Yue,
> 
> Am 26.07.19 um 11:26 schrieb YueHaibing:
>> Fix gcc used-but-set-variable warning:
> 
> just a nit. It is call "unused-but-set-variable"

Oh, yes, thanks!

> 
> Acked-by: Stefan Wahren <wahrenst@gmx.net>
> 
>>
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function vchiq_release_internal:
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:16: warning:
>>  variable local_entity_uc set but not used [-Wunused-but-set-variable]
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:6: warning:
>>  variable local_uc set but not used [-Wunused-but-set-variable]
>>
>> Remove the unused variables 'local_entity_uc' and 'local_uc'
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
> 
> .
> 

