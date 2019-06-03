Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1CE5329C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 09:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfFCHkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 03:40:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54503 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:40:06 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0B8918028B; Mon,  3 Jun 2019 09:39:53 +0200 (CEST)
Date:   Mon, 3 Jun 2019 09:40:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: 5.2: display corruption on X60, X220
Message-ID: <20190603074004.GA15821@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In recent kernels (5.2.0-rc1-next-20190522, 5.2-rc2) I'm getting
display corruption in X. Usually in terminals, but also in title bars
etc. Black areas with white lines in them, usually...

Same configuration worked properly in ... probably 4.19? Then I got
some graphics-crashes on X220 that prevented me from testing :-(.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz0ztQACgkQMOfwapXb+vL3XgCfdrfE5/QIhmIwNFjA9gbc+rDp
hBUAoKIsXX5K+hFq8BY4AdpAgJ/o6xgj
=k0n+
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
