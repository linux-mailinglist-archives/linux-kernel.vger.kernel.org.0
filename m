Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DCD2FDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfE3O3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 10:29:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46046 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfE3O3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:29:08 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so5193449ioc.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZCcIn2Fw734nRU6CpDHWXMhDHV7F+Ltk873wP06S/g=;
        b=Jqd8neyCEkNuRN87YhxdFapVtvj+Tbefg7QKya79rtXFcXPvPfbDmD8/LhPlqb3JlP
         CLnYMuKeVNKY8zTXNbpyX/5sB/fXQYS9elMEpy3HKkwTasyzx0VhVei7/AzkjTDog7uo
         zIAdFN3YiNTUjjuep8yLqK/uca57TYPkXPbnI4MiquiezKEvElUQ5+4LzR366O9NX9tI
         gH83EfQVhKpzFbk3tI+w2MQ0ln7MLFlL/UTO1nvEcOvyGaNR2rXIfcmhGr6eVXJwPr1w
         LT1yegueCSEZe+ljgtOqA5+gasVT1P7p07GP3eu8ipfvmGBQmzMW5vU1bbO043BnJzy7
         Onvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZCcIn2Fw734nRU6CpDHWXMhDHV7F+Ltk873wP06S/g=;
        b=dvRPZiZ8PG1XP94Z5g7Yogw7VdO231lt7rxePtbom8J3qV+TE/bVhlC9oy0ySFpXFT
         nK10FqiUt2AZRnCVx1NKNCCc5O3y/9zheg5vt2dLnoIWw/+mhPhfRHWp/Kg2Iw5huxqd
         BeZTlGxXzqr76yx5GTh3K/B7yXfCY41bOq/nSYSTuSib27FvIR6tk/5mDo7UqLWO+Wjh
         ykNh7i+N9z8PyQdBEeH3ETzXOy50YwUZNg0NVlrpeTpjooOoTdKD2oYUlx+o+1JPC2sM
         QWYAp6b9kyhuh3OspAp7uh0QQRcp2lCw7maK+FT8JJ/ksrS8nd6Q8QGOlX0VFlTafqm2
         m/wg==
X-Gm-Message-State: APjAAAWYiwwf0Vzp/B6xx34o6HH+wOVL4mB2abwrz1ekpbRU52q3OKSz
        X3Ml0lCdymGSEwxhBt2zHyjPsRURfkqgMNBNl12rTw==
X-Google-Smtp-Source: APXvYqyRcCdwkWKj4MkEkBmEqD3HdIuQ+2BcSRbRW3DnbZonxPFtxP28CM+c3ZOfi1hbdn5vFqZR26SvgsaMzdIq/bk=
X-Received: by 2002:a5d:968e:: with SMTP id m14mr2838976ion.49.1559226547782;
 Thu, 30 May 2019 07:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <1559149856-7938-1-git-send-email-iuliana.prodan@nxp.com>
 <20190529202728.GA35103@gmail.com> <CAKv+Gu-4KqcY=WhwY98JigTzeXaL5ggYEcu7+kNzNtpO2FLQXg@mail.gmail.com>
 <VI1PR04MB44459EEF7BCD3458BB3D143D8C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <20190530133427.qrwjzctac2x6nsby@gondor.apana.org.au> <VI1PR04MB444562A2352FE4BAD7F681258C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <CAKv+Gu-jTWQP0Zp=QpuzX41v8Eb5Bvd0O9ajwSnFkDO-ijBf_A@mail.gmail.com>
 <CAKv+Gu9JoC+GKJ6mMAE25mr_k2gbznh-83jApT4=FZsAW=jd8w@mail.gmail.com> <20190530142734.qlhgzeal22zxfhk5@gondor.apana.org.au>
In-Reply-To: <20190530142734.qlhgzeal22zxfhk5@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 30 May 2019 16:28:54 +0200
Message-ID: <CAKv+Gu8jJQCZwiHFORUJUzRaAizWzBQ95EAgYe36sFrcvzb6vg@mail.gmail.com>
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

On Thu, 30 May 2019 at 16:27, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, May 30, 2019 at 03:55:07PM +0200, Ard Biesheuvel wrote:
> >
> > > Would this work?
>
> I see.  You need to preserve the original IV.
>
> > > diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
> > > index c0ece44f303b..2ef2f76a3cb8 100644
> > > --- a/drivers/crypto/caam/caamalg.c
> > > +++ b/drivers/crypto/caam/caamalg.c
> > > @@ -1832,22 +1832,25 @@ static int skcipher_decrypt(struct
> > > skcipher_request *req)
> > >         struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
> > >         int ivsize = crypto_skcipher_ivsize(skcipher);
> > >         struct device *jrdev = ctx->jrdev;
> > > +       u8 out_iv[AES_BLOCK_SIZE];
> > >         u32 *desc;
> > >         int ret = 0;
> > >
> > > -       /* allocate extended descriptor */
> > > -       edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ);
> > > -       if (IS_ERR(edesc))
> > > -               return PTR_ERR(edesc);
> > > -
> > >         /*
> > >          * The crypto API expects us to set the IV (req->iv) to the last
> > >          * ciphertext block.
> > >          */
> > >         if (ivsize)
> > > -               scatterwalk_map_and_copy(req->iv, req->src, req->cryptlen -
> > > +               scatterwalk_map_and_copy(out_iv, req->src, req->cryptlen -
> > >                                          ivsize, ivsize, 0);
> > >
> > > +       /* allocate extended descriptor */
> > > +       edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ);
> > > +       if (IS_ERR(edesc))
> > > +               return PTR_ERR(edesc);
> > > +
> > > +       memcpy(req->iv, out_iv, ivsize);
> > > +
> > >         /* Create and submit job descriptor*/
> > >         init_skcipher_job(req, edesc, false);
> > >         desc = edesc->hw_desc;
> >
> > Umm never mind
> >
> > /me hides in shame
>
> So why doesn't this work?
>

Because the memcpy() occurs while the buffer is mapped for DMA, so it
suffers from the exact same problem.
