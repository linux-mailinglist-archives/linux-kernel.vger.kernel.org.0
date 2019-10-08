Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3FF8CF24F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 07:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfJHF6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 01:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfJHF6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 01:58:13 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 057DA206BB;
        Tue,  8 Oct 2019 05:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570514292;
        bh=OKUgYROz7lxc7E9/7Ur7efZbYs8IQ81R9gApIpjwp9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7J5cK1mBB5fvQZ0ThE4YCz7Qur4Fw909mYvNTRLpboW6BubXmXiGCIDVT0T+7y+g
         qpfWg9TOv0RucK+/Wve187tlBEXxO4YONvuJdDEAFmh8lbNhSrcoBHyHWPyArcc5v2
         4/axwyD+PUb+vlHhzw5ryeI4HqtheN6u1Z+gorl8=
Date:   Tue, 8 Oct 2019 07:58:10 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     megous@megous.com
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH 0/2] Add bluetooth support for Orange Pi 3
Message-ID: <20191008055810.wqkmoy63ujiagbfe@gilmour>
References: <20191007203152.3889947-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ert3szapvjumxzbc"
Content-Disposition: inline
In-Reply-To: <20191007203152.3889947-1-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ert3szapvjumxzbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2019 at 10:31:50PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> (Re-send for Maxime, with already applied patches dropped. Nothing new.)
>
> This series implements bluetooth support for Xunlong Orange Pi 3 board.
>
> The board uses AP6256 WiFi/BT 5.0 chip.
>
> Summary of changes:
>
> - add more delay to let initialize the chip
> - let the kernel detect firmware file path
> - add new compatible and update dt-bindings
> - update Orange Pi 3 / H6 DTS
>
> Please take a look.

Applied both, thanks!
Maxime

--ert3szapvjumxzbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZwlcQAKCRDj7w1vZxhR
xfZYAP9SMxqaZn19ntY7023We3X+5/xContSlxTodlVbXkTQCQEAghM2VObtw49u
Q9P7kQeTJcnIsIbJNFymmtSCVdx+sA0=
=ZikW
-----END PGP SIGNATURE-----

--ert3szapvjumxzbc--
