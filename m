Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D2960591
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfGELt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 07:49:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34112 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGELt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MnDS828v/2vRSZdCCvSvB68MtPRTzNjF7AtDIX61mDQ=; b=RjzciPUCuY7PxiOgfr28PhK4j
        g9VVWePCxtpJm2lpWr8f5xQIympzlYuIKN2mkfZm6ioGReWyPBO7xRR4QRO2h2UGKSxEJNtWM74oG
        X+4L2lfE/Nko4Ab7v8LiNSX1JdhvXDuTp4Bf2Lo91oU9Ndabxe5zOYsEchsIImuYGqIJyu9XNl2DG
        kzT5wuTQ/0t0VbiMGrA+1fHFb0266FZmM7QrkFDEor6mX2KdqDtCkygclWNpYTc3xTJiqh4zQI2e4
        sG0Rrv6ue6G86etxZlnxVliP1/0HhYldR0s+gg3tWz/mw3gCRU3C4Pbi+MKH6BuAbxee4ox6XsFAp
        iLj2ejbeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjMiK-0001Rj-Q4; Fri, 05 Jul 2019 11:49:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C8772026E806; Fri,  5 Jul 2019 13:48:45 +0200 (CEST)
Date:   Fri, 5 Jul 2019 13:48:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn
Subject: Re: [PATCH v2] sched: fix unlikely use of sched_info_on()
Message-ID: <20190705114845.GS3402@hirez.programming.kicks-ass.net>
References: <1562301307-43002-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562301307-43002-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 12:35:07PM +0800, Yi Wang wrote:
> sched_info_on() is called with unlikely hint, however, the test
> is to be a constant(1) on which compiler will do nothing when
> make defconfig, so remove the hint.
> 
> Also, fix a lack of {}.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

Thanks!
