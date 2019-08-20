Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9ED96704
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfHTQ7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 12:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfHTQ7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:59:48 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B216A230F2;
        Tue, 20 Aug 2019 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566320387;
        bh=ik14s5ncZPpawrYkN/QPJAA/kazm4JWFagMR3npL3hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVh96cBmW+tGmEb8bxsgXsaSScx3Asg+kpT9Vi7Qrrx2ZEQqBizZiMZEsr0+8tGDO
         PfiwpnrM1CtgUmD4KX1fIEgrQl5JLyUHd3KwXC3MsJsD59hL0D/bkTzRxWIJ349SEY
         WH759tWdk1iftouLk+OGPZtEi+GduwMzDdUnucP8=
Date:   Tue, 20 Aug 2019 09:59:47 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhangfei <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190820165947.GC3736@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815141351.GD23267@kroah.com>
 <6daab785-a8f9-684e-eb71-7a81604d3bb0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6daab785-a8f9-684e-eb71-7a81604d3bb0@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 09:08:55PM +0800, zhangfei wrote:
> 
> 
> On 2019/8/15 下午10:13, Greg Kroah-Hartman wrote:
> > On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> > > +int uacce_register(struct uacce *uacce)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!uacce->pdev) {
> > > +		pr_debug("uacce parent device not set\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	if (uacce->flags & UACCE_DEV_NOIOMMU) {
> > > +		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> > > +		dev_warn(uacce->pdev,
> > > +			 "Register to noiommu mode, which export kernel data to user space and may vulnerable to attack");
> > > +	}
> > THat is odd, why even offer this feature then if it is a major issue?
> UACCE_DEV_NOIOMMU maybe confusing here.
> 
> In this mode, app use ioctl to get dma_handle from dma_alloc_coherent.

That's odd, why not use the other default apis to do that?

> It does not matter iommu is enabled or not.
> In case iommu is disabled, it maybe dangerous to kernel, so we added warning here, is it required?

You should use the other documentated apis for this, don't create your
own.

thanks,

greg k-h
