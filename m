Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEACE183D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 00:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCLXRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 19:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgCLXRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:17:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E8520637;
        Thu, 12 Mar 2020 23:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584055073;
        bh=QepFjxAZCdw4rXsCdCvk71ljF1gNrapkk/Ira5TscFM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OrSejX72s2mt+UCjcjs8je8y7xAEnQCUR0GLcQcvO9Y34/g+JnXjtwETDdF+ccoNZ
         N5eBxqY77EtNebU2RteYBBDHDFUkEMPC9f5cx0FD86iGsJtY95jtrzzHqttpXuh7+J
         kyU007r5eukTSF+SnR4t1fzcrtBOP6b98stixg10=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1c47c839fda93460994d37b4c851d805a3282d5f.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <1c47c839fda93460994d37b4c851d805a3282d5f.1582533919.git-series.maxime@cerno.tech>
Subject: Re: [PATCH 09/89] clk: bcm: rpi: Use clk_hw_register for pllb_arm
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
Date:   Thu, 12 Mar 2020 16:17:52 -0700
Message-ID: <158405507267.149997.9253782069794352377@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-02-24 01:06:11)
> The pllb_arm clock is defined as a fixed factor clock with the pllb clock
> as a parent. However, all its configuration is entirely static, and thus =
we
> don't really need to call clk_hw_register_fixed_factor but can simply call
> clk_hw_register with a static clk_fixed_factor structure.

Please add () to things like clk_hw_register_fixed_factor() and
clk_hw_register().

>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
