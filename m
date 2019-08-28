Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40746A0629
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfH1PWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 11:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfH1PWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:22:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D8E122CED;
        Wed, 28 Aug 2019 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567005723;
        bh=ZJhc4Bf5xGC50rybksdzOKNk41SFLjFvVE7vxDePzbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRnwzFqeI14acCU9fWPLHIN5Uv+JP94U+v5H1SosVPVcOju1qL7QqnmbuhxXFlWAh
         xmX6PlsOABM4P5p/1fD1aH+L8FKCvW2zx3ZFGOZUDqKAWlbue93u0yu/whus7FlAdz
         3JGqIAHgRxw0FvAIBccauvHCwOOm4VC63xVxvvkk=
Date:   Wed, 28 Aug 2019 17:22:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: Re: [PATCH v2 2/2] uacce: add uacce driver
Message-ID: <20190828152201.GA10163@kroah.com>
References: <1566998876-31770-1-git-send-email-zhangfei.gao@linaro.org>
 <1566998876-31770-3-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566998876-31770-3-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 09:27:56PM +0800, Zhangfei Gao wrote:
> +struct uacce {
> +	const char *drv_name;
> +	const char *algs;
> +	const char *api_ver;
> +	unsigned int flags;
> +	unsigned long qf_pg_start[UACCE_QFRT_MAX];
> +	struct uacce_ops *ops;
> +	struct device *pdev;
> +	bool is_vf;
> +	u32 dev_id;
> +	struct cdev cdev;
> +	struct device dev;
> +	void *priv;
> +	atomic_t state;
> +	int prot;
> +	struct mutex q_lock;
> +	struct list_head qs;
> +};

At a quick glance, this problem really stood out to me.  You CAN NOT
have two different objects within a structure that have different
lifetime rules and reference counts.  You do that here with both a
'struct cdev' and a 'struct device'.  Pick one or the other, but never
both.

I would recommend using a 'struct device' and then a 'struct cdev *'.
That way you get the advantage of using the driver model properly, and
then just adding your char device node pointer to "the side" which
interacts with this device.

Then you might want to call this "struct uacce_device" :)

thanks,

greg k-h
