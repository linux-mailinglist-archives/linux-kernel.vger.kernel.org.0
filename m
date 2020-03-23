Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0FB18F334
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 11:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgCWK4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 06:56:21 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:50107 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727874AbgCWK4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:56:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 6A43D47D;
        Mon, 23 Mar 2020 06:56:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 23 Mar 2020 06:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=fzpRCAmsyk5yn3no7NdCLTL9Xu4
        x7dq5wW+w+4PqNzo=; b=qjncN70i8E/mm68IiqelYpyQxaqaLFMFkq552WiZ0Ji
        RDnn/NVEiKwbPBkt2W9lxujvSitEatfIuvVuj78XE0PcmTk+hzhcz32ZYhhtM/60
        1yFzSlh9H/oBHVjcFJ2ugGcpKarGWqzjiTKFex07KRbzpvbdVf3PAv/VcUoR/lEE
        4Mot7T+dlrf+JN6aOHzR5EnTO9QxbMDHptMN9yXpWIF3+F9y4LIkzkSMZGx2pWtX
        eRWw3eyev+hZ+str3PdFD3tz8rBoKp737Mw4xtdpoMs32adEhVUPxmogt2MyYJ61
        wvNhvrQaE0WfsJKQNeLIf0hlfT9kkHEOSRIeNDJTpgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fzpRCA
        msyk5yn3no7NdCLTL9Xu4x7dq5wW+w+4PqNzo=; b=cE7OolyF0peWljveJycKKO
        zgMMYtHV+pOFwh6Kmd6FjS3CP/+dOVKARo6nxtG8RqXaYMk0oxNUtX/r5t4uzYfJ
        ZfoTXKnfD9BLHiemRmNxe/Xjoa7iM2bHZWVxMVCKDh99eCJp/7+cdLObC/GpnflV
        1Avfs9ubY8SAgqT0wiE9/fvNICQXjzupm0tgLW7rFcKwOwdKcUfaUKY39TcyZ+Oo
        vGYIPzRBbyYmSY6T2s1DCdvEyosqg++n/woeb+t9tMYE+DiOZJGWeDQjX/1HyK5E
        nd7oA0OaxQeT1Ic99a9lrnRY63dcHnogyo8riCVTL2kprKBnMQJM/UMzPVf515sQ
        ==
X-ME-Sender: <xms:0pV4XpGakGjxFm5WSUO12GozMq6f_D1A6FSPkAn00TVm_p6d4s6Ang>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudegkedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:0pV4XikLQU1_NHrUyExDlyHq0J-4oojakDBlFW9FsrNR-C2JnF1hZw>
    <xmx:0pV4XmKDL-6HyZMPOqYR6s0tWnJrzCMMMdwAO5GIRETYm08AjRr-WA>
    <xmx:0pV4XjYGnEMLXt1wHnszQKokWtv-_l8H_BluGP_LWAI0VCj_lKT5Dw>
    <xmx:05V4XimO5x58E3e7V1Pcv11tNhvCMfJifrwgWq7JC9tH9wENGCIu1criPgA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DED263280067;
        Mon, 23 Mar 2020 06:56:17 -0400 (EDT)
Date:   Mon, 23 Mar 2020 11:56:16 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 27/89] clk: bcm: Add BCM2711 DVP driver
Message-ID: <20200323105616.kiwcyxxcb7eqqfsc@gilmour.lan>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <6dd6bd48e894c1e8ee85c29a30ba1b18041d83c4.1582533919.git-series.maxime@cerno.tech>
 <158406125965.149997.13919203635322854760@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tfljntymmeg4eptb"
Content-Disposition: inline
In-Reply-To: <158406125965.149997.13919203635322854760@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tfljntymmeg4eptb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

On Thu, Mar 12, 2020 at 06:00:59PM -0700, Stephen Boyd wrote:
> > +       dvp->clks[1] = clk_register_gate(&pdev->dev, "hdmi1-108MHz",
> > +                                        parent, CLK_IS_CRITICAL,
> > +                                        base + DVP_HT_RPI_MISC_CONFIG, 4,
> > +                                        CLK_GATE_SET_TO_DISABLE, &dvp->reset.lock);
>
> Can we use clk_hw APIs, document why CLK_IS_CRITICAL, and use something
> like clk_hw_register_gate_parent_data() so that we don't have to use
> of_clk_get_parent_name() above?

That function is new to me, and I'm not sure how I'm supposed to use it?

It looks like clk_hw_register_gate, clk_hw_register_gate_parent_hw and
clk_hw_register_gate_parent_data all call __clk_hw_register_gate with
the same arguments, each expecting the parent_name, so they look
equivalent?

It looks like the original intent was to have the parent name, clk_hw
or clk_parent_data as argument, but the macro itself was copy pasted
without changing the arguments it's calling __clk_hw_register_gate
with?

Maxime

--tfljntymmeg4eptb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXniV0AAKCRDj7w1vZxhR
xTnlAQCIhFMKlCTUi7lT7vtutsg55UjNkCiTBydMK2jwFL/FAwD/SNvqj7HP9kXi
Uu9uGwZ9ol7SO9ZaYUzJVfxPPZbXQww=
=Ie9e
-----END PGP SIGNATURE-----

--tfljntymmeg4eptb--
