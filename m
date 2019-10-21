Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D59ABDF683
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 22:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbfJUUKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 16:10:25 -0400
Received: from sauhun.de ([88.99.104.3]:50516 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUUKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:10:25 -0400
Received: from localhost (x4dbffd67.dyn.telefonica.de [77.191.253.103])
        by pokefinder.org (Postfix) with ESMTPSA id 870832C0076;
        Mon, 21 Oct 2019 22:10:23 +0200 (CEST)
Date:   Mon, 21 Oct 2019 22:10:23 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
Message-ID: <20191021201022.GA3607@kunai>
References: <20191018131338.11713-1-hslester96@gmail.com>
 <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I understand that this is only used for those variants that supports
> UHS-I via the renesas_sdhi_start_signal_voltage_switch(). Wolfram, is
> this fine you think?

I'll double check tomorrow.


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2uEKoACgkQFA3kzBSg
KbapZA//fFBrrLLvrg3bAaZ7CuBwPbtyzstjWpD7TY7gdaf29v5TZp4H0ZL2nFAj
N2NuwXTrPg2mmpxH9sIZoFtB9MxBCyjBnvMEuKKE/8XMsz7SAa8CWwSXdix6a70u
abCEBGrYlAdYEgJJvbcYUyBY9dnRR/YB6/BnIkpBeDYE5EFBdLviBCN0Cc8oWMaZ
qYVhAdP+fJyMu8aHh3fM0AfEzd9hNLs5cBh/cyKFSt+ySfO4TwH+3TvP09yL0Ira
bQ5K3evh/GF6DxYkpMFOxz/MbSAL06IPboB6VCzDsonAXdAYqxGnmRkHWICfYB3h
4WBQswSIqDM1sMy233maH95MObNKDmcFby17s5j+QdYwwhAui8zadBblTC/WM6o/
b1WVRoM74PThNpzYQuECXo2UbEYgcgVr192BM+uFTY9RBRfdlFqrtiMMlsfCl0hm
0qiCt0mv6JadtOFl8tpj1ChZYyC6aObx9zlI1fSJxqJGcsKMTrVAegGF9Lw68zZn
TtFs/eKVbcaGZwR2yq1nIEtjTla83FjSI1WUn8DKTTGJsBBBw3STZ0qtMZ+RsUZk
RkbjkPUAukURo9MY8n/zj4qsDZX8h8arq+y+iYd/Agv4hFLDz59uhwwf86U+kTg5
LhIHgr48cgFmygvlHGFPfYLmyljuec+0X9R55mvCvDpms9PNAJQ=
=813x
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
