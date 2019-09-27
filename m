Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 386C8BFC93
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 03:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfI0BAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 21:00:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33484 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfI0BAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 21:00:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B1B241319645B0196D57;
        Fri, 27 Sep 2019 09:00:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Sep 2019
 09:00:44 +0800
Subject: Re: [PATCH] async: Let kfree() out of the critical area of the lock
To:     Bart Van Assche <bvanassche@acm.org>, <dsterba@suse.cz>,
        <bhelgaas@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
        "Alexander Duyck" <alexander.h.duyck@linux.intel.com>,
        <sakari.ailus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <216356b1-38c1-8477-c4e8-03f497dd6ac8@huawei.com>
 <f49df2d42d7e97b61a5e26ff4d89ede5fbe37a35.camel@linux.intel.com>
 <e59af8ae-bacb-2e7e-dd53-ea283960d40e@huawei.com>
 <20190926110648.GM2751@suse.cz>
 <e339db78-413c-446a-8e07-40e6e1ad4a31@acm.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <cadede43-776e-449d-c6e5-c7f9c2c1acf2@huawei.com>
Date:   Fri, 27 Sep 2019 09:00:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e339db78-413c-446a-8e07-40e6e1ad4a31@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/26 23:18, Bart Van Assche wrote:
> On 9/26/19 4:06 AM, David Sterba wrote:
>> On Thu, Sep 26, 2019 at 03:58:36PM +0800, Yunfeng Ye wrote:
>>> The async_lock is big global lock, I think it's good to put kfree() outside
>>> to keep the critical area as short as possible.
>>
>> Agreed, kfree is not always cheap. We had patches in btrfs moving kfree
>> out of critical section(s) after causing softlockups due to increased lock
>> contention.
> 
> The above would be a great addition for the commit description. Anyway:
> 
ok, I will update the description, thanks.

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 
> .
> 

