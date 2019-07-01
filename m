Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3564A38441
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 08:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfFGGU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 02:20:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34217 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfFGGUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:20:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so3306385wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=H1hK/RDmUIiwsn0IMBWePbb6aZ41gT1eJ3R/H52wOko=;
        b=N6XwBdMD9YQ2xRZnlb9SE5vj7v6ei/Ro0wdZZzuxmm59Zhc1TAX22hZvlfqMrIQtaK
         xk3lehdM/w/e4u4RlfHyqhXxtE/AgsgY/nURSB1kdbSrq3EOUZaX1KRszVmf9hry4xBs
         8yxzPWhB/X7DEfXmBIz5si1Y9UtNrgfXk+HomYhX0kwna/q2SQrQayMqWKmvy6CQlGLj
         9xY1M7A6Zbwa8wsV+RjYuELSWQmHh7iEu1Zj4+0lBAeDTecEZIUBdH/DDaiMpzp4iUlQ
         YpAQL/503w5yEz6Kw1FuTnpJIwW+NW/yIH+Xw+NUjSedbbPP8Cbd42f7jsi4ZZCOlUZg
         JZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=H1hK/RDmUIiwsn0IMBWePbb6aZ41gT1eJ3R/H52wOko=;
        b=VvGuh3OsNOtyA/QY6Rg7XG+jSY+eS8T5ep++Xo6Y++E5BwD+kjwHh2rrswwuxBOhKt
         khjM03NEyo6LKyJVwWjV5KcwdkYsYDM2tP4802qKxhYOEhfayB7VRN762xI1Q8V2sj7k
         bXw90pYiXdEpUIbjdGzHinCD6zIE+/TXBGYnRnF+q6hY+qiM8GlXZHdv/Ip7Bgp+q4Xm
         NLxM2r0tXZExorWeuZpkP7GAMDtmj/uSytzqBw67wv0l01RKBxbsMcQZggsySy3BpTCZ
         szQtVsJDRUj2Va1vb/VafRWTHS2qYG0GitHRBU37qCP/InV0TxtA29S5/Cj4otSy3BFK
         GSlA==
X-Gm-Message-State: APjAAAW5SEra+TyNKk1ISz/VCv4qUtuFA3QT0UDNQgcCXNxGYDSlwBCL
        oAi0ld84w1fUuH2Idg43vYTByw==
X-Google-Smtp-Source: APXvYqw7imqU/ljk7y3qJFtjAf2wvyKSEUXlBPlaYtxqWuKuNjfzilCi7SVJvscn1teAQPOrASXUKg==
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr2422869wmj.41.1559888423707;
        Thu, 06 Jun 2019 23:20:23 -0700 (PDT)
Received: from [192.168.0.102] (88-147-34-172.dyn.eolo.it. [88.147.34.172])
        by smtp.gmail.com with ESMTPSA id n7sm804018wrw.64.2019.06.06.23.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 23:20:22 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <38971C09-E691-4129-BE6A-E21337EAE884@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_7DA8BBC8-3D3F-41ED-B7DD-4265FA89D2CE";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/2] block, bfq: add weight symlink to the bfq.weight
 cgroup parameter
Date:   Fri, 7 Jun 2019 08:20:21 +0200
In-Reply-To: <406CC451-A318-4EC5-942D-4CCFABFBC402@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Fam Zheng <fam@euphon.net>
To:     Jens Axboe <axboe@kernel.dk>
References: <20190521080155.36178-1-paolo.valente@linaro.org>
 <406CC451-A318-4EC5-942D-4CCFABFBC402@linaro.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_7DA8BBC8-3D3F-41ED-B7DD-4265FA89D2CE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

ping

> Il giorno 30 mag 2019, alle ore 17:02, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi Jens,
> have you had time to look into this?
>=20
> Thanks,
> Paolo
>=20
>> Il giorno 21 mag 2019, alle ore 10:01, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>=20
>> Many userspace tools and services use the proportional-share policy =
of
>> the blkio/io cgroups controller. The CFQ I/O scheduler implemented
>> this policy for the legacy block layer. To modify the weight of a
>> group in case CFQ was in charge, the 'weight' parameter of the group
>> must be modified. On the other hand, the BFQ I/O scheduler implements
>> the same policy in blk-mq, but, with BFQ, the parameter to modify has
>> a different name: bfq.weight (forced choice until legacy block was
>> present, because two different policies cannot share a common =
parameter
>> in cgroups).
>>=20
>> Due to CFQ legacy, most if not all userspace configurations still use
>> the parameter 'weight', and for the moment do not seem likely to be
>> changed. But, when CFQ went away with legacy block, such a parameter
>> ceased to exist.
>>=20
>> So, a simple workaround has been proposed by Johannes [1] to make all
>> configurations work: add a symlink, named weight, to bfq.weight. This
>> pair of patches adds:
>> 1) the possibility to create a symlink to a cgroup file;
>> 2) the above 'weight' symlink.
>>=20
>> Thanks,
>> Paolo
>>=20
>> [1] https://lkml.org/lkml/2019/4/8/555
>>=20
>> Angelo Ruocco (2):
>> cgroup: let a symlink too be created with a cftype file
>> block, bfq: add weight symlink to the bfq.weight cgroup parameter
>>=20
>> block/bfq-cgroup.c          |  6 ++++--
>> include/linux/cgroup-defs.h |  3 +++
>> kernel/cgroup/cgroup.c      | 33 +++++++++++++++++++++++++++++----
>> 3 files changed, 36 insertions(+), 6 deletions(-)
>>=20
>> --
>> 2.20.1
>=20


--Apple-Mail=_7DA8BBC8-3D3F-41ED-B7DD-4265FA89D2CE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlz6AiUACgkQOAkCLQGo
9oNu6Q/9Hkd8DyVaH7dQ59vEgRtqcgg1iU6GP+VNGUTxNLZ09Ods6bqmZrcGke9K
phBaiKyrkzh3ozmIpgZItaVcQ7XcIQjt7c22ZzEZyXHb9WB3LSDePOyM+rwpG0qX
PlHlzjU8IZuOmzYrFJcwblxFsbMD0+Qsje0/d43nEbRd6UP49woSROPDgzYdFGJM
YctiEH9StBuyWze/jjTiUqffRRsHgacfLIlnGX9hy0vtzQgwK72RnVNbqsMDQvUA
/fZapznTAQ65g5PbdhMd9EngLNmHUQecbcZL2f/CFMWeA0J3DsEJfdTi6rA2dD9T
EgMSRlRAOzt7ruMtN7S9pWaVVQr6SyymNmnEMwhe5X6Lg4v+W65762g8A7aAIKDa
EiNMQ6tSquvY8k1CO4NSRGkeyyHgsyLHxL0GRTenbkCIxkf8aNOLStetIIbh3q33
aDGWVUPzaEawo0BLCJbafoBDm/JXfIElNZfY9Hk73Xq+UghIjUSAwmeHxtei4t6k
iLKItx4eU7CLY5l82JAYNBz6Q+h8ZtX6FsAZjT6XJ8Y0cWo8t8bpZ+HDxsh8TVRX
txH+gujqQ6lH3arNmGFrZsUhbDUrRzMsAABbOyS3hsT5dqWvoeWYIi12+C6imK91
OkTgvztoDswDelvgkTbbZ/ZmkniTpIR6lerb1EbLZ1ot3Un8A64=
=A1RR
-----END PGP SIGNATURE-----

--Apple-Mail=_7DA8BBC8-3D3F-41ED-B7DD-4265FA89D2CE--
