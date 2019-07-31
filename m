Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4E87C0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfGaMKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:10:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfGaMKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:10:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1A25B41E2D691E92CF1D;
        Wed, 31 Jul 2019 20:10:48 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 20:10:40 +0800
Subject: Re: [PATCH 08/22] staging: erofs: kill CONFIG_EROFS_FS_IO_MAX_RETRIES
To:     Gao Xiang <gaoxiang25@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-9-gaoxiang25@huawei.com>
 <1c979e3f-54ec-cce8-650c-39e060e72169@huawei.com>
 <2d7abbad-61d0-df2b-6a42-26f2606d775a@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <985b3ca7-afee-006e-a367-98a865995246@huawei.com>
Date:   Wed, 31 Jul 2019 20:10:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2d7abbad-61d0-df2b-6a42-26f2606d775a@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On 2019/7/31 15:11, Gao Xiang wrote:
> Hi Chao,
> 
> On 2019/7/31 15:05, Chao Yu wrote:
>> On 2019/7/29 14:51, Gao Xiang wrote:
>>> CONFIG_EROFS_FS_IO_MAX_RETRIES seems a runtime setting
>>> and users have no idea about the change in behaviour.
>>>
>>> Let's remove the setting currently and fold it into code,
>>> turn it into a module parameter if it's really needed.
>>>
>>> Suggested-by: David Sterba <dsterba@suse.cz>
>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>
>> It's fine to me, but I'd like to suggest to add this as a sys entry which can be
>> more flexible for user to change.
> 
> I think it can be added in the later version, the original view
> from David is that he had question how users using this option.
> 
> Maybe we can use the default value and leave it to users who
> really need to modify this value (real requirement).

I think we need to decide it in this version, otherwise it may face backward
compatibility issue if we change module argument to sys entry later.

Maybe just leave it as an fixed macro is fine, since there is actually no
requirement on this.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks
>>
> .
> 
