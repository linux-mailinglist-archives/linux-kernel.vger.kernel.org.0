Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89221143911
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAUJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:06:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUJGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:06:38 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BE9920882;
        Tue, 21 Jan 2020 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579597597;
        bh=SMoJPN5+FqZ0+fUWKubh3YgmqpeACLh4FHRRGsFD+gY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQFjR9hA3rph4sQuXuYQtJJFNRCsB3psfENTzdtbWz6uhCtZtdY3ZROoI1IaKN8t9
         GlpOekS2uB6xZb921y6plLdlFF+L1olXSTJ5RIJanaNacPRvEax4r9OyKVWjbRZLW4
         WyxaIGvotM8at2dcW/660tihti61GX/ogOij8AT8=
Date:   Tue, 21 Jan 2020 10:06:35 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/9] arm64: dts: allwinner: pinebook: Make simplefb more
 consistent
Message-ID: <20200121090635.ebr54xw7gecvvpce@gilmour.lan>
References: <20200119163104.13274-1-samuel@sholland.org>
 <20200119163104.13274-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wldyhqwusn2zbrwl"
Content-Disposition: inline
In-Reply-To: <20200119163104.13274-5-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wldyhqwusn2zbrwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 19, 2020 at 10:31:00AM -0600, Samuel Holland wrote:
> Boards generally reference the simplefb nodes from the SoC dtsi by
> label, not by full path. simplefb_hdmi is already like this in the
> Pinebook DTS. Update simplefb_lcd to match.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--wldyhqwusn2zbrwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXia/GwAKCRDj7w1vZxhR
xeC9AP96PAb0ObZ8Xdyoot2Jwfnbz6i+1pLLT4ac2qO1rqLerwD9GYw/ILdszhgA
4TJXvHZ8JCiIzN6Cy/cFctpM09+ofAY=
=448p
-----END PGP SIGNATURE-----

--wldyhqwusn2zbrwl--
