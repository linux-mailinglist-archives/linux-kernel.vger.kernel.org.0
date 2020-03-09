Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE12017DF7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 13:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCIMFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 08:05:45 -0400
Received: from foss.arm.com ([217.140.110.172]:51210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgCIMFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:05:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6798B30E;
        Mon,  9 Mar 2020 05:05:44 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E05483F6CF;
        Mon,  9 Mar 2020 05:05:43 -0700 (PDT)
Date:   Mon, 9 Mar 2020 12:05:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     peng.fan@nxp.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: debugfs: check count when read regmap file
Message-ID: <20200309120542.GC4101@sirena.org.uk>
References: <1583673058-20531-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <1583673058-20531-1-git-send-email-peng.fan@nxp.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 08, 2020 at 09:10:58PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>

> @@ -283,9 +283,10 @@ static ssize_t regmap_map_read_file(struct file *file, char __user *user_buf,
>  				    size_t count, loff_t *ppos)
>  {
>  	struct regmap *map = file->private_data;
> +	size_t num = count > map->max_register ? map->max_register : count;

I can see that it might be useful to limit the read size (though our
error checking is doing the right thing here, it's just that kmalloc()
is very verbose) but this doesn't seem like a good limit, especially for
smaller register maps.  Since it's limiting reads to the number of
registers it's going to result in it being impossible to dump the full
register map in a single read.  This is fine from a filesystem API point
of view, reads can always return less data than was asked for, but it's
annoying from the point of view of anyone hacking together something
like a little program to monitor a specific register during testing or
whatever.  If the register map is small enough you won't even be able to
read a single register in a read which is going to be annoying.  Having
either a lower bound or a more generous upper bound would be better.

Please also write normal conditional statements, the ternery operator
isn't great for legibility.

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mMRUACgkQJNaLcl1U
h9C4NAf+Mxcnob0fXXEudywtr6lfYoOXJrMvrki+FNisnkiyj2VuPFMVNirxZbgW
U9buihcu/SZzhoPXOhuglsoUHmvnLWXFy7nOeJyCOzeNOaBxZ8ZcQdNFnrYUTK0r
NTi/I91MZxmQDKz5aI2m+6a5xhordF4wEUnZ6SwU8Dy2DOtA+rzz17eMNUhkY9oK
5TcgB6VA3VpjgjX/V2YjvEIhGfwKpJMd7s/WQNbdVZ8gOCTNg1TSqP6cZ6wo5Sup
8fDsOHE/3VcKsTCxckHEVx+TWh8ENhzUXha90KB/+Yk3DzB9prUilm/cDKdRAwPu
hPAhJrHyCWNhiktCryUbOC2y83kY/A==
=2rp2
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
