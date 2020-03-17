Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2D1879B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 07:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgCQGcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 02:32:02 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36964 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCQGcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:32:01 -0400
Received: by mail-vk1-f193.google.com with SMTP id o124so5648909vkc.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 23:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7D9+8roi8O3TeKz6nEq8STv16d4uRSSfD9jY/ASGWns=;
        b=WtESIAqnRWuUMQ1cxmuRHtXxSyZndEPLV2wPdMTWA4tUxLDbl/eMBnSKflkAg/1wX7
         2FvBn/z0hqAAo2d+/iU0Wj5HubfbnxAqUYC8SpKGJgbj3EogCvMvXBZL0K/Tbu//n29C
         T1XHLx3BTbPwm83+NIEnhlU8Rc1XdwMfe+1udfazKTDe/iAl43YPNvNZa7n+RI1zH5dg
         bZrvsZ8BgBsgJNuWKK2czPzv//8IdwTBD5j3jMz/HJedhhmkUlGXFxzO88Atpc+d5r88
         U81lqqp/9IczBihQWCdqpCO0p46DgF8I23hN76LUfDc/6V0h2porFGVfe3Bik6qIAE0z
         Buvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7D9+8roi8O3TeKz6nEq8STv16d4uRSSfD9jY/ASGWns=;
        b=MufaccWrSPPbXkOUKnU+v8NQtDZ7nEKjKpY/j10+5nPi7jwET/cvXdCTaw/A2ZsTnZ
         QVMLvIm5zY+3H8ZmqCR8Glqy1aXa2vucGghRPMX3OURVvhvP02dvIJ+m7ORUUMdI/0Xw
         yWi56Citw4GdStPARBlwjHS4ZI3Vic0K9aIdCoD9ezVhysKzMUsT/FbG9OsPmHbTUqWA
         zS3gGsjlXrWkWRm7prDGGd8PyJrbQKGvIuxP+/Ycm6fQdNZ8oLzaCBbsAMIHBOEeoJVY
         9gNm2NVwpZ00VSlS4t13A4hOAAzgFScgj4ckUb+juws2a3aUqBfGDpEb03fNNvs2ni6Q
         zUcg==
X-Gm-Message-State: ANhLgQ3RgkpSF5cvTJbHhw/u/hEhhkHkEqTzyeRJ/oT9PQalBsrK7NB1
        /H4hDe479FY4sShVmGS3Gwi9vxpV++5T5+eCBQ89Eg==
X-Google-Smtp-Source: ADFU+vv90lQSzb2m1ezsF8gLU4Zu6GOEknT8yK97+bEJC1+F0mE21aCtLNF+4fUEcGxTO8B1QbEX0XfNTTS8hZ6Zdko=
X-Received: by 2002:a1f:a617:: with SMTP id p23mr2679392vke.2.1584426718347;
 Mon, 16 Mar 2020 23:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200216085928.108838-1-tianjia.zhang@linux.alibaba.com> <20200216085928.108838-8-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200216085928.108838-8-tianjia.zhang@linux.alibaba.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Tue, 17 Mar 2020 08:31:45 +0200
Message-ID: <CAOtvUMdn+92vbEZ=V=e7PSuKwP3b1K==jFKjVWopVqJdfXzZxA@mail.gmail.com>
Subject: Re: [PATCH 7/7] X.509: support OSCCA sm2-with-sm3 certificate verification
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>,
        zohar@linux.ibm.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 16, 2020 at 11:00 AM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> The digital certificate format based on SM2 crypto algorithm as
> specified in GM/T 0015-2012. It was published by State Encryption
> Management Bureau, China.
>
> The method of generating Other User Information is defined as
> ZA=3DH256(ENTLA || IDA || a || b || xG || yG || xA || yA), it also
> specified in https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02.
>
> The x509 certificate supports sm2-with-sm3 type certificate
> verification.  Because certificate verification requires ZA
> in addition to tbs data, ZA also depends on elliptic curve
> parameters and public key data, so you need to access tbs in sig
> and calculate ZA. Finally calculate the digest of the
> signature and complete the verification work. The calculation
> process of ZA is declared in specifications GM/T 0009-2012
> and GM/T 0003.2-2012.
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  crypto/asymmetric_keys/public_key.c      | 61 ++++++++++++++++++++++++
>  crypto/asymmetric_keys/x509_public_key.c |  2 +
>  include/crypto/public_key.h              |  1 +
>  3 files changed, 64 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys=
/public_key.c
> index d7f43d4ea925..a51b09ee484d 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -17,6 +17,11 @@
>  #include <keys/asymmetric-subtype.h>
>  #include <crypto/public_key.h>
>  #include <crypto/akcipher.h>

hmmm... ifdefs like these are kind of ugly.

> +#ifdef CONFIG_CRYPTO_SM2
> +#include <crypto/sm3_base.h>
> +#include <crypto/sm2.h>
> +#include "x509_parser.h"
> +#endif
>
>  MODULE_DESCRIPTION("In-software asymmetric public-key subtype");
>  MODULE_AUTHOR("Red Hat, Inc.");
> @@ -245,6 +250,54 @@ static int software_key_eds_op(struct kernel_pkey_pa=
rams *params,
>         return ret;
>  }
>
> +#ifdef CONFIG_CRYPTO_SM2
> +static int cert_sig_digest_update(const struct public_key_signature *sig=
,
> +                               struct crypto_akcipher *tfm_pkey)
> +{
> +       struct x509_certificate *cert =3D sig->cert;
> +       struct crypto_shash *tfm;
> +       struct shash_desc *desc;
> +       size_t desc_size;
> +       unsigned char dgst[SM3_DIGEST_SIZE];
> +       int ret;
> +
> +       if (!cert)
> +               return -EINVAL;
> +
> +       ret =3D sm2_compute_z_digest(tfm_pkey, SM2_DEFAULT_USERID,
> +                                       SM2_DEFAULT_USERID_LEN, dgst);
> +       if (ret)
> +               return ret;
> +
> +       tfm =3D crypto_alloc_shash(sig->hash_algo, 0, 0);
> +       if (IS_ERR(tfm))
> +               return PTR_ERR(tfm);
> +
> +       desc_size =3D crypto_shash_descsize(tfm) + sizeof(*desc);
> +       desc =3D kzalloc(desc_size, GFP_KERNEL);
> +       if (!desc)
> +               goto error_free_tfm;
> +
> +       desc->tfm =3D tfm;
> +
> +       ret =3D crypto_shash_init(desc);
> +       if (ret < 0)
> +               goto error_free_desc;
> +
> +       ret =3D crypto_shash_update(desc, dgst, SM3_DIGEST_SIZE);
> +       if (ret < 0)
> +               goto error_free_desc;
> +
> +       ret =3D crypto_shash_finup(desc, cert->tbs, cert->tbs_size, sig->=
digest);
> +
> +error_free_desc:
> +       kfree(desc);
> +error_free_tfm:
> +       crypto_free_shash(tfm);
> +       return ret;
> +}
> +#endif
> +
>  /*
>   * Verify a signature using a public key.
>   */
> @@ -298,6 +351,14 @@ int public_key_verify_signature(const struct public_=
key *pkey,
>         if (ret)
>                 goto error_free_key;
>

OK, how about you put cert_sig_digest_update() in a separate file that
only gets compiled with  CONFIG_CRYPTO_SM2 and have a static inline
version that returns -ENOTSUPP otherwise?
or at least something in this spirit.
Done right it will allow you to drop the ifdefs and make for a much
cleaner code.

> +#ifdef CONFIG_CRYPTO_SM2
> +       if (strcmp(sig->pkey_algo, "sm2") =3D=3D 0) {
> +               ret =3D cert_sig_digest_update(sig, tfm);
> +               if (ret)
> +                       goto error_free_key;
> +       }
> +#endif
> +
>         sg_init_table(src_sg, 2);
>         sg_set_buf(&src_sg[0], sig->s, sig->s_size);
>         sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric=
_keys/x509_public_key.c
> index d964cc82b69c..feccec08b244 100644
> --- a/crypto/asymmetric_keys/x509_public_key.c
> +++ b/crypto/asymmetric_keys/x509_public_key.c
> @@ -30,6 +30,8 @@ int x509_get_sig_params(struct x509_certificate *cert)
>
>         pr_devel("=3D=3D>%s()\n", __func__);
>
> +       sig->cert =3D cert;
> +
>         if (!cert->pub->pkey_algo)
>                 cert->unsupported_key =3D true;
>
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 0588ef3bc6ff..27775e617e38 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -44,6 +44,7 @@ struct public_key_signature {
>         const char *pkey_algo;
>         const char *hash_algo;
>         const char *encoding;
> +       void *cert;             /* For certificate */
>  };
>
>  extern void public_key_signature_free(struct public_key_signature *sig);
> --
> 2.17.1
>


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
