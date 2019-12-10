Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB071183CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 10:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfLJJlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 04:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfLJJlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:41:00 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17C0C20663;
        Tue, 10 Dec 2019 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575970859;
        bh=rXiWjC0C2pFz1m1mewguEYBdET4p356PjzRIiT7GIUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDP1G8eLXvPf0sI3iSZYCxkxoqJvjl2n3kbJn7lyM0D5dRe1+clfrVAWUPiaav6WF
         Ls6hYNAVCMMjMifHG+8zCjYmu214bWZiezN+ADSJtrRcDH3h9B6lFzhli4aUcduplT
         uzmlvvhstSKU/wIJENKW+HHFzmaqY604Fj8Ofhk4=
Date:   Tue, 10 Dec 2019 10:40:57 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: dts: allwiner: Fix typo in dual licensed
 SPDX identifier
Message-ID: <20191210094057.ojenu74cmjcuaq73@gilmour.lan>
References: <20191209182024.20509-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q5d4baoofanzj4pg"
Content-Disposition: inline
In-Reply-To: <20191209182024.20509-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q5d4baoofanzj4pg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2019 at 07:20:22PM +0100, Cl=E9ment P=E9ron wrote:
> With dual licensed SPDX identifier the "OR" should
> be uppercase.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied, thanks!
Maxime

--q5d4baoofanzj4pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXe9oKQAKCRDj7w1vZxhR
xX4DAPwNlr4EMNiMHoyTLLO0bo5xLU9WWV6hkoT9iI+1hdNtCQEA9dm44ukjGX+g
sTQyp0ZoJFLctSwVzyuLipTN/0glfAw=
=G1aM
-----END PGP SIGNATURE-----

--q5d4baoofanzj4pg--
