Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4CAF318FB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 04:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfFACPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 22:15:03 -0400
Received: from ozlabs.org ([203.11.71.1]:47209 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfFACPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 22:15:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45G4dv3thxz9sNf;
        Sat,  1 Jun 2019 12:14:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559355300;
        bh=2Pq8fZ4Jp2OzD+5xd1TEq29le1blLr/7qLu8KJdreVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HvEiy0qhkMbfOl+DBfmi8p8qpvLS8jPBiP7x4YTfVyylXrNlsgjnkV0/YYMMoaVib
         S+dLuH4FZNYTRZw8aY625aNkUTVSuTO0bgogyPbVzHma5oqwJXQ9j9pIWviMAwr2fm
         QFh+9fRhceZYkxVJt1cvJz9I62tOiInK8ahsgLt6T17oF1yw8vspNy/AT0WsiERmPS
         gQlMBM6hLqOenw/uu0tmPIY+8mAfvwtxep8Z337j2Y49iWP26yAAV1jmqV4wQ2PF/b
         jIN5IAwOWd6uSI4T52ERXsgDgb7sJSno6F/vQ1JAHw6MEVI7Xlm9xT8yXbHZ1vIl9/
         YuQiL5LI78VxA==
Date:   Sat, 1 Jun 2019 12:14:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] firmware_loader: fix build without sysctl
Message-ID: <20190601121457.196aaa07@canb.auug.org.au>
In-Reply-To: <CAGnkfhwJm0N2WvLv9o+DZeL9JjDsDp3-TB-G6iS_6mhTyzYRHQ@mail.gmail.com>
References: <20190531012649.31797-1-mcroce@redhat.com>
        <dbc00eaa-c6e9-45b2-7232-5af35fdea113@infradead.org>
        <CAGnkfhwJm0N2WvLv9o+DZeL9JjDsDp3-TB-G6iS_6mhTyzYRHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.4DKpmM8J4KDFiKa316Skyr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.4DKpmM8J4KDFiKa316Skyr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matteo,

On Fri, 31 May 2019 11:12:39 +0200 Matteo Croce <mcroce@redhat.com> wrote:
>
> please correct the Fixes tag if possible.
> It seems that the hash of the offending commit now is d91bff3011cf

Unfortunately, these hashes will keep changing for things in Andrew's
patch queue until they are sent to Linus.  In the end Andrew will
probably just squash this fix into the original patch.


Cheers,
Stephen Rothwell

--Sig_/.4DKpmM8J4KDFiKa316Skyr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzx36EACgkQAVBC80lX
0GxQHAf+NjKhRDs6MVWS6qYiWpaMsZaUVmhuPik2JMZIZRuhnSuONoLF4p0GF3Sv
+0JBWPCRJgxPSUsaLzsATFJqpNwNh7lWSmsYOkF88PuXde6rzMKPBg5qlkgNsezo
NTCq6XLuXMtCpVKe5cTVpazSkm1zCA6Zoha4TsNDUKdHB9AE9q8lQdXTYF8WgYvs
AczdaTQDbC5lOnY4cZwdVc/h0d2XcfaIDpPMrlKLYxmaEv94+G0mMAgvemIJb/ML
tg/hUlf1yK31UCnroKJrsLjGRbQFuJwJiy0yHweQTzdm1ilMds6w1Q77GTAWw241
0tmkA/0dKGTm+HXsklp3cMjKUUhImA==
=4zvd
-----END PGP SIGNATURE-----

--Sig_/.4DKpmM8J4KDFiKa316Skyr--
