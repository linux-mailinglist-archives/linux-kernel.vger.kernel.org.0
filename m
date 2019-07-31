Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E697BC38
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 10:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfGaIuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 04:50:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40792 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfGaIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:50:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so68708061wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwsVvn8wa45bBL0kmpXm8dE+dK3L/asxmBE1PcKU6TI=;
        b=Bc7NcOiJ5ur5yWb8Vm1EekyHADoSSZ4yQYMor9UK1cjaU5nrLpgp0SmtmLXSWoCPEN
         oiRopDXzheg2qnqg1lVm22qMA/cI2erdJbrdYbrVe17W0y9dIu+Ih2t/Ld1BE+guR+Ki
         aIz8ZqRujPKICvzrT05iXLF7sRshRT+8Oc+BH25l24EKgl1B7WN8uDQuGsaoEWzbHBsI
         gFimbd+shhkf9k9zlgB6v/lUSa4eYsxuPTXBSu6uP3mcrG8UOYtWrUvbmSkr/TRMBDtq
         hAeJNzNuvqslO+6Od+YCCQSnMgShnD95JykVdPMvoRy075nos6fgDhqcH7qQxQKrmNWL
         sipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwsVvn8wa45bBL0kmpXm8dE+dK3L/asxmBE1PcKU6TI=;
        b=iX0CWRdObfH87oYKSmNGupREp/ztcTz1+T0xZBnxBrAdHTA0U6VC1xKcAhnnLm6qQY
         KNI2iCZ4t5NDIE31dCTd53c1Mwepb6dSIsLR0JMF9FGXRbv+NtBlRx9uaXEaIzPLU7XR
         6MMN4dE+TXQ+ryJtDfeZSCw9KXDP78xlmiI/fa+YYrYyTC0wpUe1GJa999LTJD+TkAUi
         h1FMCN8I/tZEH5L+av7aejWpcl8kKcVynnQpZBsHqLwG6x/Cp4sK6TN3anYVLomjdK+U
         5xgRkksyXvrD2jYiswa+LWGGEOCyfBlDUs3Q/CBp6Do+g4GyWgzZhkQXrq9Qad13dwAt
         VNPw==
X-Gm-Message-State: APjAAAXcUEOJ/7/hmeKNY/oybuBlun94GlYerrqzM5ATPuYmewSDUeFZ
        nG7r6C3+1/Tgmdti2wVtNNhpNL3JhEuI3+BOhaHuWA==
X-Google-Smtp-Source: APXvYqzdMl1kziBM4CxJXiGSgYq/6b+CB7ylpvJ4dhXM4kEs2n2F5RQ+y+S2b/osFdyjAZvY3q7a+1Pd5rp4RjJGFwE=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr137884595wrs.93.1564563022820;
 Wed, 31 Jul 2019 01:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <1564482824-26581-1-git-send-email-iuliana.prodan@nxp.com>
 <1564482824-26581-3-git-send-email-iuliana.prodan@nxp.com>
 <CAKv+Gu_VEEZFPpJfv2JbB02vhmc_1_wpxNDBHf__pv-t7BvN0A@mail.gmail.com> <VI1PR04MB4445AABC9062673BD4FA3CEF8CDF0@VI1PR04MB4445.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4445AABC9062673BD4FA3CEF8CDF0@VI1PR04MB4445.eurprd04.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 31 Jul 2019 11:50:11 +0300
Message-ID: <CAKv+Gu8KcL_Q_C+euZ9DOT7VEX68CJZJLrT8hxeCiiiEkxQ=jQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] crypto: aes - helper function to validate key
 length for AES algorithms
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 at 11:35, Iuliana Prodan <iuliana.prodan@nxp.com> wrote:
>
> On 7/31/2019 8:33 AM, Ard Biesheuvel wrote:
> > On Tue, 30 Jul 2019 at 13:33, Iuliana Prodan <iuliana.prodan@nxp.com> wrote:
> >>
> >> Add inline helper function to check key length for AES algorithms.
> >> The key can be 128, 192 or 256 bits size.
> >> This function is used in the generic aes implementation.
> >>
> >> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> >> ---
> >>   include/crypto/aes.h | 17 +++++++++++++++++
> >>   lib/crypto/aes.c     |  8 ++++----
> >>   2 files changed, 21 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/crypto/aes.h b/include/crypto/aes.h
> >> index 8e0f4cf..8ee07a8 100644
> >> --- a/include/crypto/aes.h
> >> +++ b/include/crypto/aes.h
> >> @@ -31,6 +31,23 @@ struct crypto_aes_ctx {
> >>   extern const u32 crypto_ft_tab[4][256] ____cacheline_aligned;
> >>   extern const u32 crypto_it_tab[4][256] ____cacheline_aligned;
> >>
> >> +/*
> >> + * validate key length for AES algorithms
> >> + */
> >> +static inline int crypto_aes_check_keylen(unsigned int keylen)
> >
> > Please rename this to aes_check_keylen()
> >
> I just renamed it to crypto_, the first version was check_aes_keylen
> - see https://patchwork.kernel.org/patch/11058869/.
> I think is better to keep the helper functions with crypto_, as most of
> these type of functions, in crypto, have this prefix.
>

The AES library consists of

aes_encrypt
aes_decrypt
aes_expandkey

and has no dependencies on the crypto API, which is why I omitted the
crypto_ prefix from the identifiers. Please do the same for this
function.
.


> >> +{
> >> +       switch (keylen) {
> >> +       case AES_KEYSIZE_128:
> >> +       case AES_KEYSIZE_192:
> >> +       case AES_KEYSIZE_256:
> >> +               break;
> >> +       default:
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   int crypto_aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
> >>                  unsigned int key_len);
> >>
> >> diff --git a/lib/crypto/aes.c b/lib/crypto/aes.c
> >> index 4e100af..3407b01 100644
> >> --- a/lib/crypto/aes.c
> >> +++ b/lib/crypto/aes.c
> >> @@ -187,11 +187,11 @@ int aes_expandkey(struct crypto_aes_ctx *ctx, const u8 *in_key,
> >>   {
> >>          u32 kwords = key_len / sizeof(u32);
> >>          u32 rc, i, j;
> >> +       int err;
> >>
> >> -       if (key_len != AES_KEYSIZE_128 &&
> >> -           key_len != AES_KEYSIZE_192 &&
> >> -           key_len != AES_KEYSIZE_256)
> >> -               return -EINVAL;
> >> +       err = crypto_aes_check_keylen(key_len);
> >> +       if (err)
> >> +               return err;
> >>
> >>          ctx->key_length = key_len;
> >>
> >> --
> >> 2.1.0
> >>
> >
>
