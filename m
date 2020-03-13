Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F180D183E95
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 02:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCMBNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 21:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgCMBNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:13:04 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0BBB206F7;
        Fri, 13 Mar 2020 01:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584061984;
        bh=sjbzlgfG0M7ByXrwtWMDuZpQMY36kbz6RtWjf+35/zI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=H73OiFfbJkL88iOLWy+qaYjJnj5qgy2HDbcFzNn7+eMPehRXfXkSBPIOqD0QmUgmg
         vhbjAX1uG4e8Phx083IA3MG/vdEsdMdU/IJYg4Lzi6ZQMuYIXEb6lKGccD2IIKl7BF
         MEBn1A3m9aqyplMPnJft1RvVSDHYeWVcceFwaWpI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <703e21467f23f63acdac0e078b58040c39b852bf.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <703e21467f23f63acdac0e078b58040c39b852bf.1582533919.git-series.maxime@cerno.tech>
Subject: Re: [PATCH 12/89] clk: bcm: rpi: Remove pllb_arm_lookup global pointer
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Eric Anholt <eric@anholt.net>, Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Thu, 12 Mar 2020 18:13:03 -0700
Message-ID: <158406198314.149997.6304400870182426373@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-02-24 01:06:14)
> The pllb_arm_lookup pointer in the struct raspberrypi_clk is not used for
> anything but to store the returned pointer to clkdev_hw_create, and is not
> used anywhere else in the driver.
>=20
> Let's remove that global pointer from the structure.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
