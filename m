Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE6218DD56
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 02:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgCUBZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 21:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgCUBZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:25:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AFEC20753;
        Sat, 21 Mar 2020 01:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753937;
        bh=oAJ8P7kfcTRF3VUPHD9jiZM2Uu8T5UeR/9sCfYxFsAo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=o44fhJwJH8lHLGrll/d9AkF6QoSeNJzJ9jl4Ywmv9eBTFlx+3Ws4qQJjr5TEcRvIF
         rLl6i6ra7iJPysT4HN2c2p2EsJtTgzWePopgoDsv0I9mXK14Og9DWA4m/GX3Ogf/Ll
         /iQET8XVx/qEWMM2laDYdaWfQA4zFM/WqXZ/N+tc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-18-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-18-lkundrak@v3.sk>
Subject: Re: [PATCH v2 17/17] clk: mmp2: Fix bit masks for LCDC I/O and pixel clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:25:36 -0700
Message-ID: <158475393645.125146.318461661270082621@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:54)
> They were reversed because I read the datasheet upside down.
> Actually there is no datasheet, but I ended up understanding the
> comments in Open Firmware driver wrong.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Applied to clk-next
