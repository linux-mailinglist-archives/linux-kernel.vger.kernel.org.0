Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF55E126F7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 06:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfECEsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 00:48:09 -0400
Received: from [5.180.42.13] ([5.180.42.13]:37464 "EHLO deadmen.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfECEsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 00:48:09 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hMQ7B-0005Jt-9T; Fri, 03 May 2019 12:48:05 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hMQ72-00021N-7d; Fri, 03 May 2019 12:47:56 +0800
Date:   Fri, 3 May 2019 12:47:56 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH -next] crypto: ccree - Make cc_sec_disable static
Message-ID: <20190503044756.smqzlnluizomtcbw@gondor.apana.org.au>
References: <20190426164313.32308-1-yuehaibing@huawei.com>
 <CAOtvUMfO1jvU6_Y7=otKQt0t9o_At0QBg7eqwV4SbeD9srbAqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtvUMfO1jvU6_Y7=otKQt0t9o_At0QBg7eqwV4SbeD9srbAqg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 10:56:51AM +0300, Gilad Ben-Yossef wrote:
> On Fri, Apr 26, 2019 at 7:43 PM Yue Haibing <yuehaibing@huawei.com> wrote:
> >
> > From: YueHaibing <yuehaibing@huawei.com>
> >
> > Fix sparse warning:
> >
> > drivers/crypto/ccree/cc_driver.c:37:6: warning:
> >  symbol 'cc_sec_disable' was not declared. Should it be static?
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Thank you!
> 
> The kbuit test robot already sent the same fix, which I acked.
> It's hard competing with the bots... :-)

For some reason the robot's patch didn't make it into patchwork
so I'm going to take this one instead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
