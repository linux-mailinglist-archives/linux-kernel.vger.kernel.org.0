Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9A833D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbfHFOTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 10:19:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731893AbfHFOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t3He93DMVGN+7dmewZk5rgfn0l4eS5AS/qzZtAZtj/w=; b=EUM2f5eW4a05uib/sx0i00Dr4
        UZmtQLUmjUEUiAkN7pKU7/plhCoACVKZ6ex8sCrIJgDcgRXTfQmIj3wBmj6LVak0l97dS0tZ+NL2U
        CQPYoRP6u6Dgvuj40A756qkOrCvb4EQgcuWQM+8/JzDhc1pShkgEzMEIP1Qmjktkb/mJrcuPbox3V
        aC0DjQuRJ2+hmHs7cnYMDjeqIVoKSqYy/xRw1qdhWp2+HrYV2FNqDUa08o7hhNMV73PdAgWBBPOfF
        fIjm1t0RJjKeJmPBVfj303lxp0KPEBCLMgtj2mtOs20SP9URuoFs3IjVHaz9deVlVYaHABBDqVLyx
        unziOQyyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv0JA-0008A5-3B; Tue, 06 Aug 2019 14:19:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE1BD307145;
        Tue,  6 Aug 2019 16:18:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D9E4201B4BAB; Tue,  6 Aug 2019 16:19:22 +0200 (CEST)
Date:   Tue, 6 Aug 2019 16:19:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     mingo@redhat.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        bobo.shaobowang@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: decrease rq->nr_uninterruptible before
 set_task_cpu
Message-ID: <20190806141922.GT2332@hirez.programming.kicks-ass.net>
References: <1565100770-110193-1-git-send-email-cj.chengjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565100770-110193-1-git-send-email-cj.chengjian@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 10:12:50PM +0800, Cheng Jian wrote:
> Migration may occur when wake up a process, so we must update
> the rq->nr_uninterruptible before set_task_cpu, otherwise we
> will decrease the nr_interuptible of the incorrect rq. Over
> time, it cause some rq accounting according to be too large,
> but others are negative.
> 
> Also change the type of rq->nr_uninterruptible to atomic_t.

NAK. Also there is no actual problem description there.
