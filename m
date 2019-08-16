Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA859070C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfHPRg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 13:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfHPRgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:36:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BB2205F4;
        Fri, 16 Aug 2019 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565977015;
        bh=H48S/CA93Omk0k4dddTo7LUNcjaMGkCVnW9f3YMLMEc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=H1Qd015wCTMALiQeiq+Y8cwE2h9kWgPwRfR5Z5Jg/CO12fETUddqzHwTKJc7D/Grv
         cKPFtrvxG3w3mitpQzGYFbalnls7VfA1VVZSpwAfgVD12JtFETlvEzSBuc4i2rFBE+
         +3hrOOh1EfePsVwRWWKKm5tj7X1IXDpwEbwJGQ/w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816135341.52248-1-yuehaibing@huawei.com>
References: <20190816135341.52248-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: st: clkgen-fsyn: remove unused variable 'st_quadfs_fs660c32_ops'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, info@metux.net,
        mturquette@baylibre.com, robh@kernel.org,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:36:54 -0700
Message-Id: <20190816173655.17BB2205F4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-08-16 06:53:41)
> drivers/clk/st/clkgen-fsyn.c:70:29: warning:
>  st_quadfs_fs660c32_ops defined but not used [-Wunused-const-variable=3D]
>=20
> It is never used, so can be removed.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Adding Gabriel, please ack/review.

>  drivers/clk/st/clkgen-fsyn.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
> index ca1ccdb..a156bd0 100644
> --- a/drivers/clk/st/clkgen-fsyn.c
> +++ b/drivers/clk/st/clkgen-fsyn.c
> @@ -67,7 +67,6 @@ struct clkgen_quadfs_data {
>  };
> =20
>  static const struct clk_ops st_quadfs_pll_c32_ops;
> -static const struct clk_ops st_quadfs_fs660c32_ops;
> =20
>  static int clk_fs660c32_dig_get_params(unsigned long input,
>                 unsigned long output, struct stm_fs *fs);
