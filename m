Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0BEC52587
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 09:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfFYH4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 03:56:07 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48097 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfFYH4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:56:04 -0400
X-Originating-IP: 90.88.16.156
Received: from localhost (aaubervilliers-681-1-41-156.w90-88.abo.wanadoo.fr [90.88.16.156])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3F05720004;
        Tue, 25 Jun 2019 07:56:02 +0000 (UTC)
Date:   Tue, 25 Jun 2019 09:56:00 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 07/15] dt-bindings: display: Convert pda,91-00156-a0
 panel to DT schema
Message-ID: <20190625075600.bqk7si7ljrp3wziv@flea>
References: <20190624215649.8939-1-robh@kernel.org>
 <20190624215649.8939-8-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tetcemb75nz6lnkc"
Content-Disposition: inline
In-Reply-To: <20190624215649.8939-8-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tetcemb75nz6lnkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2019 at 03:56:41PM -0600, Rob Herring wrote:
> Convert the pda,91-00156-a0 panel binding to DT schema.
>
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

--tetcemb75nz6lnkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXRHTkAAKCRDj7w1vZxhR
xbsHAQC+DItZS8FM/IwhhvjelXnaAO1PLBHqZkJhMjEYsWx2ZAEA05KkRSEAsqUQ
xN5fn1gOLC4Ji1f0HZpTRyEo8fAcwQQ=
=KgYT
-----END PGP SIGNATURE-----

--tetcemb75nz6lnkc--
