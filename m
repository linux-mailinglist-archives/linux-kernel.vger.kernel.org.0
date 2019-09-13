Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27924B1A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 11:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfIMJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 05:17:49 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33530 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbfIMJRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:17:49 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i8hhm-0007jT-F3; Fri, 13 Sep 2019 19:17:27 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Sep 2019 19:17:18 +1000
Date:   Fri, 13 Sep 2019 19:17:18 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hao Fang <fanghao11@huawei.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: hisilicon - avoid unused function warning
Message-ID: <20190913091718.GA6382@gondor.apana.org.au>
References: <20190906152250.1450649-1-arnd@arndb.de>
 <20190906152250.1450649-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906152250.1450649-2-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 05:22:30PM +0200, Arnd Bergmann wrote:
> The only caller of hisi_zip_vf_q_assign() is hidden in an #ifdef,
> so the function causes a warning when CONFIG_PCI_IOV is disabled:
> 
> drivers/crypto/hisilicon/zip/zip_main.c:740:12: error: unused function 'hisi_zip_vf_q_assign' [-Werror,-Wunused-function]
> 
> Move it into the same #ifdef.
> 
> Fixes: 79e09f30eeba ("crypto: hisilicon - add SRIOV support for ZIP")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/hisilicon/zip/zip_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Please find a way to fix this warning without reducing compiler
coverage.  I prefer to see any compile issues immediately rather
than through automated build testing.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
