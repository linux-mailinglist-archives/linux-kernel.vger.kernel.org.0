Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F39B9FB0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 22:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfIUUck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 16:32:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57752 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfIUUck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 16:32:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DCD22807C7; Sat, 21 Sep 2019 22:32:23 +0200 (CEST)
Date:   Sat, 21 Sep 2019 22:32:37 +0200
From:   Pavel Machek <pavel@denx.de>
To:     pavel@denx.de
Cc:     linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Craig Gallek <kraig@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.19 10/79] udp: correct reuseport selection with
 connected sockets
Message-ID: <20190921203237.GB14868@amd>
References: <20190919214807.612593061@linuxfoundation.org>
 <20190919214808.734045565@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20190919214808.734045565@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Fri 2019-09-20 00:02:55, Greg Kroah-Hartman wrote:
> From: Willem de Bruijn <willemb@google.com>
>=20
> [ Upstream commit acdcecc61285faed359f1a3568c32089cc3a8329 ]
>=20
> UDP reuseport groups can hold a mix unconnected and connected sockets.
> Ensure that connections only receive all traffic to their 4-tuple.
>=20
> Fast reuseport returns on the first reuseport match on the assumption
> that all matches are equal. Only if connections are present, return to
> the previous behavior of scoring all sockets.
>=20
> Record if connections are present and if so (1) treat such connected
> sockets as an independent match from the group, (2) only return
> 2-tuple matches from reuseport and (3) do not return on the first
> 2-tuple reuseport match to allow for a higher scoring match later.
>=20
> New field has_conns is set without locks. No other fields in the
> bitmap are modified at runtime and the field is only ever set
> unconditionally, so an RMW cannot miss a change.

That's an ... extremely tricky game with concurrent access. I'm pretty
sure it is not valid C, but maybe it is acceptable for kernel.

> --- a/include/net/sock_reuseport.h
> +++ b/include/net/sock_reuseport.h
> @@ -21,7 +21,8 @@ struct sock_reuseport {
>  	unsigned int		synq_overflow_ts;
>  	/* ID stays the same even after the size of socks[] grows. */
>  	unsigned int		reuseport_id;
> -	bool			bind_inany;
> +	unsigned int		bind_inany:1;
> +	unsigned int		has_conns:1;

But should it at least be commented here? If someone adds another int :1,
he may get a surprise...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2GiOUACgkQMOfwapXb+vLb6wCggDl0JjSzuLuVv0oxRREVTOFY
Y0EAni8wDVvlrdVRBByQOLaLyoNZa13t
=zkuo
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
