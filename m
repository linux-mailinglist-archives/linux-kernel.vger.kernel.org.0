Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 026D0A7AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 07:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfIDFpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 01:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfIDFpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:45:44 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EAA62089F;
        Wed,  4 Sep 2019 05:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567575943;
        bh=sIdRxjWonCnVUCMb6786X+EVPlTc/30bShqQftNt7wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcvJJmbc9ZDfyIH6wpK/4/FwWz3Q0Hs5Zy7Topm9SGxejyz9872WXxKAWYCtl42oS
         CJr13LTkS8pI/OSYxEKmBQi/46UJ21XDbjvGThcQj12HWHBcXjyBqdcc028JqUlGjU
         wYJb551uYTbaIYI/WpUnPSuCbtQBhf3NkG8wuoYI=
Date:   Wed, 4 Sep 2019 11:14:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.co>
Subject: Re: [PATCH] dma: iop-adma.c: fix printk format warning
Message-ID: <20190904054433.GB2672@vkoul-mobl>
References: <1803541f-98a6-7cce-b050-ff1e9a333ab2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1803541f-98a6-7cce-b050-ff1e9a333ab2@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-09-19, 22:06, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix printk format warning in iop-adma.c (seen on x86_64) by using
> %pad:
> 
> ../drivers/dma/iop-adma.c:118:12: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 6 has type ‘dma_addr_t {aka long long unsigned int}’ [-Wformat=]

Applied, thanks

-- 
~Vinod
