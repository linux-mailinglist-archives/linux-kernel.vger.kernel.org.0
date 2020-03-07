Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D06B17D05E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 22:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgCGV42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 16:56:28 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:37852 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgCGV42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 16:56:28 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D891E1C0315; Sat,  7 Mar 2020 22:56:25 +0100 (CET)
Date:   Sat, 7 Mar 2020 22:56:25 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH] platform/x86: GPD pocket fan: Fix error message when
 temp-limits are out of range
Message-ID: <20200307215625.GA487@duo.ucw.cz>
References: <20200306091724.55347-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20200306091724.55347-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-03-06 10:17:24, Hans de Goede wrote:
> Commit 1f27dbd8265d ("platform/x86: GPD pocket fan: Allow somewhat
> lower/higher temperature limits") changed the module-param sanity check
> to accept temperature limits between 20 and 90 degrees celcius.
>=20
> But the error message printed when the module params are outside this
> range was not updated. This commit updates the error message to match
> the new min and max value for the temp-limits.
>=20
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pavel Machek <pavel@denx.de>

Thanks!
							Pavel
						=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXmQYiQAKCRAw5/Bqldv6
8tb+AJ4yBCrpbQGEn2I8MQXX4qFv032j5wCfUVKB/C9JdupHUXxdBbUMQtxtnCI=
=k0AH
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
