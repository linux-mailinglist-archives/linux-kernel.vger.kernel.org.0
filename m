Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4B3D2A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbfJJMyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 08:54:39 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37610 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbfJJMyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:54:39 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iIXxg-0001rW-Lx; Thu, 10 Oct 2019 23:54:33 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Oct 2019 23:54:32 +1100
Date:   Thu, 10 Oct 2019 23:54:32 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zaibo Xu <xuzaibo@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxarm@huawei.com,
        forest.zhouchang@huawei.com
Subject: Re: [PATCH 0/5] crypto: hisilicon - add HPRE support
Message-ID: <20191010125432.GC31566@gondor.apana.org.au>
References: <1569835209-44326-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569835209-44326-1-git-send-email-xuzaibo@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 05:20:04PM +0800, Zaibo Xu wrote:
> This series adds HiSilicon high performance RSA engine(HPRE) driver
> in crypto subsystem. HPRE driver provides PCIe hardware device initiation
> with RSA and DH algorithms registered to Crypto. Meanwhile, some debug
> supporting of DebugFS is given.
> 
> Zaibo Xu (5):
>   crypto: hisilicon - add HiSilicon HPRE accelerator
>   crypto: hisilicon - add SRIOV support for HPRE
>   Documentation: Add debugfs doc for hisi_hpre
>   crypto: hisilicon: Add debugfs for HPRE
>   MAINTAINERS: Add maintainer for HiSilicon HPRE driver
> 
>  Documentation/ABI/testing/debugfs-hisi-hpre |   57 ++
>  MAINTAINERS                                 |    9 +
>  drivers/crypto/hisilicon/Kconfig            |   11 +
>  drivers/crypto/hisilicon/Makefile           |    1 +
>  drivers/crypto/hisilicon/hpre/Makefile      |    2 +
>  drivers/crypto/hisilicon/hpre/hpre.h        |   83 ++
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 1137 +++++++++++++++++++++++++++
>  drivers/crypto/hisilicon/hpre/hpre_main.c   | 1052 +++++++++++++++++++++++++
>  8 files changed, 2352 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-hpre
>  create mode 100644 drivers/crypto/hisilicon/hpre/Makefile
>  create mode 100644 drivers/crypto/hisilicon/hpre/hpre.h
>  create mode 100644 drivers/crypto/hisilicon/hpre/hpre_crypto.c
>  create mode 100644 drivers/crypto/hisilicon/hpre/hpre_main.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
