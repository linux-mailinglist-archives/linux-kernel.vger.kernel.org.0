Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B5931A14
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 09:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFAH17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 03:27:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52450 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfFAH17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 03:27:59 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 56B6D802F5; Sat,  1 Jun 2019 09:27:47 +0200 (CEST)
Date:   Sat, 1 Jun 2019 09:27:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>, Jan Kara <jack@suse.cz>,
        Yufen Yu <yuyufen@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 130/276] block: fix use-after-free on gendisk
Message-ID: <20190601072756.GA2215@amd>
References: <20190530030523.133519668@linuxfoundation.org>
 <20190530030533.910471797@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20190530030533.910471797@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/block/genhd.c
> @@ -518,6 +518,18 @@ void blk_free_devt(dev_t devt)
>  	}
>  }
> =20
> +/**
> + *	We invalidate devt by assigning NULL pointer for devt in idr.
> + */
> +void blk_invalidate_devt(dev_t devt)
> +{
> +	if (MAJOR(devt) =3D=3D BLOCK_EXT_MAJOR) {
> +		spin_lock_bh(&ext_devt_lock);
> +		idr_replace(&ext_devt_idr, NULL, blk_mangle_minor(MINOR(devt)));
> +		spin_unlock_bh(&ext_devt_lock);
> +	}
> +}
> +

AFAICT /** means linuxdoc, but the comment does not have required
format. Probably should be just /*.

Thanks,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzyKPwACgkQMOfwapXb+vJsrgCgqD+CDZs2l5FIKcmOJq0+LQpP
yhcAnR/Uu9rulkUgtM5Yhv44dQ6hl1Uh
=fDgO
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
