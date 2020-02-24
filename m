Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A955316AA0F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 16:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBXP17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 10:27:59 -0500
Received: from cyberdimension.org ([80.67.179.20]:38336 "EHLO
        gnutoo.cyberdimension.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBXP17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:27:59 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 10:27:59 EST
Received: from gnutoo.cyberdimension.org (localhost [127.0.0.1])
        by cyberdimension.org (OpenSMTPD) with ESMTP id a8cf2527;
        Mon, 24 Feb 2020 15:18:57 +0000 (UTC)
Received: from primarylaptop.localdomain (localhost.localdomain [::1])
        by gnutoo.cyberdimension.org (OpenSMTPD) with ESMTP id e68aa2cb;
        Mon, 24 Feb 2020 15:18:57 +0000 (UTC)
Date:   Mon, 24 Feb 2020 16:21:31 +0100
From:   Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     hns@goldelico.com, j.neuschaefer@gmx.net, contact@paulk.fr,
        josua.mayer@jm0.eu, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] regulator: core: fix handling negative voltages
 e.g. in EPD PMICs
Message-ID: <20200224162131.2a4f9b01@primarylaptop.localdomain>
In-Reply-To: <20200223153502.15306-1-andreas@kemnade.info>
References: <20200223153502.15306-1-andreas@kemnade.info>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SohBod5xoYXZ0V9Nuwu+jx6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SohBod5xoYXZ0V9Nuwu+jx6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Feb 2020 16:35:01 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> No idea about the "Amazon Kindle Fire (first generation)"
> which also has a partial devicetree in mainline.
I think that the first generation Kindle Fire (omap4-kc1.dts) are
regular tablet and have a regular display (no e-ink).

Denis.

--Sig_/SohBod5xoYXZ0V9Nuwu+jx6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeC+d2+Nrp/PU3kkGX138wUF34mMFAl5T6fwACgkQX138wUF3
4mNTaw/+OUdrF51FaRsvxjxd72UGdh1mBRryrrZVmNuRPeDZ4QvWLikvIN+orzsC
7puVYev9DXQ7NzAzL9/mIvZCt1Y5ADOOs6onVmnIQO8T/gqHlcqfLvZWT4AmNEyP
9GEErgXSTqlyHSRpEAtNxn+wVP4tB91TgC+HCAHDJc1wPIRZUijARMsQjQyochFD
g0deK+S3TajeMJqx7it5dAz/IqnL641fCYo7CjhR+/U8A4/SBIuxpCpK5W1BPjeg
KwTQWo9lKSDU7oXmZN6b/m9VjDaz3dzCOYXrX1vawW6/lLuDyEWv7FVEenouxC2S
fmVxR03Cff0TPpikd0YM7wgcdPOnlrcgg4M9YoiP2pAU9zxGxR13S371zKKeVikc
FqDe+x8lEOKx39KydRMz5SicmWbpc0EG7R/4HBwFKbB1bNWBjm5zBnwMOsmFj9uL
h3St3tOFNqMkyuwqpkr5djj7CEti6SfXOV9UI06ysHt1mvhHr5uuG+K0rdQ7kaCL
ttjZbc7wQROlK/RrCVi4q3PwGON5johSqNt8jmlQh3uqY+PNr+HlNBfJ4/BGkO88
ZASGxfxI7rFTzxDoPqkz/Xrk2XemLaucsgtZ5i4DGrFxuzNEckOD0FYmviCYNE67
gM1efcEv0M7jSH5QUA0ZPjHNn/mVMTb50WZjzYZKnBjj8fi7HkI=
=lc2S
-----END PGP SIGNATURE-----

--Sig_/SohBod5xoYXZ0V9Nuwu+jx6--
