Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006D69658A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfHTPvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 11:51:39 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33957 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729827AbfHTPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:51:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ta-xkxy_1566316283;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Ta-xkxy_1566316283)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 23:51:24 +0800
Subject: Re: [PATCH v3 0/3] genirq/vfio: Introduce update_irq_devid and
 optimize VFIO irq ops
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
References: <cover.1565857737.git.luoben@linux.alibaba.com>
 <20190819145150.2d30669b@x1.home>
 <a1a8f8bc-07c0-2304-8550-7c302704fa4e@linux.alibaba.com>
 <20190820092209.0c89effd@x1.home>
From:   luoben <luoben@linux.alibaba.com>
Message-ID: <4b2c76e3-91da-09b6-65f4-535828373c04@linux.alibaba.com>
Date:   Tue, 20 Aug 2019 23:51:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820092209.0c89effd@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/8/20 下午11:22, Alex Williamson 写道:
> On Tue, 20 Aug 2019 12:03:50 +0800
> luoben <luoben@linux.alibaba.com> wrote:
>
>> 在 2019/8/20 上午4:51, Alex Williamson 写道:
>>> On Thu, 15 Aug 2019 21:02:58 +0800
>>> Ben Luo <luoben@linux.alibaba.com> wrote:
>>>   
>>>> Currently, VFIO takes a lot of free-then-request-irq actions whenever
>>>> a VM (with device passthru via VFIO) sets irq affinity or mask/unmask
>>>> irq. Those actions only change the cookie data of irqaction or even
>>>> change nothing. The free-then-request-irq not only adds more latency,
>>>> but also increases the risk of losing interrupt, which may lead to a
>>>> VM hung forever in waiting for IO completion
>>> What guest environment is generating this?  Typically I don't see that
>>> Windows or Linux guests bounce the interrupt configuration much.
>>> Thanks,
>>>
>>> Alex
>> By tracing centos5u8 on host, I found it keep masking and unmasking
>> interrupt like this:
>>
>> [1566032533709879] index:28 irte_hi:000000010004a601
>> irte_lo:adb54bc000b98001
>> [1566032533711242] index:28 irte_hi:0000000000000000
>> irte_lo:0000000000000000
>> [1566032533711258] index:28 irte_hi:000000000004a601
>> irte_lo:00003fff00ac002d
>> [1566032533711269] index:28 irte_hi:000000000004a601
>> irte_lo:00003fff00ac002d
> [snip]
>> "[1566032533720007]" is timestamp in μs, so centos5u8 tiggers 30+ irte
>> modification within 10ms
> Ok, that matches my understanding that only very old guests behave in
> this manner.  It's a curious case to optimize as RHEL5 is in extended
> life-cycle support, with regular maintenance releases ending 2+ years
> ago.  Thanks,
>
> Alex

But repeatedly set interrupt affinity in a new version guest can also 
cause the problem.


Thanks,

     Ben

