Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0347D29016
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 06:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfEXE1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 00:27:19 -0400
Received: from ozlabs.org ([203.11.71.1]:46947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfEXE1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:27:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 459CyB2VCpz9s7h;
        Fri, 24 May 2019 14:27:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558672034;
        bh=qjylat0BXJ5+wsdyh2jzKX0/cPwUn/jGj4My65XWE3A=;
        h=Date:From:To:Cc:Subject:From;
        b=NOxeGPeyqp/e4zd1oSEQxoO5rchKqaM6itGmJ3QItV/dkAQ+D0QmodWOHGbS8ADZz
         vFNOZR4jkaB5yiqvn4qglZyL90WwYP+YYeh9NxxgOyzP+NX4L331vqb2IZmuBMAh9x
         6bdTXH9EW9JzsOhJRwhP1gZHUZnRRLRuvvRamCCh2smtNR5u1hwdifWtjg1YH4aWxo
         Pco7x828zvkJYZ/3MczL+c/s7frRENGZp6fbr3N8342mEni2hqiY2wn/+GcyJ80z7N
         21IBMOeydTSjQaOVI+eHWfDCg9b5OoJz4/VDfTOL8WJCWj5fVE3rAj/JBNkjyfVhyn
         us73W5gBvZPew==
Date:   Fri, 24 May 2019 14:27:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Murphy Zhou <jencce.kernel@gmail.com>
Subject: linux-next: Fixes tag needs some work in the cifs tree
Message-ID: <20190524142713.360c0c10@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/onC+sUfs3YQg2TItGbXTUJg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/onC+sUfs3YQg2TItGbXTUJg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f875253b5fe6 ("fs/cifs/smb2pdu.c: fix buffer free in SMB2_ioctl_free")

Fixes tag

  Fixes: 2c87d6a ("cifs: Allocate memory for all iovs in smb2_ioctl")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/onC+sUfs3YQg2TItGbXTUJg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzncqEACgkQAVBC80lX
0Gx3PQf/ZW8ZQSBngy86/4u4M3SvsJhOkPdIQ0xNaoMx7m4fC6QpINDluenVLQ5p
9pqXPanFi0N91DrdFxut3oRJaVR8RfV4AyHU5tFiXVZRzBEEhjTQcbWtIGINBNkH
fFjhC4KHo8muVthr7IIhfn2eVzwhYB74H9w+LOfREjIo9ih6GN9Ep/22TETZ7BND
YYoSbUrwhtQAeBpnkOFCK2qrMK8CGpY1b+UjfZliHcp3nWJPIuARhX8le2YfOlTL
ZXoSfpiSM5dMvbE6EN7VHSnmpH5FFwKcEPhm62fwmrqKoYoyT/BnG3EG28sDPfkh
LTrZiHKzpdLIagXzAW5WJohrK9UmAQ==
=2Z21
-----END PGP SIGNATURE-----

--Sig_/onC+sUfs3YQg2TItGbXTUJg--
