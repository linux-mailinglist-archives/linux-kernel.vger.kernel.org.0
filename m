Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD2748541
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 16:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfFQOYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 10:24:36 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33950 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfFQOYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:24:36 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hcsYZ-00018l-6s; Mon, 17 Jun 2019 22:24:23 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hcsYV-0003BB-5b; Mon, 17 Jun 2019 22:24:19 +0800
Date:   Mon, 17 Jun 2019 22:24:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: testmgr - reduce stack usage in fuzzers
Message-ID: <20190617142419.yw4w5w344tf6ozrb@gondor.apana.org.au>
References: <20190617132343.2678836-1-arnd@arndb.de>
 <20190617140435.qjzcouaqzepaicf4@gondor.apana.org.au>
 <CAK8P3a07Vcqs+6Rs2Ckq_itWfGKUv+_pdgdis9eSujCGHQgFkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a07Vcqs+6Rs2Ckq_itWfGKUv+_pdgdis9eSujCGHQgFkQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 04:10:44PM +0200, Arnd Bergmann wrote:
>
> In most cases, this ends up in favor of clang (concerning the stack
> warning size limit) because most variables are small, but here we have
> a large stack object (two objects for the hash fuzzing) with a large redzone.

Oh I missed the fact that there is another large stack variable
further up the stack.  So what happens if you just convert that
one and leave the shash descriptor alone?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
