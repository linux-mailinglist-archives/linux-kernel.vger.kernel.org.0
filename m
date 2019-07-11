Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B087F6526C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 09:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfGKHY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 03:24:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40329 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKHY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 03:24:26 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E503580617; Thu, 11 Jul 2019 09:24:12 +0200 (CEST)
Date:   Thu, 11 Jul 2019 09:24:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au
Subject: Re: next-20190708: kernel BUG at lib/lockref.c:189, softlockups in
 shrink_dcache...?
Message-ID: <20190711072423.GA4219@amd>
References: <20190710201311.GA8519@amd>
 <20190710170912.dd53d6539127bb5b7536788d@linux-foundation.org>
 <20190711002527.GD17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20190711002527.GD17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-07-11 01:25:27, Al Viro wrote:
> On Wed, Jul 10, 2019 at 05:09:12PM -0700, Andrew Morton wrote:
> > On Wed, 10 Jul 2019 22:13:11 +0200 Pavel Machek <pavel@ucw.cz> wrote:
> >=20
> > > Hi!
> > >=20
> > > I'm getting some nastyness from lockref / memory management.
> > >=20
> > > Any ideas? Any ideas who to talk to?
> > >=20
> >=20
> > I'd be suspecting Al's a99d7580f66e737 ("Teach shrink_dcache_parent()
> > to cope with mixed-filesystem shrink lists").
>=20
> It is, and it's already fixed.  See 9bdebc2bd1c4 with fixes folded in;
> the incremental is
>=20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index d8732cf2e302..01b8cae41a71 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1555,7 +1555,9 @@ void shrink_dcache_parent(struct dentry *parent)
>  		d_walk(parent, &data, select_collect2);
>  		if (data.victim) {
>  			struct dentry *parent;
> +			spin_lock(&data.victim->d_lock);
>  			if (!shrink_lock_dentry(data.victim)) {
> +				spin_unlock(&data.victim->d_lock);
>  				rcu_read_unlock();
>  			} else {
>  				rcu_read_unlock();

Thanks! It only happened once under high load, so it seems it will not
be coming back.
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0m5CcACgkQMOfwapXb+vJQvwCdHiNqf81kN0h6xHfjqhT3+s7P
7gwAnAxjVW+ePAtfguOzBd0DyRDTZl2S
=B9pD
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
