Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C916130F29
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 10:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAFJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 04:04:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFJEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:04:14 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DAA320848;
        Mon,  6 Jan 2020 09:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578301454;
        bh=2T/IcjbkOHO/nbGiktbih+oHmImSaEhme8PH3bc9v8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUllN6QNxoHcL8Cko5cs4rKDUfBh/YoFXNgjsBdaFLjVdCxObwFVN9jvjFfKa/dBt
         u6lTWHglQil3QW8a4vASyONSrILmvmCSDeL/QSYrEvKNDe5h8nm3Flb82YHAks7Fzb
         qtLlNhW30qVIdnc3Ik6xwK70jZ0tM7YsahduBerQ=
Date:   Mon, 6 Jan 2020 10:04:11 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sunxi: Use macros for references to CCU clocks
Message-ID: <20200106090411.hw4udmcnib6nqk7w@gilmour.lan>
References: <20200106085933.9102-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sc3mdfowvd7zmesw"
Content-Disposition: inline
In-Reply-To: <20200106085933.9102-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sc3mdfowvd7zmesw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2020 at 04:59:33PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> A few clocks from the CCU were exported later, and references to them in
> the device tree were using raw numbers.
>
> Now that the DT binding header changes are in as well, switch to the
> macros for more clarity.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--sc3mdfowvd7zmesw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhL4CwAKCRDj7w1vZxhR
xZOwAP4n9OEN+HnYL9FmZxQz44MnBDFImasSN5aYsXQVAUR5+AD/QZVKLL8yTKn6
tjghlB4J0hPcflW0X9vDCXzc5YD+zQ0=
=fo7i
-----END PGP SIGNATURE-----

--sc3mdfowvd7zmesw--
