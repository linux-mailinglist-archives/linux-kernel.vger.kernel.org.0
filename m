Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBFC11D250
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 17:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfLLQaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 11:30:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbfLLQap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=khY/qWhZInwSgiNzmnOP2HxlFL5pkhJy4Cfdsnobn7I=; b=aQ5hminZjN7t1WXDex1B7qH/e
        FLlIGdl9mwGIOScoC+ZPR8So7hp8yjOM+d18kEK5MIUVxfr1DGt5R/+fg/Dm2ex2uekBvv6787uP/
        Gz+WNAZwGIR0SiWM6mweGHVSzkHWlI3p6/HSd1NeDLMuKtowBfacnLuyvQ6pXCdl9aR7j+gS0Dq+m
        WC9ocO/jFcIjlBD+OHlfApOWTBFnahZK9fbNqXg/JlB0nUNuTdFWQyBNVbiEj6UdENz68IocVGWTL
        2661mRu3JsOWAeqccZ1OI3zb3EmGTFRbmk+rfISu6AOLI+isjFMEsyCWuapJssAZFMF/FA8FqNZ18
        HZJoDxf5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifRMO-00066i-OE; Thu, 12 Dec 2019 16:30:40 +0000
Date:   Thu, 12 Dec 2019 08:30:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 21/24] compat_ioctl: block: move blkdev_compat_ioctl()
 into ioctl.c
Message-ID: <20191212163040.GD27991@infradead.org>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-22-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211204306.1207817-22-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_COMPAT
> +static int compat_put_ushort(unsigned long arg, unsigned short val)
> +{
> +	return put_user(val, (unsigned short __user *)compat_ptr(arg));
> +}
> +
> +static int compat_put_int(unsigned long arg, int val)
> +{
> +	return put_user(val, (compat_int_t __user *)compat_ptr(arg));
> +}
> +
> +static int compat_put_uint(unsigned long arg, unsigned int val)
> +{
> +	return put_user(val, (compat_uint_t __user *)compat_ptr(arg));
> +}
> +
> +static int compat_put_long(unsigned long arg, long val)
> +{
> +	return put_user(val, (compat_long_t __user *)compat_ptr(arg));
> +}
> +
> +static int compat_put_ulong(unsigned long arg, compat_ulong_t val)
> +{
> +	return put_user(val, (compat_ulong_t __user *)compat_ptr(arg));
> +}
> +
> +static int compat_put_u64(unsigned long arg, u64 val)
> +{
> +	return put_user(val, (compat_u64 __user *)compat_ptr(arg));
> +}
> +#endif

Can we lift these helpers to compat.h instead?
