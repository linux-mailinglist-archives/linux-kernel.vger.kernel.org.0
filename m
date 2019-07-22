Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4970B85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbfGVVfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfGVVfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:35:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 910D321900;
        Mon, 22 Jul 2019 21:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563831319;
        bh=DvqIagaTKeWXpuKwat8d9RWOAli9dQa8fn58FFzhj2I=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=GAGVTPyolP5awe7fywjEGXSa+BDWuSSTnWBWAsVtU+GauWTmbacpuxNHMdreyY0QN
         EzQzfqEkaMrycQ3qhWZuX9MbqqicKiRXSufriuxCYMpk8r1iiXujFYdWxPoyQ9eL4f
         9wYmo7SCdgmoiQUleXveC1Ek57aXrsPWQ/3sK3bs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190627222220.89175-1-nhuck@google.com>
References: <20190627222220.89175-1-nhuck@google.com>
Subject: Re: [PATCH] clk: rockchip: Fix -Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>, andy.yan@rock-chips.com,
        heiko@sntech.de, mturquette@baylibre.com, zhangqing@rock-chips.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:35:18 -0700
Message-Id: <20190722213519.910D321900@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Huckleberry (2019-06-27 15:22:20)
> Clang produces the following warning
>=20
> drivers/clk/rockchip/clk-rv1108.c:125:7: warning: unused variable
> 'mux_pll_src_3plls_p' [-Wunused-const-variable]
> PNAME(mux_pll_src_3plls_p)      =3D { "apll", "gpll", "dpll" };
>=20
> Looks like this variable was never used. Deleting it to remove the
> warning.
>=20
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/524
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  drivers/clk/rockchip/clk-rv1108.c | 1 -
>  1 file changed, 1 deletion(-)

Heiko, can you pick this up? Looks like v5.4 material.

>=20
> diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk=
-rv1108.c
> index 96cc6af5632c..5947d3192866 100644
> --- a/drivers/clk/rockchip/clk-rv1108.c
> +++ b/drivers/clk/rockchip/clk-rv1108.c
> @@ -122,7 +122,6 @@ PNAME(mux_usb480m_pre_p)    =3D { "usbphy", "xin24m" =
};
>  PNAME(mux_hdmiphy_phy_p)       =3D { "hdmiphy", "xin24m" };
>  PNAME(mux_dclk_hdmiphy_pre_p)  =3D { "dclk_hdmiphy_src_gpll", "dclk_hdmi=
phy_src_dpll" };
>  PNAME(mux_pll_src_4plls_p)     =3D { "dpll", "gpll", "hdmiphy", "usb480m=
" };
> -PNAME(mux_pll_src_3plls_p)     =3D { "apll", "gpll", "dpll" };
>  PNAME(mux_pll_src_2plls_p)     =3D { "dpll", "gpll" };
>  PNAME(mux_pll_src_apll_gpll_p) =3D { "apll", "gpll" };
>  PNAME(mux_aclk_peri_src_p)     =3D { "aclk_peri_src_gpll", "aclk_peri_sr=
c_dpll" };
