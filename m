Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A758611C091
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 00:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLKXa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 18:30:28 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35426 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfLKXa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:30:28 -0500
Received: by mail-ot1-f67.google.com with SMTP id o9so451574ote.2;
        Wed, 11 Dec 2019 15:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wo2DrsPScaqWz/406hvbFYY2i2G774jt9t2caPRqht4=;
        b=WG+kAyWhgZduGDz1I263pCUNhTioDwTPtlcDogpt0fuuEj02mg9GbRaLUG8M4vXrSX
         SKkS3h22vI1lmaWEoLEuyUXFPktrN4xG7YYgD/MmOOGH83jZnr+pjK8jfI8ustPyGiLJ
         y3jVqAjYVrIS+knqYk67SKk3/IaX2uyo6w1QojI8p/fo0AZ7VHuauWc+1WxQeKeg1VUf
         Rzf59N4VMLshrcp1q1Ru4s3tBw10XBtx9tRvJREq7uCaLtLw5F96DHJU3V0+hrIJkRth
         cl2ttp+xaQB0bsPFhZD+ACO8GDU10cFazN/xsB2R7MS6NDaHA30YUdoRAMYHMM5VRSrU
         dXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wo2DrsPScaqWz/406hvbFYY2i2G774jt9t2caPRqht4=;
        b=l/ez91o3w6fR+Le3MQY8ZD1zgbJXsDSMK2VYVN7MTjsuUolAVqcbHxhg/bMFFS23+I
         eFjWhkh+wmJRNmS4Xs6c5kouPdxGPajfbvyA9+hii01UVJk3NQYZPGwzPyaMFIPu9vfG
         Ez2tHt1GhjE0Pn4K2z8IwhKjgd/c+tdZUEcJynwZn+SRUsAhsNCxhCUy+U9GqkxoBoAd
         ovkVZvU387qr1/8EKWs4u1tLBvsm+fKOQPhFoWNEXirWL5L3MaGmszKliV8WFEOQ7LVY
         j2XwDCtcqhWd9Coyk+5Zxd/H0OWp1HiCBmYmvUHxm6G0vOcn28VFVHJYsIM8Rg48BOZh
         9KJA==
X-Gm-Message-State: APjAAAV74eP60y8UcFqGNHdPY20uNbhWvkaB/2eOvJNbJHEMQA9znaI3
        FcjJtqwtlp+5FIsfOW2R2R42sS/AAqOwJHJoYzk=
X-Google-Smtp-Source: APXvYqySbfqFjtZckmVvrGyt+TLd55uZV4QCvovifobxpRMKv6OFRut/+vfst3rusYBBQhpUVUpr7xggySRPe8lIiLY=
X-Received: by 2002:a05:6830:2087:: with SMTP id y7mr4371038otq.96.1576107027197;
 Wed, 11 Dec 2019 15:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20191211084112.971-1-linux.amoon@gmail.com> <a4610efc-844a-2d43-5db1-cf813102e701@baylibre.com>
 <CANAwSgQOTA0mSvFW5otaCzFPHidhY7VFcrXZHjCD-1XkQpcx3w@mail.gmail.com>
 <20191211095043.3kngq7wh77xvadge@gondor.apana.org.au> <CANAwSgR-fT21uBSP747MVkXf2GYqm_6kcne059pX-OegftLSZA@mail.gmail.com>
 <CAKv+Gu8HQ7RY9WSYZrLUR7tNjuybF5sp7xe94VLQpJrDSRg4NA@mail.gmail.com> <1229236701.11947072.1576070229564@mail.yahoo.com>
In-Reply-To: <1229236701.11947072.1576070229564@mail.yahoo.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 12 Dec 2019 00:30:15 +0100
Message-ID: <CAFBinCAxq-uW+gsmb-8wqxHGXt2W+4w9iD++2fL=FQ7S-RsAkw@mail.gmail.com>
Subject: Re: [PATCHv1 0/3] Enable crypto module on Amlogic GXBB SoC platform
To:     Anand Moon <moon.linux@yahoo.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Wed, Dec 11, 2019 at 2:17 PM Anand Moon <moon.linux@yahoo.com> wrote:
[...]
> Sorry once again I send my logs too early.
> I still having some issue with the Hardware glx cryto module.
I'm surprised to see that you managed to get the GXL crypto driver to
load at all on GXBB
as far as I know GXBB uses an older crypto IP block (BLKMV) than GXL
(and newer SoCs, called "DMA"): [0]

so my understanding is that a new crypto driver is needed for GXBB
(BLKMV registers) support.
the 32-bit SoCs use the same BLKMV IP block as far as I can tell, so
these would also benefit from this other driver.
(I don't know if anyone is working on a BLKMV crypto driver - all I
can tell is that I'm not working on one)


Martin


[0] https://github.com/khadas/linux/blob/195ea69f96d9bddc1386737e89769ff350762aea/drivers/amlogic/crypto/Kconfig
