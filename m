Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D418DD1B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 02:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCUBUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 21:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgCUBUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:20:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE2720732;
        Sat, 21 Mar 2020 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753625;
        bh=PKwRe7u86A+QwaW2mIzR2r5lUuReYhr5HBypXEYk/+Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vvKUbJTXpLMRO+4QAVCgX6Bpl7T1beAdx2weTIZJdSie4VPuGBsj3hzcfVq6SCqS5
         tQI8icPrdzB76QfnpHb2Yf/REase2uvUsKrK0A2+SMc9/+vE/qJfcQ9bWzDbj8f35u
         GIj951rrvLqgc2hH98vsVDcjOhKJPLawsgBVct64=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-11-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-11-lkundrak@v3.sk>
Subject: Re: [PATCH v2 10/17] ARM: dts: mmp3: Use the MMP3 compatible string for /clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:20:24 -0700
Message-ID: <158475362408.125146.4406419142833020130@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:47)
> Clocks are in fact slightly different on MMP3. In particular, PLL2 is
> fixed to a different frequency, there's an extra PLL3, and the GPU
> clocks are configured differently.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

This should go through arm-soc.
