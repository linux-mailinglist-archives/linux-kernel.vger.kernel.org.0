Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95764F44B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 10:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFVIT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 04:19:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37996 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfFVIT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 04:19:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9B4E780641; Sat, 22 Jun 2019 10:19:43 +0200 (CEST)
Date:   Sat, 22 Jun 2019 10:19:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     linux-rt-users@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Cc:     mwhitehe@redhat.com
Subject: PREEMPT_RT_FULL on x86-32 machine
Message-ID: <20190622081954.GA10751@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Is full preemption supposed to work on x86-32 machines?

Because it does not work for me. It crashes early in boot, no messages
make it to console. Similar configuration for x86-64 boots ok.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0N5KoACgkQMOfwapXb+vLL3ACfYdFNE/2j8TtFhMdFMIBE3NkQ
ubEAn1cIiuJM7MuSpTMT2zpeBzwVPEQW
=9u/C
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
