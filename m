Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF4171EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 15:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388256AbgB0ObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 09:31:23 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:41044 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387668AbgB0ObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:31:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id EBBB991CA1A;
        Thu, 27 Feb 2020 15:31:17 +0100 (CET)
Received: from antares.kleine-koenig.org ([127.0.0.1])
        by localhost (antares.kleine-koenig.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LcGdnC_537OI; Thu, 27 Feb 2020 15:31:16 +0100 (CET)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5ad:20fc:dcaf:fc88:2737:d4ae])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Thu, 27 Feb 2020 15:31:16 +0100 (CET)
Subject: Re: [PATCH 1/3] lib/test_printf: Clean up test of hashed pointers
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>
References: <20200227130123.32442-1-pmladek@suse.com>
 <20200227130123.32442-2-pmladek@suse.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Autocrypt: addr=uwe@kleine-koenig.org; prefer-encrypt=mutual; keydata=
 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
 6uMoO1VgFtcQHWHTtbSYLQ8YHVFZMQ==
Message-ID: <bdb7d995-f16f-335c-c06a-b6732dcbbfa2@kleine-koenig.org>
Date:   Thu, 27 Feb 2020 15:30:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227130123.32442-2-pmladek@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hqSDMiKsd8o5YzHaXusAbuclKGGNjTjfM"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hqSDMiKsd8o5YzHaXusAbuclKGGNjTjfM
Content-Type: multipart/mixed; boundary="I0VyUx4H1cFryB8nUb4I59EwMx3eAsZbz";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Petr Mladek <pmladek@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
 Kees Cook <keescook@chromium.org>, "Tobin C . Harding" <me@tobin.cc>
Message-ID: <bdb7d995-f16f-335c-c06a-b6732dcbbfa2@kleine-koenig.org>
Subject: Re: [PATCH 1/3] lib/test_printf: Clean up test of hashed pointers
References: <20200227130123.32442-1-pmladek@suse.com>
 <20200227130123.32442-2-pmladek@suse.com>
In-Reply-To: <20200227130123.32442-2-pmladek@suse.com>

--I0VyUx4H1cFryB8nUb4I59EwMx3eAsZbz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Petr,

On 2/27/20 2:01 PM, Petr Mladek wrote:
> The commit ad67b74d2469d9b82a ("printk: hash addresses printed with %p"=
)
> helps to prevent leaking kernel addresses.
>=20
> The testing of this functionality is a bit problematic because the outp=
ut
> depends on a random key that is generated during boot. Though, it is
> still possible to check some aspects:
>=20
>   + output string length
>   + hash differs from the original pointer value
>   + top half bits are zeroed on 64-bit systems

Is "hash differs from the original pointer value" a valid check?
Depending on the random value and the actual pointer I can imagine a
valid match. Such a match is unlikely but not necessarily bogus, is it?

Best regards
Uwe


--I0VyUx4H1cFryB8nUb4I59EwMx3eAsZbz--

--hqSDMiKsd8o5YzHaXusAbuclKGGNjTjfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl5X0qgACgkQwfwUeK3K
7Am7Zwf/QFJPockuSqgbcRyQUGHjcZY28uGxdP3pAqN/YBVAm3baFOgnjy4GeTWm
3xGi7C3/VQKM+MyJq312hQYVHqIOfm5bGJMH2GffFV0OJQc8HdAZUequpMbYLmVE
jDd5wQJko8g5ELWX+nywC9pobceqxTFa1fgiDCO8zQMx8fV994SSc/kkt3TL88k7
1IJZj9BI6Hy3sAp/4S+jPU0zG7/95en6vEwpDAgfxguCtqGv7Os65CVj46itYht6
QSK4p6qUv1t9nA7yiuwN6RQph8gpoZGRtXmya+4UF2L2W4qzA8gDTRUZ8MgDBw6t
P5xEk/N3jcwu1J27DfYPmFu7ryPEhA==
=GhfM
-----END PGP SIGNATURE-----

--hqSDMiKsd8o5YzHaXusAbuclKGGNjTjfM--
