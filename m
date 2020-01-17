Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAFAF140C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAQOGX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jan 2020 09:06:23 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:41037 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgAQOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:06:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=gerry@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TnywUgP_1579269963;
Received: from 127.0.0.1(mailfrom:gerry@linux.alibaba.com fp:SMTPD_---0TnywUgP_1579269963)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Jan 2020 22:06:08 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 1/2] x86/msi: Enhance x86 to support platform_msi
From:   "Liu, Jiang" <gerry@linux.alibaba.com>
In-Reply-To: <874kwu2nih.fsf@nanos.tec.linutronix.de>
Date:   Fri, 17 Jan 2020 22:06:01 +0800
Cc:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        slp@redhat.com, virtio-dev@lists.oasis-open.org,
        jing2.liu@intel.com, chao.p.peng@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <80399081-6B8F-405D-BD6B-572206F0CCEB@linux.alibaba.com>
References: <874kwu2nih.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2020, at 9:58 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> Zha Bin <zhabin@linux.alibaba.com> writes:
> 
>> From: Liu Jiang <gerry@linux.alibaba.com>
>> 
>> The x86 platform currently only supports specific MSI/MSI-x for PCI
>> devices. To enable MSI to the platform devices such as virtio-mmio
>> device, this patch enhances x86 with platform MSI by leveraging the
>> already built-in platform-msi driver (drivers/base/platform-msi.c)
>> and makes it as a configurable option.
> 
> Why are you trying to make this an architecture feature instead of
> having a generic implementation which can work on all architectures
> which support virtio-mmio?
Thanks, Thomas!
We are reworking to implement it as a generic irqdomain for all virtio MMIO devices.

> 
>> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
>> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> 
> This Signed-off-by chain is invalid.
> 
> Thanks,
> 
>        tglx

