Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABCC1211B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 18:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfLPRZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 12:25:39 -0500
Received: from foss.arm.com ([217.140.110.172]:34416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPRZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:25:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43C031FB;
        Mon, 16 Dec 2019 09:25:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4BEC3F718;
        Mon, 16 Dec 2019 09:25:37 -0800 (PST)
Date:   Mon, 16 Dec 2019 17:25:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Robert Karszniewicz <r.karszniewicz@phytec.de>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 0/1] regulator: of: Does always-on imply on-in-suspend?
Message-ID: <20191216172536.GH4161@sirena.org.uk>
References: <1576515981-77867-1-git-send-email-r.karszniewicz@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0OWHXb1mYLuhj1Ox"
Content-Disposition: inline
In-Reply-To: <1576515981-77867-1-git-send-email-r.karszniewicz@phytec.de>
X-Cookie: Backed up the system lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OWHXb1mYLuhj1Ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 06:06:20PM +0100, Robert Karszniewicz wrote:
> Hi all.
>=20
> Just to make sure; the oftree property regulator-always-on implies that f=
or
> every suspend state, the property regulator-on-in-suspend is implicit? Wi=
th no
> other side-effect? Reading the documentation, this is what I interpret.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--0OWHXb1mYLuhj1Ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl33vg8ACgkQJNaLcl1U
h9Agjgf/eTBhT1IRc0gwy0fBe070mHfYubFS6opXT459S3ZMYFS/Gl4syA1p1BjN
wmFuNHxQepJpHXtS5VmyJh+RRLRftF/4uiWrAyFhS+WLd2GYRiIPdhiDJtH1Pqi5
ltehB/e1Nn0KAJdOD4lOck7ComjME9l0PaJcv/n7b0pDwYyQA0BdUdFDndsn0pdX
dtVvFdBSJ5+Vc1PJfDtUE1srRssacaC9LKnfpcFsudTIst9TfRWw5iEKt1SrAi9B
uvW5BTRzW8lCpXMJlBLSPGhTtuWj8Y0S+wxMC8QsRynUBFly5ZCgVr21B3WuGCoa
Hyp3xGDVtgvQ53/cgcM6Gm2dkJjSHg==
=K9AB
-----END PGP SIGNATURE-----

--0OWHXb1mYLuhj1Ox--
