Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011F212F620
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 10:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgACJh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 04:37:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACJh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 04:37:28 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121A821734;
        Fri,  3 Jan 2020 09:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578044247;
        bh=t1n4osX8UFyfzagbobo+KoZCptgIJ8gvbeKetytczeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6+N5bPGQlNhV1gyvOOg2A1ukTS7rQlhfNWi+c/GaXeqQYGYgRzbiDrVw9GctGa3P
         BDAjdvQDi8XqZV/vhzmGC8cCssXQwvcTd1Lv0QDXWUzKaoTfKCCeGhCebE7SY6VmSy
         mM3QibPSZ/Z5n5vQSCNzCYvjKYD01jayq8lpO9co=
Date:   Fri, 3 Jan 2020 10:37:24 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: r40: Export MBUS clock
Message-ID: <20200103093724.qo2enqqpr5dzcvfc@gilmour.lan>
References: <20200103071848.3977-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ydtg2u437jgrsyi"
Content-Disposition: inline
In-Reply-To: <20200103071848.3977-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ydtg2u437jgrsyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 03, 2020 at 03:18:48PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> The MBUS clock needs to be referenced in the MBUS device node.
> Export it.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks
Maxime

--6ydtg2u437jgrsyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg8LVAAKCRDj7w1vZxhR
xTXyAPwOmHJ3brL7yUfKmR5he70BqWy5MhxZQ3ik2vpHkUxeEwD9F58DhQY/DVl+
PPeLEWk09d1ZxePABfHlBOoPLFXWXAQ=
=vkyJ
-----END PGP SIGNATURE-----

--6ydtg2u437jgrsyi--
