Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D582FEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 17:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfE3PCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 11:02:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37174 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfE3PCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:02:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so4022765wmo.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=FyK/HVjw1X5e7+ipMBji4f35395lF2dqmlsAt+ZUqkA=;
        b=X6a4HpSOl8/DZLGvgVDGuBaAgYbHEi9VDDZZ5/u0g3BI2qmLemjCL/B+yp+oz+iP12
         51afR6cp/1xmWGGhADwjydUCwGtaR0R7ual8oNTRFBZh+hBXFywCbcymdQjTMmIXfq80
         dJf9auIhB3zsQkG68VqRKrVAcLjSntfkLQgLAcjkfRGj8TEDq4egggz8Fv7yHtot2EaF
         e4C068DkBtWwK0xFB48p3lxTy2vCOSRcHFRCqD+l0bOUVzNf77VYvoigP+FR8V1fA7dz
         JViqdb4VGc5UcIL2IsRGFaFW6OmzywEyJ0rzZ+X6aRqLnT3M3wqTA/9BY35QYZ0kMMHC
         cVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=FyK/HVjw1X5e7+ipMBji4f35395lF2dqmlsAt+ZUqkA=;
        b=EABqaSl2NhpmQqNKyH+ascVUc74p2aaZyMnKMhJCOr1MkobO5f+CLDBv3h1awAoEDq
         fSdOwX9K/n6Vb8m1fzRvH7SOTRz3CfdPcisba+Ro1sMPgWwW44bVCh0HTfh3KIQQCjfb
         jZIgrSnNfncrH6l07bJgc/LkzSN2P/KKGoe1ljjQcRV0mMmifMzxi0ZQbaVZ8EvT3Wxf
         YuXntDLH8bvndJ+L3xAGb06g7NFHX68/CVpxmy4EItOCYcJgX3VwPnLjkVQLJqAZQ3LS
         YI+DJVXMNYhuzNxlP8x0SR9IEfLc9doJnf95b4xrMLHz1pzqGWsCgJizgc7WccqsfQVO
         dEdw==
X-Gm-Message-State: APjAAAVf93eAqiNnGirH0dASG4iMtG43r4rtC1RnRbUFtJlZze3+sZ1p
        Bomhw/4aLEsTluNJ5Z+JRy9bsQ==
X-Google-Smtp-Source: APXvYqyRnWpI624JuZqTMBmg35vVEOvOl19aeavkacCybn6CNim4IaRjG1UX+EuKlBOOkiXM/rFpfw==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr2696361wmc.14.1559228548013;
        Thu, 30 May 2019 08:02:28 -0700 (PDT)
Received: from [192.168.0.101] (88-147-74-24.dyn.eolo.it. [88.147.74.24])
        by smtp.gmail.com with ESMTPSA id m8sm1819441wrn.12.2019.05.30.08.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 08:02:27 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <406CC451-A318-4EC5-942D-4CCFABFBC402@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0A0ED018-47B3-4501-BF94-C2C77CE3E17E";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/2] block, bfq: add weight symlink to the bfq.weight
 cgroup parameter
Date:   Thu, 30 May 2019 17:02:25 +0200
In-Reply-To: <20190521080155.36178-1-paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
References: <20190521080155.36178-1-paolo.valente@linaro.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_0A0ED018-47B3-4501-BF94-C2C77CE3E17E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Jens,
have you had time to look into this?

Thanks,
Paolo

> Il giorno 21 mag 2019, alle ore 10:01, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Many userspace tools and services use the proportional-share policy of
> the blkio/io cgroups controller. The CFQ I/O scheduler implemented
> this policy for the legacy block layer. To modify the weight of a
> group in case CFQ was in charge, the 'weight' parameter of the group
> must be modified. On the other hand, the BFQ I/O scheduler implements
> the same policy in blk-mq, but, with BFQ, the parameter to modify has
> a different name: bfq.weight (forced choice until legacy block was
> present, because two different policies cannot share a common =
parameter
> in cgroups).
>=20
> Due to CFQ legacy, most if not all userspace configurations still use
> the parameter 'weight', and for the moment do not seem likely to be
> changed. But, when CFQ went away with legacy block, such a parameter
> ceased to exist.
>=20
> So, a simple workaround has been proposed by Johannes [1] to make all
> configurations work: add a symlink, named weight, to bfq.weight. This
> pair of patches adds:
> 1) the possibility to create a symlink to a cgroup file;
> 2) the above 'weight' symlink.
>=20
> Thanks,
> Paolo
>=20
> [1] https://lkml.org/lkml/2019/4/8/555
>=20
> Angelo Ruocco (2):
>  cgroup: let a symlink too be created with a cftype file
>  block, bfq: add weight symlink to the bfq.weight cgroup parameter
>=20
> block/bfq-cgroup.c          |  6 ++++--
> include/linux/cgroup-defs.h |  3 +++
> kernel/cgroup/cgroup.c      | 33 +++++++++++++++++++++++++++++----
> 3 files changed, 36 insertions(+), 6 deletions(-)
>=20
> --
> 2.20.1


--Apple-Mail=_0A0ED018-47B3-4501-BF94-C2C77CE3E17E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzv8IEACgkQOAkCLQGo
9oPbeg//bjA9YtGMRt5whQ3aCQke6yuOS6cLXKdGEGOy6Mw2OC03I4wRDUjRZA+L
DGHOipvDtans0+xVYd+m8UCeq3ZklbaZA7qeasP2rwv3sb0pC60p1luy24nWjkoP
OlfesidSq98l7zQL30ZjfOvP0X0DskTVkNSPih7U0TbkwQ6jl6/o+inbGjNKzP4p
4cQuLfHPG4ipL0ds/BiNRd+ihIzuIrtftwAwEaklhA7XOfnmZtGkA5hrIN+U4NNx
xHceCTjv7+X2+Uk0aFGTE4ch5fVHQvAbM7b1wr/ERgZd/ProT07gqG0PzwGfPI9q
MC4MhXsWgmymuMcn+6CFCRgSBJWxNSa+2uf66T8j26osYMgQ6RBZkgp2NLKIFhvX
eKBtS/p6NtLYTTYOHUlLzeHf6tIbkKf6DvaTQZ4WfmDFbaRBFsqobfjmyJtr9GZp
erIwdWEhqlSBgv0pseSDF0nePD5egshMmM3Vhfbbgisq99yUQBUKEcWM52A5E+Eg
qZfn5lbrxY6GlnhMSzEbZg5Dkwyb2WnIAXh94Br35FA49D/FlJIZbzppbOOBzSEP
gQ65irL0W2X3rRvIYWYCcGAbvH+NEjFE1LQY0zwansnOxv2UbZgg23RY+quEWuny
XigI9gpCnhe9aLkjggRRRiAKf6lNHrGXIbwA2ACAZ6WtYX/B3uA=
=tEiY
-----END PGP SIGNATURE-----

--Apple-Mail=_0A0ED018-47B3-4501-BF94-C2C77CE3E17E--
