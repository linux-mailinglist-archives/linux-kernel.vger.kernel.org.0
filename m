Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD08C158EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 07:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfEGF17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 01:27:59 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:41323 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGF16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:27:58 -0400
Received: by mail-ed1-f43.google.com with SMTP id m4so17474324edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 22:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=MBFNJxMevG48pJHzyxmna7JyM+HsId/GulK9IbVJxcA=;
        b=cKqE966EYoJpcFwaLW+7vPPCnFUkD9zrcBged5xkJVhxhyl6CP/yYrWZCcxliKqFph
         xlniyUjm6CNcoFZe9eEqbVd3stPeHiPhzagkauIg67asW3A/RKvXIlgkX5G5D3A9XCTZ
         fstxP1JRcROQkRtzbMhaVqWgQI4289PrCX3EZr4AZsAmppUfxXDjX+5kxgy5zSa56mu/
         h69xt/UBT8M7dpfJEcn7EWeIVp6RsFHdPlgur8mezQnA5khpO1hLJL9PU7K8TKrXOqiS
         Dj5ygRmE6MP3S+vUo8NAT/n/zruDMp9YwIgqUTR5aPbuOABE2iippXYTrjhxvKk5IPXw
         lhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=MBFNJxMevG48pJHzyxmna7JyM+HsId/GulK9IbVJxcA=;
        b=SawS4nZ2K8OnxCt+qSXH3orbcdYPGV2iq4srAXOkBE/Iq/Bio64ip6F0ysYRHZJDd3
         16uNUd8SRfnG2dORBu80gQqsTnlEfCliUSKqSd7u6Z7kuYjHTtfWdo2CdFTP9qcpZMbU
         AgP9FXfko/XgU0gaeaxz0kWWYOC79G0tAHfhrUvx0LMZ/t3FNw64DdeRhj1YYZthim5u
         JJO+LMH1ezCYKkY/AITjDZVSL6qyqRNaO4SZcd0Iw9BW4NCEaENLyxA6ypy06pVcrSMS
         cnRb/rA1HbuHhyZDjUALfpppGIeXrctq1qZqNK5POln2nwDuU2Q+n6YLJ4MM9SYRcz5X
         POUA==
X-Gm-Message-State: APjAAAX385kzAppSkNpu/f0trPiaCvSdKfq7G0lEWoCKXziduyNlrZMg
        +rG+IcogfIPQuzRSIBuJshSzXg==
X-Google-Smtp-Source: APXvYqwyLbiU3H266HvLDvt7zxIbQABXSFxbhE5pS/0xJ9Go+lZuCbEcKMfGQISmlFmSKhsg3ysT+Q==
X-Received: by 2002:a17:906:2301:: with SMTP id l1mr17855620eja.121.1557206876819;
        Mon, 06 May 2019 22:27:56 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id i33sm3835646ede.47.2019.05.06.22.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 22:27:55 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <67CD0023-8852-43F9-A447-88E4AFFED315@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EDE3D055-B8E4-4353-ABDD-D4F4A955ABFD";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] lightnvm: pblk: Introduce hot-cold data separation
Date:   Tue, 7 May 2019 07:27:54 +0200
In-Reply-To: <CAJbgVnU3-ed42CBtPv7SWdtA=__bNcSPhiXwobuVKek2-BFBig@mail.gmail.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Heiner Litz <hlitz@ucsc.edu>
References: <20190425052152.6571-1-hlitz@ucsc.edu>
 <66434cc7-2bac-dd10-6edc-4560e6a0f89f@intel.com>
 <F305CAB7-F566-40D7-BC91-E88DE821520B@javigon.com>
 <a1df8967-2169-1c43-c55a-e2144fa53b9a@intel.com>
 <CAJbgVnWsHQRpEPkd77E6u0hoW5jKQaOGR-3dW9+drGNq_JYpfA@mail.gmail.com>
 <139AF16B-E69C-4AA5-A9AC-38576BB9BD4B@javigon.com>
 <CAJbgVnWTRWZB_Dc7F1cvtgWdYPCbJ_aJJ_mas01m51+8siHvHA@mail.gmail.com>
 <b7c03f26-90bb-ffd6-e744-6daf3bbe348d@intel.com>
 <CAJbgVnU3-ed42CBtPv7SWdtA=__bNcSPhiXwobuVKek2-BFBig@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_EDE3D055-B8E4-4353-ABDD-D4F4A955ABFD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 6 May 2019, at 07.16, Heiner Litz <hlitz@ucsc.edu> wrote:
>=20
> Igor, Javier,
>=20
> both of you are right. Here is what I came up with after some more =
thinking.
>=20
> We can avoid the races in 2. and 3. with the following two invariants:
> I1: If we have a GC line with seq_id X, only garbage collect from
> lines older than X (this addresses 2.)
> I2: Guarantee that the open GC line always has a smaller seq_id than
> all open user lines (this addresses 3)
>=20
> We can enforce I2 by adding a minor seq_id. The major sequence id is
> only incremented when allocating a user line. Whenever a GC line is
> allocated we read the current major seq_id (open user line) and
> increment the minor seq_id. This allows us to order all GC lines
> before the open user line during recovery.
>=20
> Problem with this approach:
> Consider the following example: There exist user lines U0, U1, U2
> (where 0,1,2 are seq_ids) and a non-empty GC5 line (with seq_id 5). If
> we now do only sequential writes all user lines will be overwritten
> without GC being required. As a result, data will now reside on U6,
> U7, U8. If we now need to GC we cannot because of I1.
> Solution: We cannot fast-forward the GC line's seq_id because it
> contains old data, so pad the GC line with zeros, close it and open a
> new GC9 line.
>=20
> Generality:
> This approach extends to schemes that use e.g. hot, warm, cold open
> lines (adding a minor_minor_seq_id)
>=20
> Heiner


Looks like a good solution that allows us to maintain the current =
mapping model.

Javier

--Apple-Mail=_EDE3D055-B8E4-4353-ABDD-D4F4A955ABFD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlzRF1oACgkQPEYBfS0l
eOAA5w//Y7hc9YZYawmU3f9VgBOR0aaGsv9Wj9/oTX44srpceZgxsLSqNfTLaree
qA5t0keisrMDRq27BRU8UXMEJAoNnqa1BnG0CwTdA+faF7lN9nPdAzYSD0Mfc0XI
RB6icT3oMYknVBeh36P/UlYDAX4Y8U9H8la6nSsqlY0FYQTjacb8MvBsrxqLEAZO
43AsYTLz9IuvlrMFRhFuqSwte3kgjEU/w6OLJQvogYLHD6s5bcKdm8pis6w/xjmg
3W3y/XhnCToS6ZsMrNUGlEd+e/IuKqadZ+iKuG0x0PSbw0IhfdlBdRwMzMCJY2JN
7QYYzQoM+s22qCI9OK/hN2Ry9Rwe/f25Pa0dT5xwfS4ZtPDwhkmhgQmbibVQquAz
pl4RHnr06aeX5DEj0y/ISV3KAk+O/cySh9bWCYs2XulDw3NJB1UI2/BZYGx83E2o
fjoSYaok6WegmlgfBD/dhnpGmkWYtPZryaNo4jD4AbL9B7DgB68U6Pl5YkCZwM//
NiCkl2MJsNjvKLtjti4OYlin7G39CggcmeV9C/2uPy8V5uVFXBMybqW6AVwaKKCw
uufcMO/3bO9gMraKf+AIbT3Ky4OuZ66KPB8DOTNverHwyhsS01MiGMVjevDUOZdE
S9mTFCcxaGe2eSJ3Rmz69noe0bIZTIY2ulS48ysKEV6L9oF2S74=
=O9E7
-----END PGP SIGNATURE-----

--Apple-Mail=_EDE3D055-B8E4-4353-ABDD-D4F4A955ABFD--
