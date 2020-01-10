Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6411013642F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 01:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgAJALZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 19:11:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:32828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbgAJALZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 19:11:25 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B82B20661;
        Fri, 10 Jan 2020 00:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578615084;
        bh=/ursooGYobJkHxZh7joDxwx6+SWWdJcogy33Ye/MQ8g=;
        h=From:In-Reply-To:References:Cc:Subject:Date:From;
        b=q+ZN5qWpafDiIwKpQU8BWxj7PSnxNvUbCSyFQglYSdcCaJtx6SCTMK8XA0XpspjQV
         fTTYHGTMWkcvCvzVWuxl8ywNBOWExTAMmbMS+OMVRyn8Cn1v8/Avp32kyLp1MwK3ND
         L7eR8JRe1ENLYDp7ILOc53pbewMIybmhsAZU4CuQ=
From:   sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200109214128.GB1027187@piout.net>
References: <20191229202907.335931-1-alexandre.belloni@bootlin.com> <20200106030905.8643221582@mail.kernel.org> <20200108110218.GT3040@piout.net> <20200109181910.59B2B206ED@mail.kernel.org> <20200109214128.GB1027187@piout.net>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: add sama5d3 pmc driver
User-Agent: alot/0.8.1
Date:   Thu, 09 Jan 2020 16:11:23 -0800
Message-Id: <20200110001124.8B82B20661@mail.kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

Quoting Alexandre Belloni (2020-01-09 13:41:28)
> On 09/01/2020 10:19:09-0800, Stephen Boyd wrote:
> > Quoting Alexandre Belloni (2020-01-08 03:02:18)
> > >=20
> > > As for the other PMC driver, we need a few of the peripheral clocks v=
ery
> > > early which means that we would have to register most of the clock tr=
ee
> > > registered early leaving only a few clocks to be registered by a
> > > platform driver.
> > >=20
> >=20
> > What peripheral clks? Can you add a comment to the code?
> >=20
>=20
> The TCB is used as the clocksource so its clock is needed. Its parent is
> the master clock which has UTMI, PLLA, the mainclock and the slow clock
> as parents so by that point, most of the tree is registered.
>=20

What in sama5d3_periphck[] is in that list? I still don't see why
platform device is rejected here.

