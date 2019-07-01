Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4C36C98
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 08:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFFGxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 02:53:24 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38046 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFGxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:53:23 -0400
Received: by mail-it1-f195.google.com with SMTP id h9so1475837itk.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 23:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IeWfpZT2bFu7Dyu6HFjhOwPn1OYpekVmcZCpvqk6qKA=;
        b=CVnld91YvVoVvgxrQghCO6cF6OrC6trSC4vE53CvvCJjcSY/x/Hx3em6U42Eo3F1hf
         tUxVAkOnnbCMfJIaFQ3lUeffMZO+TA5t9VHjNIuCRHFDG1IEFw70uBUAnJj0Pbzni5TG
         SbjuI/PYh9gcfUE1/wsKnl8NOq3d/F/asB95k4A19DAQ2Q0M5gj0AEa9ET9mppwEdGpv
         x/JfcIu13/Hi2LlQ+HVhKMddC67BfZgLidKsdaqwALvH/UBHwZxi1DDINIaOgtG6WtEv
         79TxzsMn6BO3bQiUSh1l9ffQbxPv4d/fZVoQkde22GnVoTctrgEudKXMdyGduDC1jK8H
         tO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IeWfpZT2bFu7Dyu6HFjhOwPn1OYpekVmcZCpvqk6qKA=;
        b=mw0HajfFL9emNOEm2zpqJJTFraQzs9lSFKL/b7ME1f4TPWjwDS9IV/AjJqsWo10qeE
         R2X5vjITTDWsNkx2h3f+dF0DH3ZUUiH9SJl6IZOreQcIblQKKan6qAZk23x05ED1TcU5
         YSJnHz5HczqyI5igTGDCny9Cz/Wspg4Hvzaut64v/VXB6no0rzwEMLOa9ubS2WMFiN8f
         JmeBfmFJIqE5e7JC95NW7+1L6Nv/bq+Unu1ndDK2OiJN2hgf2dxQWc/ZsQ6jm+YrZoEm
         MaZ9DQM6/oxwAYwatgf7T+TagsyBkHADLG+l26ouNIhvbz6pKn/2k2AqCUpuHLHKeJKw
         oxvw==
X-Gm-Message-State: APjAAAWgXm5NwxnJAC9CSgLXQY4c1pbcahyhbxY2BcgaB3qXwnwima0x
        keKWqd5wy0jFCJy1RoIpCVb1mS6axhP67Ww0/7+wDw==
X-Google-Smtp-Source: APXvYqyZCVLads/57MgQ4TfPK2w6tD57a5LXkzlkRKl4t86BTh/t9o0DCnL0cKdDZJAERWOA3hu6eG1Vhds84Wqh+0A=
X-Received: by 2002:a24:4f88:: with SMTP id c130mr4314064itb.104.1559804002863;
 Wed, 05 Jun 2019 23:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR04MB44459EEF7BCD3458BB3D143D8C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <20190530133427.qrwjzctac2x6nsby@gondor.apana.org.au> <VI1PR04MB444562A2352FE4BAD7F681258C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <CAKv+Gu-jTWQP0Zp=QpuzX41v8Eb5Bvd0O9ajwSnFkDO-ijBf_A@mail.gmail.com>
 <CAKv+Gu9JoC+GKJ6mMAE25mr_k2gbznh-83jApT4=FZsAW=jd8w@mail.gmail.com>
 <20190530142734.qlhgzeal22zxfhk5@gondor.apana.org.au> <CAKv+Gu8jJQCZwiHFORUJUzRaAizWzBQ95EAgYe36sFrcvzb6vg@mail.gmail.com>
 <CAKv+Gu-KBgiyNY2Dypx6vqtmpTXNfOxxWxJf50BTiF2rCOFqnw@mail.gmail.com>
 <20190606063724.n77z7gaf32tmyxng@gondor.apana.org.au> <CAKv+Gu-YtKRsUYMMD_PNoFvrPpmwTD7fJNs64Q-34L8-TvucqA@mail.gmail.com>
 <20190606064603.lvde6dproqi3vwcq@gondor.apana.org.au>
In-Reply-To: <20190606064603.lvde6dproqi3vwcq@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Jun 2019 08:53:10 +0200
Message-ID: <CAKv+Gu-DokZ179_Gx8_20v_pQ3w_CARKdO0xdsO8CRZJG1uOqA@mail.gmail.com>
Subject: Re: [PATCH] crypto: gcm - fix cacheline sharing
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Horia Geanta <horia.geanta@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2019 at 08:46, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Jun 06, 2019 at 08:42:46AM +0200, Ard Biesheuvel wrote:
> > On Thu, 6 Jun 2019 at 08:37, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > >
> > > On Thu, May 30, 2019 at 04:31:09PM +0200, Ard Biesheuvel wrote:
> > > >
> > > > This might work:
> > > >
> > > > diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
> > > > index c0ece44f303b..3d313d2a279a 100644
> > > > --- a/drivers/crypto/caam/caamalg.c
> > > > +++ b/drivers/crypto/caam/caamalg.c
> > > > @@ -1661,7 +1661,8 @@ static int aead_decrypt(struct aead_request *req)
> > > >   * allocate and map the skcipher extended descriptor for skcipher
> > > >   */
> > > >  static struct skcipher_edesc *skcipher_edesc_alloc(struct
> > > > skcipher_request *req,
> > > > -                                                  int desc_bytes)
> > > > +                                                  int desc_bytes,
> > > > +                                                  u8 const *input_iv)
> > > >  {
> > > >         struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
> > > >         struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
> > > > @@ -1745,7 +1746,7 @@ static struct skcipher_edesc
> > > > *skcipher_edesc_alloc(struct skcipher_request *req,
> > > >         /* Make sure IV is located in a DMAable area */
> > > >         if (ivsize) {
> > > >                 iv = (u8 *)edesc->hw_desc + desc_bytes + sec4_sg_bytes;
> > > > -               memcpy(iv, req->iv, ivsize);
> > > > +               memcpy(iv, input_iv, ivsize);
> > > >
> > > >                 iv_dma = dma_map_single(jrdev, iv, ivsize, DMA_TO_DEVICE);
> > > >                 if (dma_mapping_error(jrdev, iv_dma)) {
> > >
> > > Hi Ard:
> > >
> > > I presume you will be submitting this patch at some point?  When
> > > you do please base it on top of your other one which I'm about to
> > > merge.
> >
> > I'm not sure I follow. Do you want a better fix for the CBC output IV
> > going forward? Or is this about other modes?
>
> You sent me a patch to fix CTR mode:
>
> https://patchwork.kernel.org/patch/10969747/
>

That patch does not fix CTR mode, it just disables copying the output
IV altogether for CTR mode so the DMA corruption does not occur.

> But your suggested fix for CBC mode itself where we need to do the
> copy (as seen quoted above) hasn't been submitted.
>

That same patch 'fixes' CBC, since CBC was never broken to begin with.
The CTS driver does not have something like the auth_tag sharing the
same cacheline with the IV, so CBC has always worked fine.

So I guess what you are after is a patch that, instead of dodging the
issue by limiting the copy to CBC, does not perform the copy at all
while anything is mapped for DMA? Then we can leave it up to the NXP
engineers to fix CTR mode.
