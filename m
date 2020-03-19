Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26B18AE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 09:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgCSIPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 04:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgCSIPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:15:43 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D66F420663;
        Thu, 19 Mar 2020 08:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584605742;
        bh=LdJipUFyZBF+HWb06ft7tA5xx8pfQFU78elBxzYZlTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nGHgshCIeIYyjXviV1KXQzzgZIyEakQRG7TP5KXx+V4qOKEcRm3+dvc9WuVV0h+14
         x36voC/EuAh3rl/mYHzUrxGeciPHqAiyi2/vt2Zx+wkp7/OoPosTm3hUWpYYe5tsz5
         cdoU3/vyva6X37aZr3e2/j3RW8sI/VWfPKm4j/5c=
Date:   Thu, 19 Mar 2020 08:15:37 +0000
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Torsten Duwe <duwe@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][Fix] crypto: arm{,64} neon: memzero_explicit aes-cbc key
Message-ID: <20200319081536.GA20670@willie-the-truck>
References: <20200313110258.94A0668C4E@verein.lst.de>
 <20200317221743.GD20788@willie-the-truck>
 <CAKv+Gu9_gV0aVwa2QG7jgaR71bTz12vs386R9uPjdQTtm0HcUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9_gV0aVwa2QG7jgaR71bTz12vs386R9uPjdQTtm0HcUw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 04:13:33PM -0400, Ard Biesheuvel wrote:
> On Tue, 17 Mar 2020 at 18:17, Will Deacon <will@kernel.org> wrote:
> >
> > [+Ard]
> >
> > On Fri, Mar 13, 2020 at 12:02:58PM +0100, Torsten Duwe wrote:
> > > From: Torsten Duwe <duwe@suse.de>
> > >
> > > At function exit, do not leave the expanded key in the rk struct
> > > which got allocated on the stack.
> > >
> > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > > ---
> > > Another small fix from our FIPS evaluation. I hope you don't mind I merged
> > > arm32 and arm64 into one patch -- this is really simple.
> > > --- a/arch/arm/crypto/aes-neonbs-glue.c
> > > +++ b/arch/arm/crypto/aes-neonbs-glue.c
> > > @@ -138,6 +138,7 @@ static int aesbs_cbc_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
> > >       kernel_neon_begin();
> > >       aesbs_convert_key(ctx->key.rk, rk.key_enc, ctx->key.rounds);
> > >       kernel_neon_end();
> > > +     memzero_explicit(&rk, sizeof(rk));
> > >
> > >       return crypto_cipher_setkey(ctx->enc_tfm, in_key, key_len);
> > >  }
> > > diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
> > > index e3e27349a9fe..c0b980503643 100644
> > > --- a/arch/arm64/crypto/aes-neonbs-glue.c
> > > +++ b/arch/arm64/crypto/aes-neonbs-glue.c
> > > @@ -151,6 +151,7 @@ static int aesbs_cbc_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
> > >       kernel_neon_begin();
> > >       aesbs_convert_key(ctx->key.rk, rk.key_enc, ctx->key.rounds);
> > >       kernel_neon_end();
> > > +     memzero_explicit(&rk, sizeof(rk));
> > >
> > >       return 0;
> > >  }
> >
> > I'm certainly not a crypto person, but this looks sensible to me and I
> > couldn't find any other similar stack variable usage under
> > arch/arm64/crypto/ at a quick glance.
> >
> > Acked-by: Will Deacon <will@kernel.org>
> >
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Cheers, Ard. I'm assuming that Herbert will pick this up via the crypto
tree.

Will
