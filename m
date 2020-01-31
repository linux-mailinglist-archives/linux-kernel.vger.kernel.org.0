Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D23214F4C6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 23:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgAaWfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 17:35:50 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:43308 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgAaWft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:35:49 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4F0551C013F; Fri, 31 Jan 2020 23:35:48 +0100 (CET)
Date:   Fri, 31 Jan 2020 23:35:47 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] why do sensors break CPU scaling
Message-ID: <20200131223547.GA7334@amd>
References: <CAKR_QVLJZPDfjbQ4CBDv62ok0qG4jq_M_Baq6eaot6GzrKMMwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <CAKR_QVLJZPDfjbQ4CBDv62ok0qG4jq_M_Baq6eaot6GzrKMMwA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-11-20 21:42:12, Tom Psyborg wrote:
> Hi
>=20
> Recently I've needed to set lowest CPU scaling profile, running ubuntu
> 16.04.06 I used standard approach - echoing powersave to
> /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor.
> This did not work as the
> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq kept returning
> max scaling freq.

Noone noticed, right?

If you still believe that's problem, you may want to look at
MAINTAINERS file, and put sensors maintainers in the Cc list.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl40q8MACgkQMOfwapXb+vJC2wCgg6aFeVxgxtj/2DxjkAZEJaRe
MTIAoJ1V1hU3Cx0adxgbKTsR52KOBi94
=dIT1
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
