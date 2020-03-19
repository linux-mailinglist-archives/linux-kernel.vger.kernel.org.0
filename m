Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECCF18C0EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 20:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgCST6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 15:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgCST6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:58:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EBF7206D7;
        Thu, 19 Mar 2020 19:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584647933;
        bh=yCgZtR0DYZus2gadAfCLRdCWgaBH+dubDXrtA7e0syk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=wt+e1Pu9k2l9WmnnuMKWY/ZpKF2D2PIKWz9jfDOywCBDxERi7SNrsjsKvnNegbA2Y
         VePqK5sSsMk+BumN+On6CYElmEs/gRcxt7ccNq769W0L//9MoN9+Si0znmJFO/yPwC
         qvQ8YH4jGExtV3XX4SZVCX2/O4gqvGNe3vVvN4AI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584502004-11349-1-git-send-email-Anson.Huang@nxp.com>
References: <1584502004-11349-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH] clk: imx: clk-pllv3: Use readl_poll_timeout() for PLL lock wait
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        allison@lohutok.net, festevam@gmail.com, gustavo@embeddedor.com,
        kernel@pengutronix.de, kstewart@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Date:   Thu, 19 Mar 2020 12:58:52 -0700
Message-ID: <158464793223.152100.9637932949695874103@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-03-17 20:26:44)
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index df91a82..3dfa9c3 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -53,23 +56,14 @@ struct clk_pllv3 {
> =20
>  static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
>  {
> -       unsigned long timeout =3D jiffies + msecs_to_jiffies(10);
>         u32 val =3D readl_relaxed(pll->base) & pll->power_bit;
> =20
>         /* No need to wait for lock when pll is not powered up */
>         if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
>                 return 0;
> =20
> -       /* Wait for PLL to lock */
> -       do {
> -               if (readl_relaxed(pll->base) & BM_PLL_LOCK)
> -                       break;
> -               if (time_after(jiffies, timeout))
> -                       break;
> -               usleep_range(50, 500);
> -       } while (1);
> -
> -       return readl_relaxed(pll->base) & BM_PLL_LOCK ? 0 : -ETIMEDOUT;
> +       return readl_poll_timeout(pll->base, val, val & BM_PLL_LOCK, 500,

Did you want to use readl_relaxed_poll_timeout() to keep it the same as
before?
