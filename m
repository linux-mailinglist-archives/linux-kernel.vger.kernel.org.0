Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A6E82B6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 08:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfJ2HsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 03:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfJ2HsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:48:24 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A9820862;
        Tue, 29 Oct 2019 07:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572335303;
        bh=Yu5s0hQzqtyqOCX0ElU27rS01B1OF21zXuTqphIPMvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzcG/Usrchf0OzEMrzzNBk9R5H8WV7Kk7nXNpnooqHRDKujaFd1i0dgtmzC8Klhoq
         Gj9Z2pZO7sJG/FCuelXEtwI9NBd6YKTmBmQOIZHhyZ14jAVWOHkdbfC+1LfkkJ5EA+
         O2zbKeG2VRh1PLl1JHScOWwuCYt4+fgDiuM/+RTM=
Date:   Tue, 29 Oct 2019 08:43:08 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] clk: sunxi: Fix operator precedence in
 sunxi_divs_clk_setup
Message-ID: <20191029074308.ll2nyv3ksuqdgxru@hendrix>
References: <20191022165054.48302-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3wgn7swzd7gzkmpp"
Content-Disposition: inline
In-Reply-To: <20191022165054.48302-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3wgn7swzd7gzkmpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2019 at 09:50:54AM -0700, Nathan Chancellor wrote:
> r375326 in Clang exposes an issue with operator precedence in
> sunxi_div_clk_setup:
>
> drivers/clk/sunxi/clk-sunxi.c:1083:30: warning: operator '?:' has lower
> precedence than '|'; '|' will be evaluated first
> [-Wbitwise-conditional-parentheses]
>                                                  data->div[i].critical ?
>                                                  ~~~~~~~~~~~~~~~~~~~~~ ^
> drivers/clk/sunxi/clk-sunxi.c:1083:30: note: place parentheses around
> the '|' expression to silence this warning
>                                                  data->div[i].critical ?
>                                                                        ^
>                                                                       )
> drivers/clk/sunxi/clk-sunxi.c:1083:30: note: place parentheses around
> the '?:' expression to evaluate it first
>                                                  data->div[i].critical ?
>                                                                        ^
>                                                  (
> 1 warning generated.
>
> It appears that the intention was for ?: to be evaluated first so that
> CLK_IS_CRITICAL could be added to clkflags if the critical boolean was
> set; right now, | is being evaluated first. Add parentheses around the
> ?: block to have it be evaluated first.
>
> Fixes: 9919d44ff297 ("clk: sunxi: Use CLK_IS_CRITICAL flag for critical clks")
> Link: https://github.com/ClangBuiltLinux/linux/issues/745
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied, thanks!
Maxime

--3wgn7swzd7gzkmpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbftjAAKCRDj7w1vZxhR
xaQ2AP9CAH4GHD2NPmz/Ed6cj1lbVOW1bpx4owgNtUPvu1oBnQEAtbgqPANSedSI
HKisluN+sAyzMlF1MdHXWRebPyalEAM=
=asjM
-----END PGP SIGNATURE-----

--3wgn7swzd7gzkmpp--
