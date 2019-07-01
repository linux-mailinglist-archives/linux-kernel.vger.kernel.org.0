Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48AE2FCF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 16:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfE3OLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 10:11:52 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50869 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfE3OLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:11:52 -0400
Received: by mail-it1-f196.google.com with SMTP id a186so10121648itg.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3m+GACOpj4FpxTfagkQ56YHJBgCqLctr+f1GcaAlBKI=;
        b=r7mmQx/MZFOJbicAL0UI1sOzinV94EgrU9O0u7jEhPqiptJnmddsYUSPm6on0kSrFU
         xQp6ZR2QHiJ8kS333/mkLjOlU0owecS7mHTcI+8Q8w1Ufa0yemmz/wFyrLvCEbMdiG4g
         awWPIkJOFlfBdmi1Y5w8qzOOaTJAe210hkBkpB46Sw/pRJwbjTL1DZdo888zGLDYbKAn
         3zh7IGr4/NmN1B1+kmNGKVuJ/Mr8SrrOolOuPxRCZpv9/5pP6hgnFnVRiyNMinILW+3m
         iZahnc9s3SC8bhVTKSYkb9QT0z94Z7n7JqCOn/Gqt+Du9essV5xI2CJUYj6PLn2liJUG
         irxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3m+GACOpj4FpxTfagkQ56YHJBgCqLctr+f1GcaAlBKI=;
        b=N/j7AiZdkWxDlyoMGzxVYEPFkTQMem3vV7RRkbIbYN6UcLQeIFvl5X8b3K7Wddcmds
         8o+UwqR+nND5T87hlj4VHieosqLLOqVztNpkvHT50wHaj2Jjyw6HZ/1Aakbf5c1RJHGo
         Afmg/MZ7d+d6W9LT8LXG9/LRMmBWq6uukFRbFnVUUCZZVeaNkbsw4igADLIey5yfc2J7
         ft9lrJ0Wb9fGBOtDJZ9tVaEVVdHxqSpGHGZvOqYVVBC7A5wPHYxhNFosijl1hNvWGb5Y
         Gh2R/Z2AXpaF/8lze9m2Phw+wq0ELSZOAf9Fcy5Q6ydb+FLZHGlqfZRFE210tPrk2Pl2
         wCMA==
X-Gm-Message-State: APjAAAWIKwkJHlzHQspCMK55YIytmIx/3eSExNf+UpDKOAE1TekxDpGI
        9e1qNpL7WFu/gKDU5lyzsImOXWgiEaySrOIEPiMD0g==
X-Google-Smtp-Source: APXvYqxlk8ceqS9HRJKUfgBmZuPgL2m9fPkzhV4JV6IB5Nb7Kcw2FyUXVE+x8OcM8KUkiooPFDCXgf6wVOc9oPemd4M=
X-Received: by 2002:a02:a494:: with SMTP id d20mr2418000jam.62.1559225511157;
 Thu, 30 May 2019 07:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <1559149856-7938-1-git-send-email-iuliana.prodan@nxp.com>
 <20190529202728.GA35103@gmail.com> <CAKv+Gu-4KqcY=WhwY98JigTzeXaL5ggYEcu7+kNzNtpO2FLQXg@mail.gmail.com>
 <VI1PR04MB44459EEF7BCD3458BB3D143D8C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <20190530133427.qrwjzctac2x6nsby@gondor.apana.org.au> <VI1PR04MB444562A2352FE4BAD7F681258C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <20190530135800.ekcso3n2p5zkg6yv@gondor.apana.org.au>
In-Reply-To: <20190530135800.ekcso3n2p5zkg6yv@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 30 May 2019 16:11:37 +0200
Message-ID: <CAKv+Gu-3zzN=cikd4PftCVo2fJi9t_0kqZHBQncjokYQV5wVnA@mail.gmail.com>
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

On Thu, 30 May 2019 at 15:58, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, May 30, 2019 at 01:45:47PM +0000, Iuliana Prodan wrote:
> >
> > On the current structure of caamalg, to work, iv needs to be copied
> > before memcpy(iv, req->iv, ivsize), from skcipher_edesc_alloc function.
> > For this we need edesc, but this cannot be allocated before knowing how
> > much memory we need. So, to make it work, we'll need to modify more in CAAM.
>
> All the copying does is:
>
>         if (ivsize)
>                 scatterwalk_map_and_copy(req->iv, req->src, req->cryptlen -
>                                          ivsize, ivsize, 0);
>
> Why do you need to allocate the edesc before doing this?
>

Because that is where the incoming iv is currently consumed. Copying
it out like this wipes the input IV from memory.
