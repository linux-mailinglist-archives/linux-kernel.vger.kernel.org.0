Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D7F1957BB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 14:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgC0NIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 09:08:00 -0400
Received: from foss.arm.com ([217.140.110.172]:44442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgC0NIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:08:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA6981FB;
        Fri, 27 Mar 2020 06:07:59 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CBD53F71F;
        Fri, 27 Mar 2020 06:07:59 -0700 (PDT)
Date:   Fri, 27 Mar 2020 13:07:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matt Flax <flatmax@flatmax.org>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        alsa-devel@alsa-project.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Takashi Iwai <tiwai@suse.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: bcm2835-i2s: substream alignment now independent
 in hwparams
Message-ID: <20200327130758.GB4437@sirena.org.uk>
References: <20200324090823.20754-1-flatmax@flatmax.org>
 <d0684926-3f7a-0b97-a298-4088925442a4@flatmax.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <d0684926-3f7a-0b97-a298-4088925442a4@flatmax.org>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2020 at 10:56:50AM +1100, Matt Flax wrote:
>=20
> Should this patch be handled through the ALSA team the R. Pi team or the =
BCM
> team ?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl59+q0ACgkQJNaLcl1U
h9AFaAf8Db5emY6EIgD03k5HjtM3kTn5ueFcW3VvYyJOfS7/qgx6q8JE7eDFaqgr
/61tuP3BmQ08KYkA8TZtvHwOLc+3wjJi/Q/HDpwApmbcfy6LuA34oepLk+wKI5ik
Os9ZiKsPjYKVKZZ9wVxrXHuVNaveCinKAqz7EU69s48kFbX054Ios83q6poKazm/
KFnesj0pCLINvrFrXboSoKmhIzLHV6kxMAgO9qmd9mjJictyenNGoNnmk7fsdiM9
QW/Pjs2YYg58/IOanTmz7OoxAgce3k3/TJRNnS7gRtyktNCcrC85CJkANzHtOst7
cvwcNrA0SRrKj0A5IfwNhv1BSK2+/A==
=NOmu
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
