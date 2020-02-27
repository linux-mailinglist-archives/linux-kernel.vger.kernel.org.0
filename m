Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20F1172201
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 16:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgB0PPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 10:15:20 -0500
Received: from foss.arm.com ([217.140.110.172]:53416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbgB0PPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:15:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 746D830E;
        Thu, 27 Feb 2020 07:15:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEDA43F7B4;
        Thu, 27 Feb 2020 07:15:18 -0800 (PST)
Date:   Thu, 27 Feb 2020 15:15:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     tangbin <tangbin@cmss.chinamobile.com>
Cc:     jun.nie@linaro.org, shawnguo@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zte:zx-spdif:remove redundant dev_err message
Message-ID: <20200227151517.GC4062@sirena.org.uk>
References: <20200227150701.15652-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <20200227150701.15652-1-tangbin@cmss.chinamobile.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 11:07:01PM +0800, tangbin wrote:
> devm_ioremap_resource has already contains error message, so remove
> the redundant dev_err message

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5X3QQACgkQJNaLcl1U
h9ClgQgAhVigaSedyPLajRpUX2vIOrqhnhTyoVj19iSU3QJ1uooXc/UR/CSyoPqA
cAz7Zl8hPiUmn4OaNu6331KZE6ihk5m19Qmw0KUoSvR5GqbJ5gIRwoEYeVeeBiZf
uB2oaosHLC0Y+f9rRdZIyj0jIBRC+aHcJX0l4Pjw1QMfilofa+LGhYa2/WUGexHp
0WrgNwrjSgAWDm5MN3xeR4GVd2u8cIKnmomA3u13VJDfAlIgNJCm+u9IKcteYc8W
m3BywhwFNs76Kbh9uqxWV6jhHdFok3McPs42ZgO7Sj7MOTZm8Usp6aqhCjesVVwX
hb5zdSpVV2CkMeQ9lz6oiDDjHjs2Fg==
=RASF
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
