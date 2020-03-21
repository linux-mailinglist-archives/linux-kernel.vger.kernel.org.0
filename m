Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302E318DD43
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 02:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgCUBZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 21:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgCUBZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:25:12 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C27B20752;
        Sat, 21 Mar 2020 01:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753911;
        bh=n8yjlr1b1s9SpEYtzTJTlVAWXrwLsk7f/ZXVv70T3gY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VsgEMTH0rs+SofkFeNpBwczp/5+1BYuRAc93rARWuGmr8OnnTpaZeCbTU/YnDBxhC
         WXwT2gqjuS/PhGnfx53MHI5c0CpisjD9XIak4x3eRxhyjJd2o7Zu2uKYjP5gSySbw/
         9JmIlf0Uc6x9BRXe7Uo5LEm0g+s2bSErdLwYAn94=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-12-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-12-lkundrak@v3.sk>
Subject: Re: [PATCH v2 11/17] dt-bindings: marvell,mmp2: Add clock ids for the GPU clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:25:10 -0700
Message-ID: <158475391092.125146.7678854836734974845@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:48)
> MMP2 has a single GC860 core while MMP3 has a GC2000 and a GC300.
> On both platforms there's an AXI bus interface clock that's common for
> all GPUs and each GPU core has a separate clock.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Applied to clk-next
