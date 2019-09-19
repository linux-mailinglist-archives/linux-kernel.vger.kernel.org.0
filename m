Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56CB7ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 15:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbfISNsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 09:48:39 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34390 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbfISNsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:48:38 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iAwnD-0008H1-Iq; Thu, 19 Sep 2019 23:48:20 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 19 Sep 2019 23:48:13 +1000
Date:   Thu, 19 Sep 2019 23:48:13 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hao Fang <fanghao11@huawei.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: hisilicon - avoid unused function warning
Message-ID: <20190919134813.GB29320@gondor.apana.org.au>
References: <20190906152250.1450649-1-arnd@arndb.de>
 <20190906152250.1450649-2-arnd@arndb.de>
 <20190913091718.GA6382@gondor.apana.org.au>
 <5D833821.5000504@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D833821.5000504@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 04:11:13PM +0800, Zhou Wang wrote:
> On 2019/9/13 17:17, Herbert Xu wrote:
> > On Fri, Sep 06, 2019 at 05:22:30PM +0200, Arnd Bergmann wrote:
> >> The only caller of hisi_zip_vf_q_assign() is hidden in an #ifdef,
> >> so the function causes a warning when CONFIG_PCI_IOV is disabled:
> >>
> >> drivers/crypto/hisilicon/zip/zip_main.c:740:12: error: unused function 'hisi_zip_vf_q_assign' [-Werror,-Wunused-function]
> >>
> >> Move it into the same #ifdef.
> >>
> >> Fixes: 79e09f30eeba ("crypto: hisilicon - add SRIOV support for ZIP")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  drivers/crypto/hisilicon/zip/zip_main.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> > 
> > Please find a way to fix this warning without reducing compiler
> > coverage.  I prefer to see any compile issues immediately rather
> > than through automated build testing.
> > 
> > Thanks,
> >
> 
> Sorry for missing this patch.
> 
> Seems other drivers also do like using #ifdef. Do you mean something like this:
> #ifdef CONFIG_PCI_IOV
> sriov_enable()
> ...
> #else
> /* stub */
> sriov_enable()
> ...
> #endif

For an unused warning the unused compiler attribute would seem
to be the way to go.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
