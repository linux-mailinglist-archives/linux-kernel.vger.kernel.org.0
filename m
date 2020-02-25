Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1275F16BE8F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 11:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgBYKYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 05:24:17 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:41676 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgBYKYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:24:15 -0500
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1j6XML-0003B1-7N; Tue, 25 Feb 2020 21:22:38 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 25 Feb 2020 21:22:37 +1100
Date:   Tue, 25 Feb 2020 21:22:37 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Hongbo Yao <yaohongbo@huawei.com>, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        chenzhou10@huawei.com, xuzaibo@huawei.com
Subject: Re: [PATCH -next] crypto: hisilicon - qm depends on UACCE
Message-ID: <20200225102237.GA31328@gondor.apana.org.au>
References: <20200225030356.44008-1-yaohongbo@huawei.com>
 <5E54DE89.2030703@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E54DE89.2030703@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 04:44:57PM +0800, Zhou Wang wrote:
>
> > diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> > index 8851161f722f..b35c2ec15bc2 100644
> > --- a/drivers/crypto/hisilicon/Kconfig
> > +++ b/drivers/crypto/hisilicon/Kconfig
> > @@ -40,6 +40,7 @@ config CRYPTO_DEV_HISI_QM
> >  	tristate
> >  	depends on ARM64 || COMPILE_TEST
> >  	depends on PCI && PCI_MSI
> > +	depends on UACCE
> >  	help
> >  	  HiSilicon accelerator engines use a common queue management
> >  	  interface. Specific engine driver may use this module.
> >
> 
> Indeed, this driver does not depend on uacce fully, as if there is no uacce, it still can
> register to kernel crypto.
> 
> Seems that changing uacce config to bool can avoid this problem.

You shouldn't make it a bool.  The standard way to solve this is to
add this:

	depends on UACCE || UACCE=n

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
