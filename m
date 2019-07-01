Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D68FEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfD3RWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 13:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3RWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:22:04 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9104320651;
        Tue, 30 Apr 2019 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556644923;
        bh=SmFNb1ua+pwzkuk1hPJ8TEAJrM4sAOs7Zi6tdPANKsM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=nvOY5bIky4wf3Wq9N+PdSJrtbecc4fsjvmALGQsSjf2l385xnNnATIl8XjG1q1jW9
         5o30qPmHOB9rpVnhh2czYvp1MWDCpSRTDqcl0zkzzumM93sXoUc15iunCEfi5QPGkI
         oJi3gQbSrQu2HKxhBq/u1yLI1tN7WxZFiqQ6oF7c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190430143206.GA4035@embeddedor>
References: <20190430143206.GA4035@embeddedor>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: imx: clk-pllv3: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <155664492283.168659.5604495418413396919@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 30 Apr 2019 10:22:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2019-04-30 07:32:06)
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>=20
> This patch fixes the following warnings:
>=20
> drivers/clk/imx/clk-pllv3.c: In function =E2=80=98imx_clk_pllv3=E2=80=99:
> drivers/clk/imx/clk-pllv3.c:446:18: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>    pll->div_shift =3D 1;
>    ~~~~~~~~~~~~~~~^~~
> drivers/clk/imx/clk-pllv3.c:447:2: note: here
>   case IMX_PLLV3_USB:
>   ^~~~
> drivers/clk/imx/clk-pllv3.c:453:21: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>    pll->denom_offset =3D PLL_IMX7_DENOM_OFFSET;
>                      ^
> drivers/clk/imx/clk-pllv3.c:454:2: note: here
>   case IMX_PLLV3_AV:
>   ^~~~
>=20
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>=20
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

It was sent by Anson already.

