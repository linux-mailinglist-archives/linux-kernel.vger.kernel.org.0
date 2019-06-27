Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DBF57E22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfF0IUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 04:20:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfF0IUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:20:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ZCW273B7z9sCJ;
        Thu, 27 Jun 2019 18:19:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561623599;
        bh=rZRtC35dTZyajk6qe/MkHpr18BsNPivaoNvodamU3es=;
        h=Date:From:To:Cc:Subject:From;
        b=kN7pKH351+2ozC5lN9t3EmBwPHPwerYQ6h+cdluz8Xp+JIIudCEBKRiQXvsDUyPLt
         bF7nD876FtfGil265PkznvXiNwsYCUOVwZpc1DTmJ3+fQW2EH1OT4NCGxPv/nV9BBV
         mEYrkNJXh0EgZ3Pp+2V1jN3kE5Br6aH+nOvXeN+JwHyfu5KtFIynwqawWBlSX6ecua
         6jFdNGLBF2ISwE14wREbp7Sce9nwaASx6Khc6bWu6HLtRNxsi0/UBLf5t0bZvBVlU2
         U9J8L1HlXCpOzvlHGjmmbB/gPoyL7Ttjuv01Dk/AbMiUIe6IWqVucS84GM2JSCH3E8
         kdJVTV2NxO8mg==
Date:   Thu, 27 Jun 2019 18:19:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Enrico Weigelt <info@metux.net>
Subject: linux-next: build warning after merge of the gpio tree
Message-ID: <20190627181941.1222cb9c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eYESiSBjIFD9pDcUJ1F12Ae"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eYESiSBjIFD9pDcUJ1F12Ae
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the gpio tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/gpio/gpio-amd-fch.c: In function 'amd_fch_gpio_probe':
drivers/gpio/gpio-amd-fch.c:171:49: warning: passing argument 2 of 'devm_io=
remap_resource' discards 'const' qualifier from pointer target type [-Wdisc=
arded-qualifiers]
  priv->base =3D devm_ioremap_resource(&pdev->dev, &amd_fch_gpio_iores);
                                                 ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/platform_device.h:13,
                 from drivers/gpio/gpio-amd-fch.c:15:
include/linux/device.h:708:15: note: expected 'struct resource *' but argum=
ent is of type 'const struct resource *'
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *r=
es);
               ^~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  9bb2e0452508 ("gpio: amd: Make resource struct const")

--=20
Cheers,
Stephen Rothwell

--Sig_/eYESiSBjIFD9pDcUJ1F12Ae
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0UfB0ACgkQAVBC80lX
0GyfjQgAoEvg0Gzp0+SpBdL3yMOkzOo2TBUKKUnT6EGAyI4CeKwWEQx0jBGYTZop
EOOVwSOcTZm/t3fr1hajF2rgmpFbtQOd9T0BcphNjKrUV6bPbY4cIF1U8yxTuHuk
KviR1OrmMHQw7muu2PvsUveBAyPDJY6TCYh0T4xfFS0NWfgc9X8YBXqjGSHVzViG
AsVvJHxNzTzZNhoC6HesyGUi9x79jNRfhdtLmyYsLWN3qySjV3shSvmMpHOfkAUp
K+APHXrEYzFWJg4jG+NqO1Br7vDA/gWYDuyCiKg12KdhXBUomKj5kU5ivCf5rxD/
TvMllhRlJ2jvZ85OiyUAewz6UrNIiQ==
=sWCI
-----END PGP SIGNATURE-----

--Sig_/eYESiSBjIFD9pDcUJ1F12Ae--
