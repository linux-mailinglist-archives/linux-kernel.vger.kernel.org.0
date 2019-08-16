Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC249070A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 19:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfHPRgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 13:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfHPRgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:36:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 491082086C;
        Fri, 16 Aug 2019 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565976973;
        bh=sNq0ZIrjqyjv9St1Tf5KuLvW39QxNdAcBWHz6ktST40=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m4OaQKNgfU6xahKExwpvjNk54djLgfZJfU9mMXq7vKSbqzdUDrtmQBNr2fxG5DpS1
         pHZA/rgHUEcugY+gWqf/s+DCZRA+ZVjBGLNPsIkzQF7gEkgue7+A7y0cZLmqjAjPCC
         dYNLd2aZ48t5CTprKS6l2JR7nLAl0vtl3Y3uF87M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816135523.73520-1-yuehaibing@huawei.com>
References: <20190816135523.73520-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: st: clkgen-pll: remove unused variable 'st_pll3200c32_407_a0'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, allison@lohutok.net,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:36:12 -0700
Message-Id: <20190816173613.491082086C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-08-16 06:55:23)
> drivers/clk/st/clkgen-pll.c:64:37: warning:
>  st_pll3200c32_407_a0 defined but not used [-Wunused-const-variable=3D]
>=20
> It is never used, so can be removed.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Adding Gabriel, please ack/review.

>  drivers/clk/st/clkgen-pll.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
> index d8a688b..c3952f2 100644
> --- a/drivers/clk/st/clkgen-pll.c
> +++ b/drivers/clk/st/clkgen-pll.c
> @@ -61,19 +61,6 @@ static const struct clk_ops stm_pll3200c32_ops;
>  static const struct clk_ops stm_pll3200c32_a9_ops;
>  static const struct clk_ops stm_pll4600c28_ops;
> =20
> -static const struct clkgen_pll_data st_pll3200c32_407_a0 =3D {
> -       /* 407 A0 */
> -       .pdn_status     =3D CLKGEN_FIELD(0x2a0,   0x1,                   =
 8),
> -       .pdn_ctrl       =3D CLKGEN_FIELD(0x2a0,   0x1,                   =
 8),
> -       .locked_status  =3D CLKGEN_FIELD(0x2a0,   0x1,                   =
 24),
> -       .ndiv           =3D CLKGEN_FIELD(0x2a4,   C32_NDIV_MASK,         =
 16),
> -       .idf            =3D CLKGEN_FIELD(0x2a4,   C32_IDF_MASK,          =
 0x0),
> -       .num_odfs =3D 1,
> -       .odf            =3D { CLKGEN_FIELD(0x2b4, C32_ODF_MASK,          =
 0) },
> -       .odf_gate       =3D { CLKGEN_FIELD(0x2b4, 0x1,                   =
 6) },
> -       .ops            =3D &stm_pll3200c32_ops,
> -};
> -
>  static const struct clkgen_pll_data st_pll3200c32_cx_0 =3D {
>         /* 407 C0 PLL0 */
>         .pdn_status     =3D CLKGEN_FIELD(0x2a0,   0x1,                   =
 8),
