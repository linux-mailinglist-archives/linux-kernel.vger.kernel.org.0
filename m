Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4AF5A7DE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 02:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfF2Ad1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 20:33:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfF2Ad1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 20:33:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45bF3m2GWVz9s4Y;
        Sat, 29 Jun 2019 10:33:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561768404;
        bh=2rnkgoVCNl6T9AFkgEUYGK1CF5Gp3iHLZ1ROdDv2nDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OBn1+/tysERdPthOZdJuB/A6wcfJvzG8pqtRTo0Df3X4LUoLrxmgkpc5HNkb9IxFb
         5+pwMyv0heZt00ZADoSkgmq0lHovPmpY0eTZIUY4/mpIDfYV5LKs7VTyseY9vxOHUy
         yUM7CjN9IF+vTPcleMEo3BxRriSdv0otMgQZGIgYxL1tIWgrrHMBOy9fZ5fiv30DUs
         FK1ysJwwqCcjTovAO4CqP68LIUHHQwhTU+m++buE7wBdsA2xgsqo+y/+33sR9Myn3n
         PX0RkMdiA2zWYW1zWLElWmaOrd9X6tL1KwtE9+fdRxfNO3eQ2lybx68uRn479CRtkz
         HlyIcRylDc3tg==
Date:   Sat, 29 Jun 2019 10:33:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Crews <ncrews@chromium.org>
Subject: Re: linux-next: build failure after merge of the battery tree
Message-ID: <20190629103317.421ed4b6@canb.auug.org.au>
In-Reply-To: <d3515009-c922-7aa6-2ded-4ca39ed324f2@collabora.com>
References: <20190628140304.76caf572@canb.auug.org.au>
        <20190628153146.c2lh4y55qvcmqhry@earth.universe>
        <d3515009-c922-7aa6-2ded-4ca39ed324f2@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EV3ZVoILqOP7tCULXoI=mx0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EV3ZVoILqOP7tCULXoI=mx0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Fri, 28 Jun 2019 18:56:56 +0200 Enric Balletbo i Serra <enric.balletbo@c=
ollabora.com> wrote:
>
> Hmm, I just applied this patch on top of linux-next and it build with
> allmodconfig on x86_64
>=20
> I am wondering if the build was done without this commit, which is in
> chrome-platform for-next branch. Could be this the problem?
>=20
> commit 0c0b7ea23aed0b55ef2f9803f13ddaae1943713d
> Author: Nick Crews <ncrews@chromium.org>
> Date:   Wed Apr 24 10:56:50 2019 -0600
>=20
>     platform/chrome: wilco_ec: Add property helper library

Exactly since I merge the battery tree before the chrome-platform
tree ... Cross tree dependencies are a pain.

> Anyway, I think the proper way to do it is create an immutable branch for
> Sebastian as the patch he picked depends on the above commit. I'll create=
 one,
> sorry about that missing dependency.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/EV3ZVoILqOP7tCULXoI=mx0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0Wsc0ACgkQAVBC80lX
0GxE+Qf+LWHhQMfML7/yMhynM0XlpayytjoF8f5fmrFFc4kZzKax2ML6G43B0Umi
eAPjYaLanaD6XtLwSQ8T0gUSsdW4ery0ScohPs3RGHStpgYkQsx1KEMR3HmHFP8Z
7Oc2SNNq6I0uPBWo/Gb7Rs8ysL2JqldTD870nFukthLEvrRa21sg3XtR1THmZdD5
VcDYWzJ1dIGKINimqi6jo+sc9dKzlurMyanVw7ElkXsJ1+mTAQMQ7HcipRdO3Obd
xSMxBlX9bErTXwkXZ82qfb54KiL7ydUeGSJHJLPLsme25UthY0lW7kzfgmjEwBgt
N3BjJRzsXwJDTlGgxNe8Z8EEQN4ZdA==
=xJA6
-----END PGP SIGNATURE-----

--Sig_/EV3ZVoILqOP7tCULXoI=mx0--
