Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE9184F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 19:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCMSz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 14:55:58 -0400
Received: from foss.arm.com ([217.140.110.172]:34896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCMSz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:55:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E2D431B;
        Fri, 13 Mar 2020 11:55:57 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 967893F534;
        Fri, 13 Mar 2020 11:55:56 -0700 (PDT)
Date:   Fri, 13 Mar 2020 18:55:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: google,cros-ec-codec: Fix dtc
 warnings in example
Message-ID: <20200313185555.GM5528@sirena.org.uk>
References: <20200313180543.20497-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EOHJn1TVIJfeVXv2"
Content-Disposition: inline
In-Reply-To: <20200313180543.20497-1-robh@kernel.org>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EOHJn1TVIJfeVXv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2020 at 01:05:43PM -0500, Rob Herring wrote:
> Extra dtc warnings (roughly what W=1 enables) are now enabled by default
> when building the binding examples. These were fixed treewide in
> 5.6-rc5, but the newly added google,cros-ec-codec schema adds some new
> warnings:

v1 got applied, could you send an incremental diff please?

--EOHJn1TVIJfeVXv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5r1zoACgkQJNaLcl1U
h9A9xQf8D4qo5BE4kR0B6Xezo7p/pdK91FrKE6y5FfQTFK+hVGgN3ysMlWcUxwsR
hB1NLaFz/0f4w9iHu+vqbd3kZVt6WleRvq/MLJEVI+JHQEIKLfr+XGch+30iPwM7
lKwLR6O4N0XXDzXAQfXtsM/mP2NQo5iyEtlXIVAn7FI04zuzIuYu+TvU8XxhWn1P
OTg9c/D0/5P3fakLSPHFFVRTRnNBqgVrI+zh4P+Be4JNjRniOnUBLooa5hu0pWWE
+FyalDVC07RI/LTubgW+S2fkxk5HVjNIgrgOwYkd9sCFvshCO+3D/J8bYRnnRNub
Uxrn3/ec7Vd/yXBu2B0gpAQyqI8K5Q==
=pQ/m
-----END PGP SIGNATURE-----

--EOHJn1TVIJfeVXv2--
