Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8EB415A8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 13:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBLMPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 07:15:35 -0500
Received: from foss.arm.com ([217.140.110.172]:60412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLMPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:15:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AE0C30E;
        Wed, 12 Feb 2020 04:15:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF2993F6CF;
        Wed, 12 Feb 2020 04:15:33 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:15:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     alsa-devel@alsa-project.org, cychiang@chromium.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, helen.koike@collabora.com,
        ezequiel@collabora.com, kernel@collabora.com, dafna3@gmail.com,
        devicetree@vger.kernel.org, groeck@chromium.org,
        enric.balletbo@collabora.com, lgirdwood@gmail.com,
        bleung@chromium.org
Subject: Re: [PATCH] dt-bindings: Convert the binding file
 google,cros-ec-codec.txt to yaml format.
Message-ID: <20200212121532.GG4028@sirena.org.uk>
References: <20200127091806.11403-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline
In-Reply-To: <20200127091806.11403-1-dafna.hirschfeld@collabora.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2020 at 10:18:06AM +0100, Dafna Hirschfeld wrote:
> This was tested and verified with:
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5D7GMACgkQJNaLcl1U
h9D4SAf6AjL0TX0sVgucqWJPIx7KXl9BR5SqhCtnhvVTCrO9gBGH1rDgqrceW9mr
rNnvjv/icmNV+WzKIK3YT5VCuA4zI0JfH2qKTSNIkmdwm1bWcKhN8kCHtRidRdUE
zBn1wZFT98tB9kgZy9tE/LWgy4olgLrOlMJLHJwGwLL7dSnmSpOrmmeRD10y6Sz1
9RFMa5kkyP9+dvtw9mbVlQu0gFIN2frqZQvItoEAKhhbplyvAkLhtSc1MPwcZxGS
8nKtAXcFuS0hF4di6QYp0luIzzA+c97yD/ZFWBQ0jlRs2MW97ULQSGwnbxeKczk4
tGO4KAFmg1JSGYaQ7ziiVc9xJau0LQ==
=qBkG
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
