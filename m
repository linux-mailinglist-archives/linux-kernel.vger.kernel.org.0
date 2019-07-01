Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894C1303C4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 23:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfE3VFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 17:05:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35020 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3VFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:05:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7BC2E80342; Thu, 30 May 2019 23:04:51 +0200 (CEST)
Date:   Thu, 30 May 2019 23:05:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 051/276] selftests/bpf: set RLIMIT_MEMLOCK properly
 for test_libbpf_open.c
Message-ID: <20190530210500.GA9685@amd>
References: <20190530030523.133519668@linuxfoundation.org>
 <20190530030528.215407626@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20190530030528.215407626@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Signed-off-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/testing/selftests/bpf/test_libbpf_open.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/test_libbpf_open.c b/tools/testi=
ng/selftests/bpf/test_libbpf_open.c
> index 8fcd1c076add0..cbd55f5f8d598 100644
> --- a/tools/testing/selftests/bpf/test_libbpf_open.c
> +++ b/tools/testing/selftests/bpf/test_libbpf_open.c
> @@ -11,6 +11,8 @@ static const char *__doc__ =3D
>  #include <bpf/libbpf.h>
>  #include <getopt.h>
> =20
> +#include "bpf_rlimit.h"
> +
>  static const struct option long_options[] =3D {
>  	{"help",	no_argument,		NULL, 'h' },
>  	{"debug",	no_argument,		NULL, 'D' },

header file with side effects... That's no header file, that's a .c
file. Perhaps we should name it as such?

I thought "this can't be right" when I first saw it..
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzwRXwACgkQMOfwapXb+vLfnQCfR+p2zSdyfd03hPRp3sVU8Aiz
c6cAnj8WiR8dSJVcpBeUFyiC7r0YcTML
=1Dwe
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
