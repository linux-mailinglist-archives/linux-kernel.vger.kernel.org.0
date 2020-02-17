Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63E716166D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgBQPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 10:43:04 -0500
Received: from foss.arm.com ([217.140.110.172]:37644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgBQPnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:43:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F72C30E;
        Mon, 17 Feb 2020 07:43:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 982983F703;
        Mon, 17 Feb 2020 07:43:02 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:43:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Sameer Pujar <spujar@nvidia.com>, tiwai@suse.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [RFC] ASoC: soc-pcm: crash in snd_soc_dapm_new_dai
Message-ID: <20200217154301.GN9304@sirena.org.uk>
References: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
 <20200217144120.GA243254@gerhold.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b1ERR0FXR0PvNIRE"
Content-Disposition: inline
In-Reply-To: <20200217144120.GA243254@gerhold.net>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b1ERR0FXR0PvNIRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 03:41:20PM +0100, Stephan Gerhold wrote:

> I'm a bit confused about this patch, isn't SNDRV_PCM_STREAM_PLAYBACK
> used for both cpu_dai and codec_dai in the playback case?

It is in the normal case, but with a CODEC<->CODEC link (which was what
this was targeting) we need to bodge things by swapping playback and
capture on one end of the link.

--b1ERR0FXR0PvNIRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KtIQACgkQJNaLcl1U
h9ARMgf+NQDaYx839skXXMcRLyATLepufKGk9l1m2+rsQ1ajEhuvgD8/e4YhVxcE
kbFp40QlkXHOJVhDmDdTzdGQAVw4bZUk4++qr0sv9wbyPE/vnN1eL1g86TN2jYYR
p6N2CzZLf6bqK10PNGgBxKu7ybsFm745FxIhEcPkYEAKUF3H9PANqu8hLvwmTNdW
YRUBomA6kOqU+odw/XwK8ztCS5cruwTjaAHZP6QsiHuGWFovmomqXJRNZhcpWXRU
HJnA40MLOI6wqd1eKDL+sZsIh26xr5hapqLdLYBwvXCh8gzup+ECt59LHEm/7hdQ
OePPOr10MHw9LA7a4ByEiuvTidCFUw==
=44+D
-----END PGP SIGNATURE-----

--b1ERR0FXR0PvNIRE--
