Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6897FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfHUQFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 12:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbfHUQFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:05:46 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D533C22D6D;
        Wed, 21 Aug 2019 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566403545;
        bh=TSiJc6Itq1ISqr1k1Zf70a5jFa8tEJy/SjqWstka1LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLNIsTKw1fQ5EnHWm0pVCVckap1nkHg4mhFJlnPCnYVnUmLZ4V9CO2PKod6cJdFvc
         VIqkp/HkEiZ1393V5uen5aKnv+ivYPVC2oJU3ykkjyJ8luziQxwpcL41geUMG2TGFT
         MFLwMSJqoi8iHl19x32ek/upHoIFxI1gqXWKHHgE=
Date:   Wed, 21 Aug 2019 09:05:42 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhangfei <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190821160542.GA14760@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815141351.GD23267@kroah.com>
 <6daab785-a8f9-684e-eb71-7a81604d3bb0@linaro.org>
 <20190820165947.GC3736@kroah.com>
 <5d5cf0fc.1c69fb81.ec57f.b853SMTPIN_ADDED_BROKEN@mx.google.com>
 <20190821091709.GA22914@kroah.com>
 <b88abb8d-50a9-b29e-d3e5-96cc585ecac4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b88abb8d-50a9-b29e-d3e5-96cc585ecac4@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 10:30:22PM +0800, zhangfei wrote:
> 
> 
> On 2019/8/21 下午5:17, Greg Kroah-Hartman wrote:
> > On Wed, Aug 21, 2019 at 03:21:18PM +0800, zhangfei.gao@foxmail.com wrote:
> > > Hi, Greg
> > > 
> > > On 2019/8/21 上午12:59, Greg Kroah-Hartman wrote:
> > > > On Tue, Aug 20, 2019 at 09:08:55PM +0800, zhangfei wrote:
> > > > > On 2019/8/15 下午10:13, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> > > > > > > +int uacce_register(struct uacce *uacce)
> > > > > > > +{
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	if (!uacce->pdev) {
> > > > > > > +		pr_debug("uacce parent device not set\n");
> > > > > > > +		return -ENODEV;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	if (uacce->flags & UACCE_DEV_NOIOMMU) {
> > > > > > > +		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> > > > > > > +		dev_warn(uacce->pdev,
> > > > > > > +			 "Register to noiommu mode, which export kernel data to user space and may vulnerable to attack");
> > > > > > > +	}
> > > > > > THat is odd, why even offer this feature then if it is a major issue?
> > > > > UACCE_DEV_NOIOMMU maybe confusing here.
> > > > > 
> > > > > In this mode, app use ioctl to get dma_handle from dma_alloc_coherent.
> > > > That's odd, why not use the other default apis to do that?
> > > > 
> > > > > It does not matter iommu is enabled or not.
> > > > > In case iommu is disabled, it maybe dangerous to kernel, so we added warning here, is it required?
> > > > You should use the other documentated apis for this, don't create your
> > > > own.
> > > I am sorry, not understand here.
> > > Do you mean there is a standard ioctl or standard api in user space, it can
> > > get dma_handle from dma_alloc_coherent from kernel?
> > There should be a standard way to get such a handle from userspace
> > today.  Isn't that what the ion interface does?  DRM also does this, as
> > does UIO I think.
> Thanks Greg,
> Still not find it, will do more search.
> But this may introduce dependency in our lib, like depend on ion?
> > Do you have a spec somewhere that shows exactly what you are trying to
> > do here, along with example userspace code?  It's hard to determine it
> > given you only have one "half" of the code here and no users of the apis
> > you are creating.
> > 
> The purpose is doing dma in user space.

Oh no, please no.  Are you _SURE_ you want to do this?

Again, look at how ION does this and how the DMAbuff stuff is replacing
it.  Use that api please instead, otherwise you will get it wrong and we
don't want to duplicate efforts.

thanks,

greg k-h
