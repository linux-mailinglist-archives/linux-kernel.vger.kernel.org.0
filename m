Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E983013ACCF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 15:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgANO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 09:59:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANO7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:59:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35DDA222C4;
        Tue, 14 Jan 2020 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579013977;
        bh=JsWfRq3X3gD6BI5Jjp77gShsE9xbLIe4k4ACCqlIDUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUh8clVtpbFL6PQgYE4wIm+2XEKpZn2NscpzUMxJZsQAdvIISnx5yHyocs6hXUN9C
         GGVkxtTHDzTHhgMuycAWt+4/A9wOFUGhZxM+JkceSC3lzD1GJovA1TP3c0IB6YMRP2
         dd736FW18wIbuSp2jizlxsiVLT0vY2P1Aq5uAsE0=
Date:   Tue, 14 Jan 2020 15:59:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhangfei <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: Re: [PATCH v11 2/4] uacce: add uacce driver
Message-ID: <20200114145934.GA1960403@kroah.com>
References: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
 <1578710919-12141-3-git-send-email-zhangfei.gao@linaro.org>
 <20200111194006.GD435222@kroah.com>
 <053ccd05-4f11-5be6-47c2-eee5c2f1fdc4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <053ccd05-4f11-5be6-47c2-eee5c2f1fdc4@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:34:55AM +0800, zhangfei wrote:
> Hi, Greg
> 
> Thanks for the review.
> 
> On 2020/1/12 上午3:40, Greg Kroah-Hartman wrote:
> > On Sat, Jan 11, 2020 at 10:48:37AM +0800, Zhangfei Gao wrote:
> > > +static int uacce_fops_open(struct inode *inode, struct file *filep)
> > > +{
> > > +	struct uacce_mm *uacce_mm = NULL;
> > > +	struct uacce_device *uacce;
> > > +	struct uacce_queue *q;
> > > +	int ret = 0;
> > > +
> > > +	uacce = xa_load(&uacce_xa, iminor(inode));
> > > +	if (!uacce)
> > > +		return -ENODEV;
> > > +
> > > +	if (!try_module_get(uacce->parent->driver->owner))
> > > +		return -ENODEV;
> > Why are you trying to grab the module reference of the parent device?
> > Why is that needed and what is that going to help with here?
> > 
> > This shouldn't be needed as the module reference of the owner of the
> > fileops for this module is incremented, and the "parent" module depends
> > on this module, so how could it be unloaded without this code being
> > unloaded?
> > 
> > Yes, if you build this code into the kernel and the "parent" driver is a
> > module, then you will not have a reference, but when you remove that
> > parent driver the device will be removed as it has to be unregistered
> > before that parent driver can be removed from the system, right?
> > 
> > Or what am I missing here?
> The refcount here is preventing rmmod "parent" module after fd is opened,
> since user driver has mmap kernel memory to user space, like mmio, which may
> still in-use.
> 
> With the refcount protection, rmmod "parent" module will fail until
> application free the fd.
> log like: rmmod: ERROR: Module hisi_zip is in use

But if the "parent" module is to be unloaded, it has to unregister the
"child" device and that will call the destructor in here and then you
will tear everything down and all should be good.

There's no need to "forbid" a module from being unloaded, even if it is
being used.  Look at all networking drivers, they work that way, right?

> > > +static void uacce_release(struct device *dev)
> > > +{
> > > +	struct uacce_device *uacce = to_uacce_device(dev);
> > > +
> > > +	kfree(uacce);
> > > +	uacce = NULL;
> > That line didn't do anything :)
> Yes, this is a mistake.
> It is up to caller to set to NULL to prevent release multi times.

Release function is called by the driver core which will not touch the
value again.

thanks,

greg k-h
