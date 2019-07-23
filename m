Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6107371159
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 07:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbfGWFrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 01:47:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36476 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfGWFrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:47:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so39829373ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 22:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc:message-id:references
         :to;
        bh=IrDcbT/Tj7LW4qQdP9pAY4oN/qCVl2lkLiDwRQqQvc8=;
        b=vTWONxEz9UUSnXiuneklcR1laKpRjeYEhhaoWkQHlR71Ag/K8rtfJK2zG884XpH2Ud
         t7OtIc7XhkzcptTogl1wYN4WVnFeisp8/52o0jCP9DQowkSJeetZoaeRnc2xecaFjZgM
         yalWDTjVRc0BcFr8xK6tER1Q1qAoh1hnlY+j5Wlqxz5ghEp5aa3/QayFhWhcxrAUJoQS
         ytUn7krdijVvHLsNZE69Kae0MeAsClgAvnW1eSW1E2m7rWBnW4v2GpGgwEp0auAcqVoH
         t0Kw6BTzNpxv/BjlVVRjHfpw9YBGtJdaNn9MSMsOpBUBrmyA/k9YbB/z9Pl99etArs0J
         JnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=IrDcbT/Tj7LW4qQdP9pAY4oN/qCVl2lkLiDwRQqQvc8=;
        b=rny04dDVgPFk3MXY1bQpha1yb7R9l8W89Bj5SC9pZRM3XK2YLMd9+TFb39ETRWS2ZG
         qo1fpv5MxBzxHwkDF2YjQvFSHt1NDAOnppxIwdB6TU3O8V7/47GaRtQxOxUtUN7u259W
         Vf84iWz2gjCvLf+ID/LehCcKiJJ3ExptqWkiX1KAIUv0/ubanigMU4+JbSAlii/J7dfw
         0olWHiHnwd8PsLFZOtuz22w52h6dEGmfco52Wfl+lw8nSGvfj95C3+8vfUhGlLpM+njV
         M4qd6VLAw2iHabFS/M8o+T3cn2eS7O55qeksM7dFsKVB9oVoZSfh4ef/7+zzBLK8JeEl
         CcUw==
X-Gm-Message-State: APjAAAWAIkGhQmiktTnzvtWNb7rAxx/yV2jOf5XhDkxUcmhYl8XDWCRb
        1u05BQqNBI5b+0e0mRQdD8Y=
X-Google-Smtp-Source: APXvYqyQdg/ZkVNgm9xmjks50Y9ZPndCooHtzQc1BjfTJIx+KUxCra6dfSX77NigPwyGNWeQ2m0ZZA==
X-Received: by 2002:a2e:8e83:: with SMTP id z3mr37958388ljk.98.1563860840165;
        Mon, 22 Jul 2019 22:47:20 -0700 (PDT)
Received: from [172.20.10.13] (212.27.18.194.bredband.3.dk. [212.27.18.194])
        by smtp.gmail.com with ESMTPSA id c30sm6358929lfp.70.2019.07.22.22.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 22:47:19 -0700 (PDT)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_8CF3AAB6-07CE-49A2-A597-846037581ABC";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] lightnvm: introduce pr_fmt for the previx nvm
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
X-Priority: 3
In-Reply-To: <20190722043101epcms2p2645d83b2c4aca7fc446f8d9109342327@epcms2p2>
Date:   Tue, 23 Jul 2019 07:47:15 +0200
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Klaus Birkelund Jensen <birkelund@gmail.com>
Message-Id: <45E0A0E6-52B0-4BF9-B816-33F6ECDD0E5F@javigon.com>
References: <BYAPR04MB5749126EF9E68D94125BACB486CA0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190720083043.23387-1-minwoo.im.dev@gmail.com>
 <CGME20190720212747epcas1p4d3e17fefd1cbd2007a1a1a452dde9c55@epcms2p2>
 <20190722043101epcms2p2645d83b2c4aca7fc446f8d9109342327@epcms2p2>
To:     minwoo.im@samsung.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_8CF3AAB6-07CE-49A2-A597-846037581ABC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Jul 2019, at 06.31, Minwoo Im <minwoo.im@samsung.com> wrote:
>=20
>>> @@ -1111,27 +1112,27 @@ static int nvm_init(struct nvm_dev *dev)
>>>  	int ret =3D -EINVAL;
>>>=20
>>>  	if (dev->ops->identity(dev)) {
>>> -		pr_err("nvm: device could not be identified\n");
>>> +		pr_err("device could not be identified\n");
>>>  		goto err;
>>>  	}
>>>=20
>>> -	pr_debug("nvm: ver:%u.%u nvm_vendor:%x\n",
>>> +	pr_debug("ver:%u.%u nvm_vendor:%x\n",
>>>  				geo->major_ver_id, geo->minor_ver_id,
>>>  				geo->vmnt);
>> The above last 2 lines can be squashed and pr_debug call can be made =
in
>> 2 lines since you have removed the "nvm:" which shortens the first =
line.
>=20
> Yeah Okay.  Will prepare V2 with this and also s/previx/prefix in the
> title.
>=20
> Thanks for the review.
>=20
> Minwoo Im

Besides Chaitanya=E2=80=99s comments, looks good. You can add my review =
on V2.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_8CF3AAB6-07CE-49A2-A597-846037581ABC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAl02n2MACgkQPEYBfS0l
eOAimBAAoRaQlUo+9zVTRoh3Xb2a+uWuwlxa2jeVXJLZ6GpUGNcibZrcSjas44L5
YN/tN59dr7/G0bsryzgOQ/X3TXPOIUZI2RloWrhxcihgylT+81dNJsd2qaoGfPnX
RbZQ7oRpvFmj0uN4QMD7TUqHhAXotvoh3HcXXmWlXWwO/hFeMZN8XqnN0JqJEIYn
1L3tWML1DuEbkkllm+QZMPedXyhCxYOqTRjnIziHTI9RCJtWYqmNdrgLxx7pbdlK
TNByGc6BxNU4rvJrsi7yDWH50EDYcIKDYjWnCM/jHYz8M0IjSq3/OxXtLvHVtBCO
LmTIy/6uOqBPdIDYPBc2IkwMhmT5ZSxE0BfL8ME/CWDua1KLaKfc+Nw5bK/Dllnn
+rqsRAE34ZlbGdANWY7pPiRSHPRlATh+2OWoIuqhgnhx90UPPC5NaceZrMZ9tlTQ
a4rYPENHHigD383kJ5EYCt9fShOKeEef0STFyTjiWlDGTVgPbny7hGc0SvKiU2mX
XVHL2n50YstjpSF6ZJFY9q51aYJvkINcG2Vte25cpFIw3vBKKBn+78LVs2W9yXco
VOdxXAu5kQiIFkcPoHioWVLJYX26FCpvJo2BTtkqqeE2OPCQU2i8DelIHEV38rpR
W4TXHgfKvowcirfzVUp3IEh3BL/1C0ENm0DPTQWRE/1uCa3C+hI=
=GMX1
-----END PGP SIGNATURE-----

--Apple-Mail=_8CF3AAB6-07CE-49A2-A597-846037581ABC--
