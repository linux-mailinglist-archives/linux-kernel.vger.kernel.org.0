Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3EB15A87A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 13:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgBLMAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 07:00:35 -0500
Received: from foss.arm.com ([217.140.110.172]:60106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgBLMAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:00:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DAEE30E;
        Wed, 12 Feb 2020 04:00:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A54FF3F6CF;
        Wed, 12 Feb 2020 04:00:33 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:00:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     vishnu <vravulap@amd.com>
Cc:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: Buffer Size instead of MAX Buffer
Message-ID: <20200212120032.GD4028@sirena.org.uk>
References: <1581426768-8937-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200211153847.GK4543@sirena.org.uk>
 <c4b900ee-743e-8ce0-1061-02c383bff90e@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <c4b900ee-743e-8ce0-1061-02c383bff90e@amd.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 02:36:32PM +0530, vishnu wrote:

> prior to this fix the value in Tx/Rx Ring Buffer Size register
> ACP_BT_TX_RINGBUFSIZE,ACP_BT_RX_RINGBUFSIZE and same in I2S RINGBUFSIZE
> registers was statically set to maximum which is wrong.
> Buffer size must be equal to actual allocated.

OK, makes sense - this is the sort of thing which should have been in
the commit message.

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5D6N8ACgkQJNaLcl1U
h9DZiQf/dWgDV9LNXeiT35fpCE0NNPfQAot1I/qWDk4lx8xnWZkk7Yst9HKWTZ45
5QMT35X8ffIrVDWwbiIWfN+ba+z89OhY5vInIfxYQQ4iRJXnOVEwN4LaCub00Iq+
XfO+f5Y0nB7aQEFeMWFC1mduSg2uGNK7+p4AXhXVI33tfl2uJhzIM7vRhdMW1+9F
SxZhZAT3SZaUwbHD3QE35wGSZvxM+902oXYLMsac9USfVNj2DjcUNvU0xXHE6p25
XES2+b++z6ihK9p4ZggZ0mSLdRwLMGatIWdXLrNvU6EQlJeAFM623z7cyskVWBEp
IpgjwHZYEkN85PbpOutNNmEaCljHEA==
=Bcit
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
