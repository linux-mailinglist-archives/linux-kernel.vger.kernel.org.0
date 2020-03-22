Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED8718EA36
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 17:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCVQSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 12:18:18 -0400
Received: from sauhun.de ([88.99.104.3]:51386 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgCVQSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:18:18 -0400
Received: from localhost (p54B33042.dip0.t-ipconnect.de [84.179.48.66])
        by pokefinder.org (Postfix) with ESMTPSA id A62F12C0064;
        Sun, 22 Mar 2020 17:18:16 +0100 (CET)
Date:   Sun, 22 Mar 2020 17:18:16 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     erico.nunes@datacom.ind.br, dan.carpenter@oracle.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: KASAN: i2c dev use after free
Message-ID: <20200322161816.GB6766@ninjato>
References: <CADYN=9KkjPSP4KJ+AzG=Njq49zJ5fbWNZ4V_jOvHkq_kt0biyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <CADYN=9KkjPSP4KJ+AzG=Njq49zJ5fbWNZ4V_jOvHkq_kt0biyA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I think patch introduced this issue d6760b14d4a1 ("i2c: dev: switch
> from register_chrdev to cdev API")
> and patch e6be18f6d62c ("i2c: dev: use after free in detach") tried to solve it.
> However, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled it delays
> the ->release callback to make sure that anything that is done in release can
> be done later than it happens in normal execution.
> The cdev structure is supposed to be freed in the remove callback or after it,
> but here it has already been freed by the put_i2c_dev().

For the record, Kevin Hao fixed it and it is now in linux-next as:
1413ef638aba ("i2c: dev: Fix the race between the release of i2c_dev and cdev")

Thanks, Kevin!


--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl53j8gACgkQFA3kzBSg
KbbJ0w/+KxfnJmP8fsZdM3HROAtMRqlHltteP4XVBZDLt+jjvRD3qng93F4nPg6d
JEch2PurElj6AQC5AsK2rN9flYW+Of/jFZZS4Su8/hFb5FkeH+3aSSQMK8kJnYkQ
XJj6D2MEtPkTCnv5HY+lg9d25T037vZQO2gQgBm8HfciUcC3VF0iK7yxbZuqyOHF
rF1JT8SbFas6motZJj4CJwinVkfVRmDnKivmMdiv/qRrjxJyrRlmbJJSQjgc0z38
Sd1kgsCgUJGtCBVINQG3HONmjkKddXjJB1kE/d5DarpDrg8ho0r1bY1tLaI0QXLw
OnGPFLOTp2I0DPDWE47hSM1Gb3xn3U/KDvbw3OnmXuOWi1zIDv0sv2mPOZfpYuJT
v/e2nqJknK57wG3Jr7PnwfVSl1o/JvJ82avnTm+PCRSvEDSS5ZIg6m4Veu9P8S/X
qYhosU/XwVbA0Y90AoZD3BZS3MWgZap5A9Q77jndGA6vARyZPTB9RDGbcuhKCLBs
Nq1EkZg91PJKjgF1ugt0WjNuS6kij8Q59cnDstteq2ll+hDhua4MstDBBqcmAqNO
pkEg/qwxBbNdpqBpNrjf3HzkWWnwea6gavn2pBOGOZOlw1m65EoWv1tOzl38aqA1
pJLq/5Zu4a8z1cpavXVxAOXV22WQrjPaUcRNXedho8S+Vx9e/vE=
=hqfi
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
