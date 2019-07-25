Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5674E57
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 14:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbfGYMlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 08:41:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbfGYMln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Wjp5H7m0b0vMT7USOlYqcUzNgRanEqvXTqhheDAilA=; b=rKY91dce2li+C2U57/tnASrA2
        47Bd6vgLifnqq1zIETijL3aVlqmAoTd3GaCod8NXW4hm9y6l5qJpdTcG9p1UpWjEwdY4EainApIzD
        xsC761C1zsnE82N1Ztnh0J74oQX5LHcQMGM1dM3iqpLqaLEvz3T07kLYVhxHSSccZa6teJKSETpAE
        a4ZlIZEqbMB+4fXaA87xcrwx4prSssxpfIEdtfbJ4vFGVhm7YPr4dNUlNfStWc/ZFtGaAASxR5CWD
        7VS8kKIdprjJdq0aM8Iv4ZdirfThvVKuRC3xIlIwjkcBnVuB4Tg6husLf/f3KmhcJ0bqTQ6FmDmfA
        y1v4B5wZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqd42-0006dB-AA; Thu, 25 Jul 2019 12:41:42 +0000
Date:   Thu, 25 Jul 2019 05:41:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Rob Clark <robdclark@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>
Subject: Re: [PATCH v6 2/5] dma-buf: heaps: Add heap helpers
Message-ID: <20190725124142.GA20286@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-3-john.stultz@linaro.org>
 <20190718100654.GA19666@infradead.org>
 <CALAqxLX1s4mbitE-_1s1vFPJrbrCKqpyhYoFW0V6hMEqE=eKVw@mail.gmail.com>
 <CAF6AEGuM1+pimGNhyKHbYR0BdH=hH+Sai0es8RjGHE9jKHjngw@mail.gmail.com>
 <20190724065530.GA16225@infradead.org>
 <3966dff1-864d-cad4-565f-7c7120301265@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3966dff1-864d-cad4-565f-7c7120301265@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:20:31AM -0400, Andrew F. Davis wrote:
> Well then lets think on this. A given buffer can have 3 owners states
> (CPU-owned, Device-owned, and Un-owned). These are based on the caching
> state from the CPU perspective.
> 
> If a buffer is CPU-owned then we (Linux) can write to the buffer safely
> without worry that the data is stale or that it will be accessed by the
> device without having been flushed. Device-owned buffers should not be
> accessed by the CPU, and inter-device synchronization should be handled
> by fencing as Rob points out. Un-owned is how a buffer starts for
> consistency and to prevent unneeded cache operations on unwritten buffers.

CPU owned also needs to be split into which mapping owns it - in the
normal DMA this is the kernel direct mapping, but in dma-buf it seems
the primary way of using it in kernel space is the vmap, in addition
to that the mappings can also be exported to userspace, which is another
mapping that is possibly not cache coherent with the kernel one.
