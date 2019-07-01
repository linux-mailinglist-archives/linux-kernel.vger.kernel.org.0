Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463E92FED6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfE3PFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 11:05:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36402 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3PFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:05:05 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so5347783ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvt0JcWpyPlkkNAtAO9YUzPTlBiKUJt7TcdxdDpdEuk=;
        b=YeeHVzkHGt0/TRrPUDvopCGyBPvlJT5jKL5fhU9erhoHrokOiEbeVGuVnHm+Ppnyaa
         kobKTc3vQXpOK2NOww38wGIYlJIev8bd2vIhC9expYN+5HdY3fqV5CeA3ZvrYkixAEZF
         x0NPoYFdcuLlPBfVYES7gcPd5QzHcmyzPPB2zXIx6cPo8mUGhC03s6VtLiu2iunOVvs6
         OJ2MZF0anx/ZNMCCD7cQvbKnfKrYMSWjm60QM96JF6Lt6p+qTTDmfz0DBFM3c3t6rkmf
         WsDYV52q7WKU/4fnQQMabGYWCYB/JUHj7W8Ek4qloibiPjKDYxwfW2ZAZ65tN/dvwtnZ
         zyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvt0JcWpyPlkkNAtAO9YUzPTlBiKUJt7TcdxdDpdEuk=;
        b=noCX9W0v1EDIJfe5RWvkDJSioyLRiRm6fe5w8+sdEiDGtuojDF+TSHgu7FdQWGJe0u
         pxGTLcQubdncpu816Ky8WPGcqqePNfAGYaLkPUN2eaI6vk/tQP+q5pzJC+08KOgIjAv7
         PrRo3122Ax7jYKN+jLkxvJMla/6c6cgiJiGSZM1sg6bnfCV/bJY8oGzkPopFbiKX3CZC
         xAKYYUtjVjFzn34aEpLV6QMEWbRG4eR5zPegYzu9H/gsmcMa91mqAQgf7PAHw4Pjz7w4
         VQg8bq9q1yreveeaWP0VQpA8HQy0x7ieWz0EaIWmkEkoYpo096bmtDglXR0dvIlVm1/y
         QtjA==
X-Gm-Message-State: APjAAAUZAQeb+y7Xhu01aJdh8SrpJbZ44k3k1I5iAycICB3NrOd1UrOd
        Pm1agXSjjbh+kyXhaTUb0IhDGVPC1fEoPQeVP1RYBC0bhHlikg==
X-Google-Smtp-Source: APXvYqzARUXWGq6q8/hYIVYeT219CiA8uTD6iRPTxw6rj46PxQ9tfJpySmwAjxlwp+nKTX+Z1+8Oi64X31H+Yk76o9E=
X-Received: by 2002:a5d:9d83:: with SMTP id 3mr2768462ion.65.1559228704949;
 Thu, 30 May 2019 08:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190529202728.GA35103@gmail.com> <CAKv+Gu-4KqcY=WhwY98JigTzeXaL5ggYEcu7+kNzNtpO2FLQXg@mail.gmail.com>
 <VI1PR04MB44459EEF7BCD3458BB3D143D8C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <20190530133427.qrwjzctac2x6nsby@gondor.apana.org.au> <VI1PR04MB444562A2352FE4BAD7F681258C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <CAKv+Gu-jTWQP0Zp=QpuzX41v8Eb5Bvd0O9ajwSnFkDO-ijBf_A@mail.gmail.com>
 <CAKv+Gu9JoC+GKJ6mMAE25mr_k2gbznh-83jApT4=FZsAW=jd8w@mail.gmail.com>
 <20190530142734.qlhgzeal22zxfhk5@gondor.apana.org.au> <CAKv+Gu8jJQCZwiHFORUJUzRaAizWzBQ95EAgYe36sFrcvzb6vg@mail.gmail.com>
 <CAKv+Gu-KBgiyNY2Dypx6vqtmpTXNfOxxWxJf50BTiF2rCOFqnw@mail.gmail.com> <20190530143438.d62y3woaogyivqpm@gondor.apana.org.au>
In-Reply-To: <20190530143438.d62y3woaogyivqpm@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 30 May 2019 17:04:51 +0200
Message-ID: <CAKv+Gu87wkLkZZLfsJwc02yuKpDx7Sa=Nx+1YW8pPE4DoWXGRw@mail.gmail.com>
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

On Thu, 30 May 2019 at 16:34, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, May 30, 2019 at 04:31:09PM +0200, Ard Biesheuvel wrote:
> >
> > This might work:
>
> Looks good to me.
>

Thanks Herbert,

But given your remark regarding CBC being the only algo that has this
requirement, I wonder if this might be sufficient as well.

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index c0ece44f303b..65b050e3742f 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -1844,7 +1844,7 @@ static int skcipher_decrypt(struct skcipher_request *req)
         * The crypto API expects us to set the IV (req->iv) to the last
         * ciphertext block.
         */
-       if (ivsize)
+       if (ctx->cdata.algtype & OP_ALG_AAI_CBC)
                scatterwalk_map_and_copy(req->iv, req->src, req->cryptlen -
                                         ivsize, ivsize, 0);


Iulia, Horia?
