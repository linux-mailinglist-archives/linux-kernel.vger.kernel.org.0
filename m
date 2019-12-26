Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5504612AC3C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 13:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfLZMgz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Dec 2019 07:36:55 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45203 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfLZMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 07:36:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=gerry@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TlzWwkq_1577363770;
Received: from 127.0.0.1(mailfrom:gerry@linux.alibaba.com fp:SMTPD_---0TlzWwkq_1577363770)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Dec 2019 20:36:14 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
From:   "Liu, Jiang" <gerry@linux.alibaba.com>
In-Reply-To: <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
Date:   Thu, 26 Dec 2019 20:35:25 +0800
Cc:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        mst@redhat.com, Sergio Lopez <slp@redhat.com>,
        virtio-dev@lists.oasis-open.org, jing2.liu@intel.com,
        chao.p.peng@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <C5957AB7-3189-43E2-9187-B5AABEACE21F@linux.alibaba.com>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
 <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 26, 2019, at 4:09 PM, Jason Wang <jasowang@redhat.com> wrote:
> 
> 
> On 2019/12/25 下午11:20, Liu, Jiang wrote:
>> 
>>> On Dec 25, 2019, at 6:20 PM, Jason Wang <jasowang@redhat.com> wrote:
>>> 
>>> 
>>> On 2019/12/25 上午10:50, Zha Bin wrote:
>>>> From: Liu Jiang <gerry@linux.alibaba.com>
>>>> 
>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
>>>> virtio over mmio devices as a lightweight machine model for modern
>>>> cloud. The standard virtio over MMIO transport layer only supports one
>>>> legacy interrupt, which is much heavier than virtio over PCI transport
>>>> layer using MSI. Legacy interrupt has long work path and causes specific
>>>> VMExits in following cases, which would considerably slow down the
>>>> performance:
>>>> 
>>>> 1) read interrupt status register
>>>> 2) update interrupt status register
>>>> 3) write IOAPIC EOI register
>>>> 
>>>> We proposed to update virtio over MMIO to version 3[1] to add the
>>>> following new features and enhance the performance.
>>>> 
>>>> 1) Support Message Signaled Interrupt(MSI), which increases the
>>>>    interrupt performance for virtio multi-queue devices
>>>> 2) Support per-queue doorbell, so the guest kernel may directly write
>>>>    to the doorbells provided by virtio devices.
>>>> 
>>>> The following is the network tcp_rr performance testing report, tested
>>>> with virtio-pci device, vanilla virtio-mmio device and patched
>>>> virtio-mmio device (run test 3 times for each case):
>>>> 
>>>> 	netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>>>> 
>>>> 		Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
>>>> 	trans/s	    9536	6939		9500
>>>> 	trans/s	    9734	7029		9749
>>>> 	trans/s	    9894	7095		9318
>>>> 
>>>> [1] https://lkml.org/lkml/2019/12/20/113
>>> 
>>> Thanks for the patch. Two questions after a quick glance:
>>> 
>>> 1) In PCI we choose to support MSI-X instead of MSI for having extra flexibility like alias, independent data and address (e.g for affinity) . Any reason for not start from MSI-X? E.g having MSI-X table and PBA (both of which looks pretty independent).
>> Hi Jason,
>> 	Thanks for reviewing patches on Christmas Day:)
>> 	The PCI MSI-x has several advantages over PCI MSI, mainly
>> 1) support 2048 vectors, much more than 32 vectors supported by MSI.
>> 2) dedicated address/data for each vector,
>> 3) per vector mask/pending bits.
>> The proposed MMIO MSI extension supports both 1) and 2),
> 
> 
> Aha right, I mis-read the patch. But more questions comes:
> 
> 1) The association between vq and MSI-X vector is fixed. This means it can't work for a device that have more than 2047 queues. We probably need something similar to virtio-pci to allow a dynamic association.
> 2) The mask and unmask control is missed
> 
> 
>>  but the extension doesn’t support 3) because
>> we noticed that the Linux virtio subsystem doesn’t really make use of interrupt masking/unmasking.
> 
> 
> Not directly used but masking/unmasking is widely used in irq subsystem which allows lots of optimizations.
> 
> 
>> 
>> On the other hand, we want to simplify VMM implementations as simple as possible, and mimicking the PCI MSI-x
>> will cause some complexity to VMM implementations.
> 
> 
> I agree to simplify VMM implementation, but it looks to me introducing masking/pending won't cost too much code in the VMM implementation. Just new type of command for VIRTIO_MMIO_MSI_COMMAND.
> 
> Thanks
> 
> 
>> 
>>> 2) It's better to split notify_multiplexer out of MSI support to ease the reviewers (apply to spec patch as well)
>> Great suggestion, we will try to split the patch.
>> 
>> Thanks,
>> Gerry
>> 
>>> Thanks

