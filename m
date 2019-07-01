Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB1C011562
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 10:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfEBI1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 04:27:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45538 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfEBI1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:27:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id g57so1309887edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 01:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=dSmbxNpQUXqOAF+wyYt/oF/nK39mDwCtjQCLrs4dIww=;
        b=IDpnpA8P7Ng/MqSrVhbClQlwqEs0i4b85XUADMhNeu68gyf5nqHS0qDg9RkZWmczUd
         SyVal7y8LCFnEUsWcbjJKP8I9PDYNrIwaehuvLbL5+nd/DvvuKJwQcFz5y87LoGi27UL
         p3xWjvUx+OfBa632s2zu9kRHa3VifCDs/pRqwo5IIEz9sJsE/zt9BQBKXHM8eMjFcDtD
         mFCNtez71oT5Q6ay8JW118+gRvX7HdzyC6ZMMfKL3LriHyrWDvrx83q0xf1FNUM3+Ki2
         PGX/WfbPpXQu8lRmuWmKbJsOHlxLNgOpRsvRR0wl8UGHZtnt3c1oZv0ubNrllzWbwstF
         0cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=dSmbxNpQUXqOAF+wyYt/oF/nK39mDwCtjQCLrs4dIww=;
        b=MYNZq7hQ7A2q6SMEOyDPOS6X+SCxlG6BvDeVgbVmR9wBWef8ctTd7Fh4A1Vy5CvJ/b
         eafcZyvArpCjiXwnKeJaXQHjPZ2eT67BSRCHOd2UeigboweTAj1Bg/NX3IBw5h3SBBlj
         aw6uzAbtiwWMankuZPrNqml9idkmNubc0ecG3vFxNG7lcefLuiWthBwn28R4wiNV244u
         s5g04AZOnHqpRANnKneYfMQDYfRQHzpormtlfT2p/asscMmdayiJtLPhwdTGQqr4crLd
         enEIrLSrqXX8A2dclf/OSB+/6jgPFi+VAlsv1nLsANM4CudBxTBK3m8Ve3prU7BbE0Kz
         iLMA==
X-Gm-Message-State: APjAAAWl6D18hieWrpnMyI1IzTZWnbDqFoCvSylOlxJQEPqOoOI475hm
        knHZvIYe0kpyOxGDaQH3ZCg/VA==
X-Google-Smtp-Source: APXvYqyXBbFUVmNmNH/NEtD63E0om1IHMQ3xpK0ZWqnKeJ3FfUv8v8pVMHoC7gkhcYUh1GaN4hGLpA==
X-Received: by 2002:a50:885b:: with SMTP id c27mr1637782edc.155.1556785658429;
        Thu, 02 May 2019 01:27:38 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id w14sm1038734ejv.58.2019.05.02.01.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 01:27:37 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <22C6C23E-BAE8-4AC2-8D6A-FECA10F2F55D@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_00A15516-FDF5-444B-8D42-D909364E2105";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] lightnvm: pblk: Introduce hot-cold data separation
Date:   Thu, 2 May 2019 10:27:36 +0200
In-Reply-To: <CAJbgVnWTRWZB_Dc7F1cvtgWdYPCbJ_aJJ_mas01m51+8siHvHA@mail.gmail.com>
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
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_00A15516-FDF5-444B-8D42-D909364E2105
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> On 1 May 2019, at 22.20, Heiner Litz <hlitz@ucsc.edu> wrote:
> 
> Javier, Igor,
> you are correct. The problem exists if we have a power loss and we
> have an open gc and an open user line and both contain the same LBA.
> In that case, I think we need to care about the 4 scenarios:
> 
> 1. user_seq_id > gc_seq_id and user_write after gc_write: No issue
> 2. user_seq_id > gc_seq_id and gc_write > user_write: Cannot happen,
> open user lines are not gc'ed
> 3. gc_seq_id > user_seq_id and user_write after gc_write: RACE
> 4. gc_seq_id > user_seq_id and gc_write after user_write: No issue
> 
> To address 3.) we can do the following:
> Whenever a gc line is opened, determine all open user lines and store
> them in a field of pblk_line. When choosing a victim for GC, ignore
> those lines.

What if the following happens:
  - LBA0 is mapped to line 3
  - GC kicks in
  - Open user line 5
  - Open GC line 6
  - Choose line 3 for GC
  - GC LBA0
  - LBA 0 updated and mapped to line 5
  - Power loss

In this case, recovering in order will make that the last mapped LBA is
the one on the GC line. Note that even when the mapping has been
invalidated, scan recovery does not know this and it will just update
the L2P as new lines are being recovered.

I think we need to enforce that no use line is open prior a new open GC
line. This is, when creating a GC line, we wait until the next user line
is to be allocated, and then we assign first the GC line and then the
user line. This can be extended for several open user and GC lines. This
way, the case above (3) cannot occur. In the example above we would
have:

  - LBA0 is mapped to line 3
  - GC kicks in
  - Open GC line 5.        \\ enforced
  - Open user line 6.      \\ enforced
  - Choose line 3 for GC
  - GC LBA0
  - LBA 0 updated and mapped to line 6
  - Power loss

Javier

--Apple-Mail=_00A15516-FDF5-444B-8D42-D909364E2105
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlzKqfgACgkQPEYBfS0l
eOAA0Q//ezKsWCFsw2Iu5FLq8shnnNUTcU46vdOmEmBitktx2RGiqlNlVqCBWW18
iFRYr9IT13s+PrqETXZ0QFQ6hYVyf+B4YGfhXYkJfNUoOPK5xrm3C4iT/tu+bIHR
t5w02m5hBRN1v/ZR02LJ+6KfN2rQ6KmDX09QKFtH5Iqf9WQ5VaN/uqmXzY7Vaqa9
/smZRhgDAHQ7F5idMLnukOkBOhTZaIeBMh7pohRn9CUJ5C5etIh8ohDM59lmpEtX
st0ynkBkQu0wfoRQzSa3aplIgTxrp0poLxVqa9JEsETsJBH0amxA8YneGSO4MNcQ
B8nXhZAby801sBsANerturYtR6IDf3WmDUmvVZl/lui53orIML3o/me5oC5sZeBP
KuNEyCJZMkBpCMbMRPyUeCiykVqIwXAZuVylAdYG0OYifnu4l1hla230RP7zhFwU
MM1nhK9Njn04pFa7NOZ0m0uS697Dpx9TTqHnNYIrj4tcD4f1GquWlDlOy6wMvT//
Oy28kT4A46icWT8AU+cIBc6U46Kucf5FqJFHPi44U1i6B5dw5HFuHSQj6Rvztk2+
l1AXyZzvXflvYrwlG7Kxnlhh8dRJo6HTkS/9gIi06b7CQFgV22Tw4YzxrqDAKK78
QHgnHIzO1KE2rRaib/W7PHenMfxp8y8SYpVpptlsOSug+ZNMKeg=
=Rrvw
-----END PGP SIGNATURE-----

--Apple-Mail=_00A15516-FDF5-444B-8D42-D909364E2105--
