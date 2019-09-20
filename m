Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67655B9053
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfITNG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 09:06:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34626 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfITNG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:06:57 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iBIZf-0007uP-Gh; Fri, 20 Sep 2019 23:03:48 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Sep 2019 23:03:45 +1000
Date:   Fri, 20 Sep 2019 23:03:45 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [v2] crypto: hisilicon - avoid unused function
 warning
Message-ID: <20190920130345.GA23752@gondor.apana.org.au>
References: <20190919140650.1289963-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919140650.1289963-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 04:05:52PM +0200, Arnd Bergmann wrote:
> The only caller of hisi_zip_vf_q_assign() is hidden in an #ifdef,
> so the function causes a warning when CONFIG_PCI_IOV is disabled:
> 
> drivers/crypto/hisilicon/zip/zip_main.c:740:12: error: unused function 'hisi_zip_vf_q_assign' [-Werror,-Wunused-function]
> 
> Replace the #ifdef with an IS_ENABLED() check that leads to the
> function being dropped based on the configuration.
> 
> Fixes: 79e09f30eeba ("crypto: hisilicon - add SRIOV support for ZIP")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/hisilicon/zip/zip_main.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
