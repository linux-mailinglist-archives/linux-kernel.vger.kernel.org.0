Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5F1837F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCLRqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 13:46:32 -0400
Received: from foss.arm.com ([217.140.110.172]:39110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgCLRqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:46:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C597930E;
        Thu, 12 Mar 2020 10:46:31 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4565A3F67D;
        Thu, 12 Mar 2020 10:46:31 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:46:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] ASoC: fsl_asrc: rename asrc_priv to asrc
Message-ID: <20200312174629.GI4038@sirena.org.uk>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <8282b290d39dd8dae5da02f5cbb3f647fa778aa0.1583725533.git.shengjiu.wang@nxp.com>
 <20200309213016.GC11333@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PWfwoUCx3AFJRUBq"
Content-Disposition: inline
In-Reply-To: <20200309213016.GC11333@Asurada-Nvidia.nvidia.com>
X-Cookie: Security check:  =?ISO-8859-1?Q?=20=07=07=07INTRUDER?= ALERT!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 02:30:17PM -0700, Nicolin Chen wrote:
> On Mon, Mar 09, 2020 at 11:58:31AM +0800, Shengjiu Wang wrote:
> > In order to move common structure to fsl_asrc_common.h
> > we change the name of asrc_priv to asrc, the asrc_priv
> > will be used by new struct fsl_asrc_priv.

> This actually could be a cleanup patch which comes as the
> first one in this series, so that we could ack it and get
> merged without depending on others. Maybe next version?

Yes, please.  Or even just send it separately.

--PWfwoUCx3AFJRUBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5qdXQACgkQJNaLcl1U
h9BEJgf+LDZKX86NoQW0sAyHfoI5bU8JDqMp0vov4A8JY6xc4HBhugGfdjg8WRoa
CaqNzRLw0m6VFU+a/AxSv5OADsO1vkjA08+yXeuWr7wKxasqSAmBwq7tjsa9Cu7S
QB0UowCO1N3Zn7zeWYFoJxiJ1iPlz9rUTDLw6U50yckkct9JlCnTKLmPpO7q5SRN
DSqUC5+8Hc/SZGOSKLoYc1SFqFaNLUxuF7O2harTjFRbWeuEaptWcgmf2CeXgtI0
pFBfaexsGndY8dFMvwkNeD74Yctt4xnefQRXwbMsbfhDpJFdruxSXYNkBHYMsIUk
YzSFifSaFrNhKESXNDY0arVypHltMg==
=rfH4
-----END PGP SIGNATURE-----

--PWfwoUCx3AFJRUBq--
