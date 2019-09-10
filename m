Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A477AE704
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 11:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbfIJJbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 05:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731426AbfIJJbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:31:17 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B97D20863;
        Tue, 10 Sep 2019 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568107877;
        bh=ByHxJweeMie6TMOS1XtfpI2Bl4aY7AzmSS2JVGOncCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlpXTHURU+b85uwVk+RwfKzay7X+Gc7jBTE/BAWRTFvBA+Myr9Aa8r32CoK+QVtz/
         JLbqRI7zKn49ebbbkeaOcJ/7TN0d4rQLGCMG/QOQedWfGSLN5N/laSoSv+6HOu7yyg
         JM23S7oi3T8AmryTgRI8l8KjG3Ju5IU0uTfWGA1k=
Date:   Tue, 10 Sep 2019 10:31:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, mhocko@kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190910093114.GA19821@kroah.com>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909095347.GB6314@kroah.com>
 <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 02:43:32PM +0800, Yunsheng Lin wrote:
> On 2019/9/9 17:53, Greg KH wrote:
> > On Mon, Sep 09, 2019 at 02:04:23PM +0800, Yunsheng Lin wrote:
> >> Currently a device does not belong to any of the numa nodes
> >> (dev->numa_node is NUMA_NO_NODE) when the node id is neither
> >> specified by fw nor by virtual device layer and the device has
> >> no parent device.
> > 
> > Is this really a problem?
> 
> Not really.
> Someone need to guess the node id when it is not specified, right?

No, why?  Guessing guarantees you will get it wrong on some systems.

Are you seeing real problems because the id is not being set?  What
problem is this fixing that you can actually observe?

thanks,

greg k-h
