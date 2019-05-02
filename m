Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 202EB11434
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 09:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfEBHeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 03:34:09 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:53735 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfEBHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:34:08 -0400
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 3CEE9100004;
        Thu,  2 May 2019 07:34:01 +0000 (UTC)
Date:   Thu, 2 May 2019 09:34:01 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Enable HDMI output on
 orangepi 3
Message-ID: <20190502073401.3l3fl4alicyzpud7@flea>
References: <20190420145240.27400-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nv5oljssjzww6su7"
Content-Disposition: inline
In-Reply-To: <20190420145240.27400-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nv5oljssjzww6su7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 20, 2019 at 10:52:40AM -0400, Yangtao Li wrote:
> Orangepi 3 has HDMI type A connector.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Queued for 5.3, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nv5oljssjzww6su7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMqdaQAKCRDj7w1vZxhR
xXqZAP4tbnGzQV6Jk98qWsvV1/w+soaYKRpbASqKB73wDlgm6gD+LpEWCz0timxH
p1G91jZIsbeBMkQwQtT1LUZuiVZReAw=
=3M6T
-----END PGP SIGNATURE-----

--nv5oljssjzww6su7--
