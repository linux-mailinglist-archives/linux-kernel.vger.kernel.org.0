Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4A765D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfGZMcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 08:32:18 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:46410 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfGZMcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:32:18 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hqzOJ-0003l5-Ny; Fri, 26 Jul 2019 22:32:07 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hqzOE-00028E-SW; Fri, 26 Jul 2019 22:32:02 +1000
Date:   Fri, 26 Jul 2019 22:32:02 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     unlisted-recipients:; horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        davem@davemloft.net, arei.gonglei@huawei.com, mst@redhat.com,
        jasowang@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, huangfq.daxian@gmail.com
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:;horia.geanta@nxp.com
                                             ^-missing end of address
Subject: Re: [PATCH v2 06/35] crypto: Use kmemdup rather than duplicating its
 implementation
Message-ID: <20190726123202.GA8187@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703162708.32137-1-huangfq.daxian@gmail.com>
Organization: Core
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel,apana.lists.os.linux.virtualization
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fuqian Huang <huangfq.daxian@gmail.com> wrote:
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>  - Fix a typo in commit message (memset -> memcpy)
> 
> drivers/crypto/caam/caampkc.c              | 11 +++--------
> drivers/crypto/virtio/virtio_crypto_algs.c |  4 +---
> 2 files changed, 4 insertions(+), 11 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
