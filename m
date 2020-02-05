Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605DB153B6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 23:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBEWvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 17:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbgBEWvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:51:46 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5486220730;
        Wed,  5 Feb 2020 22:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580943105;
        bh=7jofB+B4X06+m/QmPPK8i8hbugSJUjDJNEOv4/+YztY=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=GXUjNVGDU3rvq+e8Cd55zKyh7jfZEp2d/wHxWUxnR4fXOOOLuxQO6gY2uYbUG874L
         94yDoivV+jh7Jm0wdOqbfhs4xHWUexD9Tucl9VcXpNWpeDDC3Qu6ClTUIFKbmfBQS1
         lSNmZZS0WPC4d3oQoEyeRcxAP8ST4gpVnWLp/2XQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200205194649.31309-1-geert+renesas@glider.be>
References: <20200205194649.31309-1-geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] of: clk: Make <linux/of_clk.h> self-contained
To:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 05 Feb 2020 14:51:44 -0800
Message-Id: <20200205225145.5486220730@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-05 11:46:49)
> Depending on include order:
>=20
>     include/linux/of_clk.h:11:45: warning: \u2018struct device_node\u2019=
 declared inside parameter list will not be visible outside of this definit=
ion or declaration
>      unsigned int of_clk_get_parent_count(struct device_node *np);
>                                                  ^~~~~~~~~~~
>     include/linux/of_clk.h:12:43: warning: \u2018struct device_node\u2019=
 declared inside parameter list will not be visible outside of this definit=
ion or declaration
>      const char *of_clk_get_parent_name(struct device_node *np, int index=
);
>                                                ^~~~~~~~~~~
>     include/linux/of_clk.h:13:31: warning: \u2018struct of_device_id\u201=
9 declared inside parameter list will not be visible outside of this defini=
tion or declaration
>      void of_clk_init(const struct of_device_id *matches);
>                                    ^~~~~~~~~~~~
>=20
> Fix this by adding forward declarations for struct device_node and
> struct of_device_id.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Noticed when cleaning up some platform code.
> I am not aware of this being triggered in upstream, but this will become a
> dependency for these cleanups.

So apply for fixes? I'll just throw it in now.

Applied to clk-next.

