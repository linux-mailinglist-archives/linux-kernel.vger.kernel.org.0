Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D334525C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 09:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfFYH7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 03:59:41 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42111 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYH7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:59:40 -0400
X-Originating-IP: 90.88.16.156
Received: from localhost (aaubervilliers-681-1-41-156.w90-88.abo.wanadoo.fr [90.88.16.156])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AFAAE2000A;
        Tue, 25 Jun 2019 07:59:35 +0000 (UTC)
Date:   Tue, 25 Jun 2019 09:59:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 15/15] dt-bindings: display: Convert sgd,gktw70sdae4se
 panel to DT schema
Message-ID: <20190625075935.4ef2mzl76mlizjnp@flea>
References: <20190624215649.8939-1-robh@kernel.org>
 <20190624215649.8939-16-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="onlutkut64entdkv"
Content-Disposition: inline
In-Reply-To: <20190624215649.8939-16-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--onlutkut64entdkv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2019 at 03:56:49PM -0600, Rob Herring wrote:
> Convert the sgd,gktw70sdae4se LVDS panel binding to DT schema.
>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--onlutkut64entdkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXRHUZwAKCRDj7w1vZxhR
xV/JAQDrtyxrlc/Nc1tMDabXU99BXYhMByY/MAp40gX6juTCuAEAiJ5SUCAQESfU
Bz9zBCs6MmfGSRIG39vioqCrTkZjuQg=
=M7Ux
-----END PGP SIGNATURE-----

--onlutkut64entdkv--
