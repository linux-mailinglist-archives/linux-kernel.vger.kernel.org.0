Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5712057F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 13:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfLPMXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 07:23:01 -0500
Received: from foss.arm.com ([217.140.110.172]:53358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfLPMXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:23:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB851FB;
        Mon, 16 Dec 2019 04:23:00 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE57D3F719;
        Mon, 16 Dec 2019 04:22:59 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:22:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add the broadmobi BM818
Message-ID: <20191216122258.GC4161@sirena.org.uk>
References: <20191214235550.31257-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20191214235550.31257-1-angus@akkea.ca>
X-Cookie: Backed up the system lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 14, 2019 at 03:55:48PM -0800, Angus Ainslie (Purism) wrote:

> Angus Ainslie (Purism) (2):
>   sound: codecs: gtm601: add Broadmobi bm818 sound profile
>   dt-bindings: sound: gtm601: add the broadmobi interface

As I said in reply to v1:

| These subject styles don't even agree with each other :( - please
| try to be consistent with the style for the subsystem (the latter
| one matches, the first one doesn't).

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl33dyEACgkQJNaLcl1U
h9CPKwf/Yi58Hf8HxHeOBIXk0Y27oK1tnQS/WvB4x3RVFfqXyikECz5ERE6pdUzc
5fpXeRbxwO7kTznK/2YE6aP0S332ZVMhxt3nG/BqJLSjn/a6EzSFGQ6jiHSQ1Kvj
YqGNOyPONPfN37I4h5j6oviotmeLr2QhhL7wySQsifL9L21S/xVVyy3lj6H8HgS/
e6AqlPkavFIEW3OaGI3Tj9x1iO4TG8tadg+2IlggE46MZunxvlXhrQuLwPxeZSQ5
65revyyoOPDRbDHMIOVaK/v2598LDohjgKyxRXD2IXiiz2X48IHcT71f6vSk+Bo2
YcUYhAEeMUrSq5ZwzcvtJl2vV2clFA==
=B/1w
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
