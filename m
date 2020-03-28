Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC3E1969E8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 23:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgC1W5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 18:57:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39185 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1W5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 18:57:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id g32so631126pgb.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=g6YpnruwK6TQmOVLUgbvT3VYPhtAynitj4oc5u7AK+w=;
        b=MFFfgRPL4sWByii1eBuQ6XV5Hknfbi3Sjw5OVcxnTdFMaN5pqCG7HYg/r0vFIqwqNr
         sXuc/mHSyEuyovE930G/JQ1YfZAuH9FNGtSMp8dvsmJIbiGwN9Nq6eCtmoC1v8AtlYtL
         RHGYWl8LlRd2nnovlw/27quGVtOtvhI6j74CB7Z1c7nNyTlhO+fLLFPSxi/bx+Rqv+DU
         +WIvuOWBvcAnc6WzgruGF4cRer0n4hpABh0zVMrQZaji1rc8oy/cDSs9l8RNvlRFT0z0
         Sg4WYFhqzm2OUZNOXPsUP6G9E4eKufaT9rOusV65ifxOYSJVc2pAUouRLToFztj2IcDK
         iH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=g6YpnruwK6TQmOVLUgbvT3VYPhtAynitj4oc5u7AK+w=;
        b=hnED9FoVj78YjBug/m3KibG10BoNtxUrLZap8suOFTgA6Cw79HzdYI3XGWgB7mNjW8
         fG5pj8RVHYglzHkGYi8wTS8xKrK3DMpZ96fQhU4QNvie5Ax4P42RupkoT9jyVl4lmBKR
         PsoCN6HoapqSUp2kEvkA9kIQ9slTuD8ic0dz79jeOu8GTTFm6/Px5s0H2qndGLgnrsFt
         t8v+G+UpfMUiasgOyikA34kWYZZ6w9FNW48A1o+WJc/fnIEGugOO/yrCq02NNWHM8gJM
         D8hW1AViVLSnK6E2RpQySmrJUZ6fO8/LPn2dh/m+piVDNvBDauCBC7ABBKdFO+nQt5hs
         hgTA==
X-Gm-Message-State: ANhLgQ1kNfACNoxbLmKZ+Vi2MvKRgLhY1o9qawcOiTOZnDLpTQtyVWH9
        +NokvOnY3Opeh7/4iKc6hasjvw==
X-Google-Smtp-Source: ADFU+vvbLddIXWxLAp+MTbqZrzoHNS+PRhFX18XGUBBqEdrcGwvzKuFUkI12KMz7pMaxVMm+PKy3ew==
X-Received: by 2002:a63:5f91:: with SMTP id t139mr6374107pgb.119.1585436228601;
        Sat, 28 Mar 2020 15:57:08 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id i2sm6672620pfr.203.2020.03.28.15.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 15:57:07 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <AD34FA78-D061-44E7-96BC-907B51AB75BD@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D0B4B8CD-CAF3-4E48-9C5E-B946689752D7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Fix incorrect inodes per group in error message
Date:   Sat, 28 Mar 2020 16:57:06 -0600
In-Reply-To: <8be03355983a08e5d4eed480944613454d7e2550.1585434649.git.josh@joshtriplett.org>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
To:     Josh Triplett <josh@joshtriplett.org>
References: <8be03355983a08e5d4eed480944613454d7e2550.1585434649.git.josh@joshtriplett.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_D0B4B8CD-CAF3-4E48-9C5E-B946689752D7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 28, 2020, at 4:34 PM, Josh Triplett <josh@joshtriplett.org> =
wrote:
>=20
> If ext4_fill_super detects an invalid number of inodes per group, the
> resulting error message printed the number of blocks per group, rather
> than the number of inodes per group. Fix it to print the correct =
value.
>=20
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> Fixes: cd6bb35bf7f6d ("ext4: use more strict checks for =
inodes_per_block on mount")

LGTM

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/super.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0c7c4adb664e..c50922fa780a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4157,7 +4157,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
> 	    sbi->s_inodes_per_group > blocksize * 8) {
> 		ext4_msg(sb, KERN_ERR, "invalid inodes per group: =
%lu\n",
> -			 sbi->s_blocks_per_group);
> +			 sbi->s_inodes_per_group);
> 		goto failed_mount;
> 	}
> 	sbi->s_itb_per_group =3D sbi->s_inodes_per_group /
> --
> 2.26.0
>=20


Cheers, Andreas






--Apple-Mail=_D0B4B8CD-CAF3-4E48-9C5E-B946689752D7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5/1kIACgkQcqXauRfM
H+BDnQ/9GvrLxTncJ3DBJiT9vsjj6Mltq5kQyxgqIfQS9GQ3X56n4A3sMVnW5PJj
UdWSvvIkun1OQFWyQWmVPSLQhhWp002f9JfFb1vrZ3gUfcx4GBhX4pKU61wbIXHu
vvLvb+I/vwABYUsYVBqj+PhT9+aEAQ2MXNUKvMZZCYV/NVrqGKDVXps7cRReOKwx
vHdK+Y/Hw058idKzDfn26I9Dy5GcETClFx9xdvMH19bQbtnoaTr0greuS45W/y2O
QNIOV634VhjDWfPsajPWJXNTNIFpdvg9UMWSzpVEocMkj5Z74Pso2/pB80XeR2/I
uOj7sclYqqpC1NCzixfZYAjIKsIBiqQHefaiB8G0kbzLO1OOSTKlbKTzd+DqDX+N
cNyhVvNFe3LCXECn+FcEttgsDWvDLcDSQgpX2fc2y7aHbGuTeW/5zRPHDHLmC6qJ
0obiHE2gzrfN8dqxqemT+zFoDJZJhw7f4/IHT8Pp9VuIVpAlbd56KZH1VNWKzdu9
vD8kPqQvZOetFXweuAfukYdMSJkAxTJpBCU0uPTewa20ikgXXpIJpkQ1bBSALeCa
hTFHUYBqjaMQuGJUFnnZ5bx8Jz1ZASr6yQSq8eQHJWpPUYaYlDYMftUXCmDN/v/b
rpOGyERsbx4JidBvI7BTNsdvSge97EagGL9KoL0JD5TkZPpUHAE=
=bZ8p
-----END PGP SIGNATURE-----

--Apple-Mail=_D0B4B8CD-CAF3-4E48-9C5E-B946689752D7--
