Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4823F11CD0F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 13:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfLLMXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 07:23:23 -0500
Received: from foss.arm.com ([217.140.110.172]:44958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbfLLMXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:23:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D9DA30E;
        Thu, 12 Dec 2019 04:23:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09DAF3F718;
        Thu, 12 Dec 2019 04:23:20 -0800 (PST)
Date:   Thu, 12 Dec 2019 12:23:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alison Wang <alison.wang@nxp.com>
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] ASoC: sgtl5000: Revert "ASoC: sgtl5000: Fix of
 unmute outputs on probe"
Message-ID: <20191212122318.GB4310@sirena.org.uk>
References: <20191212071847.45561-1-alison.wang@nxp.com>
 <CAGgjyvHHzPWjRTqxYmGCmk3qa6=kOezHywVDFomgD6UNj-zwpQ@mail.gmail.com>
 <VI1PR04MB40627CDD5F0C17D8DCDCFFE2F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <VI1PR04MB4062C67906888DA8142C17E1F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <CAGgjyvGAjx1SV=K66AM24DxMTA_sAF2uhhDw5gXCFTGNZi8E7Q@mail.gmail.com>
 <VI1PR04MB40620DD55D5ED0FDC3E94C2BF4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <VI1PR04MB40620DD55D5ED0FDC3E94C2BF4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
X-Cookie: We have DIFFERENT amounts of HAIR --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2019 at 10:46:31AM +0000, Alison Wang wrote:

> We tested this standard solution using gstreamer and standard ALSA
> tools like aplay, arecord and all these tools unmute needed blocks
> successfully.

> [Alison Wang] I am using aplay. Do you mean I need to add some parameters for aplay or others to unmute the outputs?

Use amixer.

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3yMTUACgkQJNaLcl1U
h9DfQgf/UmK1hCqXQ85LvYqgXxbKAXGRaIWJQyk8azVa0DIaUG4sgOjQFvfpKX8P
r94b8kOksV/gWPash/q1AALZ//I78/lV4+0FPABth+o6k5f3XEWYiUkHuzCubsdE
RUNiZCQzCyZdASR3lK0utcaowMt+ME8UsOShQD2h5kvwiA8MmbSdoRs12UP2BXE7
LafeLJJXlf+CsKc/ut2ql8YerxereMdmHYqd4zM0Xx0W9csLJTdDEdvp2cX0tFK+
2ZXI/o+8ntVZ2fDbkG3zwTmS5SOfryA3iwhwSJDNfO8CfOaIfOJD7vFjDz8BhQPq
TpnqW1d4Z9+IuEuiWykpI5NWLEJaRg==
=2Ya4
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
