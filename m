Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2D18EF16
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbfHOPKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 11:10:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37907 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfHOPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:10:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id u190so2090646qkh.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xzO7Mshohtsh0MjNCwtfvdaSBmY8e4joFkYT0O9y2JI=;
        b=lI3y7R44OI9cE4EW3AD4mdCTJlQwdhtFMnFulkuEqvQdz88hWBkf/Luz9A97zWh1WM
         6VlnHYIeU9yHzN5gLW2s6pZtC53ZcoK+QYnLyrm71HqORWm7eDtaZclaBxKxBqoBfR6a
         wQh2bKmRFu8C01tUVSEPeeZYrB6Zf+XdIvZRedLH4G7bY1xFFrYAoyZPI6cM+2j3i+UD
         ekO1QrzYXDSKJKdF9J3udmvIveoENdrM4omYutvyVHhrkIapI79MBHNcmw35rsWFNK76
         65B13pG5zrwaNbu2GbqZZmb2GB6hh98QSz3unRjRNSzvxzUILwBIuF3oriB53wVaSEzR
         S8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xzO7Mshohtsh0MjNCwtfvdaSBmY8e4joFkYT0O9y2JI=;
        b=KjhJoniRUc48ma+61TygWzaiAupIvcQWFkTGEXbM+7AD5+3cPuoMmrAbeWEIHXanHC
         lsKp12bs6+oaUZ0XD26ZhtumheugfdEPRcNsqakp/JGDdfoEXMN2sxC3PdnV27PYdUs/
         E5YOH2A1+Did15QKdjQpEZ8VYibTT0uTIasPDLEPYSN3OjR/dTOlva9cNeGgj49MjwO6
         m2dUvzd4hveKwPXyRHT2Akvxi9kDuIsBdX8ZMgal2HnKXLVDOMq9TATWDeltqp/tO/KQ
         ipX2MerSUJH0tBAt9cb1q9eJdQvsV6wIHTYuvhkwGruu6O0kSnwAVEWt3a3TOS1CraPC
         Bakg==
X-Gm-Message-State: APjAAAWk6H/8Y8PxRQ8ZfvjpH4xgM9BmG5qHhpZ8mvzv2u6NggZw3idH
        jWj0i1AVooLtCjc0jFOyEYFp3A==
X-Google-Smtp-Source: APXvYqwzfXMAsx+TimK2Wq4Er/PrNLigk2R/e9axAwMI+6uwPMqruXjP4qCNTiLEsTwOHrOMXcfSYA==
X-Received: by 2002:a37:aa88:: with SMTP id t130mr4635639qke.12.1565881829208;
        Thu, 15 Aug 2019 08:10:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i62sm1568446qke.52.2019.08.15.08.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 08:10:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyHOW-0005WZ-AT; Thu, 15 Aug 2019 12:10:28 -0300
Date:   Thu, 15 Aug 2019 12:10:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190815151028.GJ21596@ziepe.ca>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-3-daniel.vetter@ffwll.ch>
 <20190814134558.fe659b1a9a169c0150c3e57c@linux-foundation.org>
 <20190815084429.GE9477@dhcp22.suse.cz>
 <20190815130415.GD21596@ziepe.ca>
 <CAKMK7uE9zdmBuvxa788ONYky=46GN=5Up34mKDmsJMkir4x7MQ@mail.gmail.com>
 <20190815143759.GG21596@ziepe.ca>
 <CAKMK7uEJQ6mPQaOWbT_6M+55T-dCVbsOxFnMC6KzLAMQNa-RGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEJQ6mPQaOWbT_6M+55T-dCVbsOxFnMC6KzLAMQNa-RGg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 04:43:38PM +0200, Daniel Vetter wrote:

> You have to wait for the gpu to finnish current processing in
> invalidate_range_start. Otherwise there's no point to any of this
> really. So the wait_event/dma_fence_wait are unavoidable really.

I don't envy your task :|

But, what you describe sure sounds like a 'registration cache' model,
not the 'shadow pte' model of coherency.

The key difference is that a regirstationcache is allowed to become
incoherent with the VMA's because it holds page pins. It is a
programming bug in userspace to change VA mappings via mmap/munmap/etc
while the device is working on that VA, but it does not harm system
integrity because of the page pin.

The cache ensures that each initiated operation sees a DMA setup that
matches the current VA map when the operation is initiated and allows
expensive device DMA setups to be re-used.

A 'shadow pte' model (ie hmm) *really* needs device support to
directly block DMA access - ie trigger 'device page fault'. ie the
invalidate_start should inform the device to enter a fault mode and
that is it.  If the device can't do that, then the driver probably
shouldn't persue this level of coherency. The driver would quickly get
into the messy locking problems like dma_fence_wait from a notifier.

It is important to identify what model you are going for as defining a
'registration cache' coherence expectation allows the driver to skip
blocking in invalidate_range_start. All it does is invalidate the
cache so that future operations pick up the new VA mapping.

Intel's HFI RDMA driver uses this model extensively, and I think it is
well proven, within some limitations of course.

At least, 'registration cache' is the only use model I know of where
it is acceptable to skip invalidate_range_end.

Jason
