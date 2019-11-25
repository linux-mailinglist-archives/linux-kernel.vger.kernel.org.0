Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC14710905A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 15:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfKYOtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 09:49:49 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:51502 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfKYOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:49:49 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 78DEF1C2001; Mon, 25 Nov 2019 15:49:47 +0100 (CET)
Date:   Mon, 25 Nov 2019 15:49:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        broonie@kernel.org, sfr@canb.auug.org.au
Subject: next-20191119 on x86-32: fails to boot -- NX protecting kernel data,
 then oops
Message-ID: <20191125144946.GA6628@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Machine is thinkpad x60, that's x86-32. It fails to boot:

EIP: ptdump_pte_entry+0x9

call trace
? ptdump_pmd_entry
walk_pgd_range
=2E..
mark_rodata_ro
? rest_init
kernel_init

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXdvqCgAKCRAw5/Bqldv6
8jjHAJdTbdWkD8+CaJ8fmi+EFTh7IpIpAKC8nENJPzeHPXF0eoZA9TRJPTfRKg==
=QU3N
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
