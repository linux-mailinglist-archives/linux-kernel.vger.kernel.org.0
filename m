Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A732C0EC9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 01:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfI0X6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 19:58:13 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45046 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0X6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 19:58:13 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1iE07c-0007q9-5M; Fri, 27 Sep 2019 19:58:00 -0400
Message-ID: <759a67a390145b2a6a2d2f33af61d791b4119708.camel@surriel.com>
Subject: Re: [PATCH v3 01/10] sched/fair: clean up asym packing
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com
Date:   Fri, 27 Sep 2019 19:57:59 -0400
In-Reply-To: <1568878421-12301-2-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
         <1568878421-12301-2-git-send-email-vincent.guittot@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-sfIEp8aBpcrUw9Eq3E4/"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sfIEp8aBpcrUw9Eq3E4/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-19 at 09:33 +0200, Vincent Guittot wrote:
> Clean up asym packing to follow the default load balance behavior:
> - classify the group by creating a group_asym_packing field.
> - calculate the imbalance in calculate_imbalance() instead of
> bypassing it.
>=20
> We don't need to test twice same conditions anymore to detect asym
> packing
> and we consolidate the calculation of imbalance in
> calculate_imbalance().
>=20
> There is no functional changes.
>=20
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-sfIEp8aBpcrUw9Eq3E4/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl2OogcACgkQznnekoTE
3oOsjwgAvXNMLNuc8WyphDyidtU/y1GnsgK1MGTbmVTgn+8K1FihQ2ktd4fVfp+u
6SC5CW9JACikX2S4+pdQ9bueio7xnWZxSHAxDgpiYHGhhmvZ5HEtQSdWBNm3Y8jd
VVzJJX6qjbcLjFcmA9tpdZ2GTgRnTP+J8dpE9e8NFV1svjsylnpMGfwziAwZh53O
G7bKtm8Pux5ZUeNVh6p5sIgtEBYsSI+JHWB829/6TtGDNNG30GZFVJujEITdGjRS
jXdG4+vt2I2JHZnNGuf3tBnFp51cYiXb6qRCdV12n9H6T1OZ8mn1Fmn5In09rSyA
4Ln3gWxzb/yWkuidCKb48HBOHzVwEA==
=G/Pg
-----END PGP SIGNATURE-----

--=-sfIEp8aBpcrUw9Eq3E4/--

