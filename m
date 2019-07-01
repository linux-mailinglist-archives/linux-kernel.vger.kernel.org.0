Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99252594
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfFYH46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 03:56:58 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55117 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfFYH46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:56:58 -0400
X-Originating-IP: 90.88.16.156
Received: from localhost (aaubervilliers-681-1-41-156.w90-88.abo.wanadoo.fr [90.88.16.156])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 53E2020003;
        Tue, 25 Jun 2019 07:56:55 +0000 (UTC)
Date:   Tue, 25 Jun 2019 09:56:54 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v2 08/15] dt-bindings: display: Convert
 raspberrypi,7inch-touchscreen panel to DT schema
Message-ID: <20190625075654.igm2yveodkpzays4@flea>
References: <20190624215649.8939-1-robh@kernel.org>
 <20190624215649.8939-9-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mq7niu5ik2hotkzq"
Content-Disposition: inline
In-Reply-To: <20190624215649.8939-9-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mq7niu5ik2hotkzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2019 at 03:56:42PM -0600, Rob Herring wrote:
> Convert the raspberrypi,7inch-touchscreen panel binding to DT schema.
>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mq7niu5ik2hotkzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXRHTxgAKCRDj7w1vZxhR
xRiuAQC0hhwO4GcEwR2wlvS/0Zkgwy5BmuSOS80WbeehE6oCzQD+MNGVXo4UvKZm
0uBgdxhxrT0uaxpYu1Qs16nyUld7IwI=
=cKd6
-----END PGP SIGNATURE-----

--mq7niu5ik2hotkzq--
