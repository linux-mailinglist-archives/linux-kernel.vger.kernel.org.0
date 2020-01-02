Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56AFF12E524
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 11:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgABKzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 05:55:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:32798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgABKzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:55:22 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B76215A4;
        Thu,  2 Jan 2020 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577962521;
        bh=ukjU++godUoDpWkY61biU/lQXD6lUfIOlYlnf1ANUOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yzRfRP/ugZJwE3CCES4EvFu+akRgcakQsgYvpTbxeCgpSMThfu6KhS1CdGgiKRzHY
         n0CEda8Ar5AbKHkQpRYMSjGUSBT82TXFG4MJO2tz3L/JC1sf9bbgd/UEbmdzX+67VJ
         JCFwKX5fm1sHbUr76wiGL4iYWzqVdYe+Uv61QoJo=
Date:   Thu, 2 Jan 2020 11:55:19 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 3/9] ARM: dts: sun8i: r40: Use tcon top clock index
 macros
Message-ID: <20200102105519.cvpcwvjyig5dztan@gilmour.lan>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
 <20191231130528.20669-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oj6tgo2qqefryvgl"
Content-Disposition: inline
In-Reply-To: <20191231130528.20669-4-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oj6tgo2qqefryvgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2019 at 06:35:22PM +0530, Jagan Teki wrote:
> tcon_tv0, tcon_tv1 nodes have a clock names of tcon-ch0,
> tcon-ch1 which are referring tcon_top clocks via index
> numbers like 0, 1 with CLK_TCON_TV0 and CLK_TCON_TV1
> respectively.
>
> Use the macro in place of index numbers, for more code
> readability.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks
Maxime

--oj6tgo2qqefryvgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg3MFwAKCRDj7w1vZxhR
xXAuAQDcI/HjKTyNWSYjBIfy/Ni4nla+VO45v3aSQ3cBZPTx0AEA5Ofb6egNlD0b
Tq7ayXPuXNzgqUXGPC45HIFkDi7I+gw=
=OC9E
-----END PGP SIGNATURE-----

--oj6tgo2qqefryvgl--
