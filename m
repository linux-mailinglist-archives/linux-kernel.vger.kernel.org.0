Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC973429B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 11:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfFDJGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 05:06:16 -0400
Received: from ozlabs.org ([203.11.71.1]:36531 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfFDJGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:06:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45J5d11K1xz9s1c;
        Tue,  4 Jun 2019 19:06:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559639173;
        bh=N+BhgzywXpF8QslLt1YNKo69yW/kJWxEUh46lI8jpew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=geEmGUHAQ1QE38V81v1F3GUvOO+k20lieIAOEThl+cRwoAQGfzQ5EJuQ74anEdRDv
         2PRctAqJHvuwaZhjcMb590qaGayCZhYkBc4rQdgqQnt6vU62RCh8x8TaUW77vFTk3R
         l19y2wnZN0+r0OzRGRLyOebWzvl89Rhz194HMeYv7D6UndIOuResCYBdFhYbyrifGp
         JZCoBJUOBzPv9P/EGC96s0JNhts18sd95wXcbyNzpvsgliuGspMkK/QH4KBu8yZqxF
         672GsT9ddA+Oa0+rOuPRJ4/lYPqFAT6nKNP4wZTNm8ltD/uTa5s9TNjGTK4rWpbADz
         3lfzt9cbsTjjQ==
Date:   Tue, 4 Jun 2019 19:05:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [XArray] fa858b6eec: BUG:Bad_page_state_in_process
Message-ID: <20190604190559.1bcabf98@canb.auug.org.au>
In-Reply-To: <20190604083057.GF6576@shao2-debian>
References: <20190604083057.GF6576@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZOVWcksKa9OaThGZ75tcGmM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZOVWcksKa9OaThGZ75tcGmM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Jun 2019 16:30:57 +0800 kernel test robot <lkp@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>=20
> commit: fa858b6eec3f4908973131b1d5a3f2e35c4182cd ("XArray: Add xas_replac=
e")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

That commit has been removed from linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZOVWcksKa9OaThGZ75tcGmM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz2NHcACgkQAVBC80lX
0GwWJAf/U7d17osO2B7PxJvNyBOw2BykRGtpWHNwDIJFrhDAXfOtc0lHI8eyPFBf
3nRJ8XJ0maHRYg8X3aMRmpw1SmUnF8xYwqOQt7D1g8i+LCHq+ur3RrFkP1UuTLC5
FXvY8KyYrKkAaVMKKI0vwIYVdLmepBQa/i8EtWNZpdUNAaX7N5aksS5O7hUxUHxp
5yYx2t4rdM4oyLYC6ibis0u0exmEvptCVKHiuSDWq6VGyxYUJlWiKZMtUDsoCLYr
nr13XpfxM0Tndt5w4xyy83JAKvYu20eqbeClxeAN6GbrN7h4LvF6QvKzZWvfqc6s
Q/leZVOw1IZr+u/vwRZaAJ6Hlu5W/w==
=rpb6
-----END PGP SIGNATURE-----

--Sig_/ZOVWcksKa9OaThGZ75tcGmM--
