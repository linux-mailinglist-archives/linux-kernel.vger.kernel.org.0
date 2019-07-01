Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE4513194
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 17:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfECPzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 11:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfECPzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:55:49 -0400
Received: from localhost (unknown [104.132.0.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9CA22075C;
        Fri,  3 May 2019 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556898948;
        bh=D/XvJumUDNMV2xTwtOxmC4nWMEvGO3oJYlWKxAScgsQ=;
        h=In-Reply-To:References:To:Cc:From:Subject:Date:From;
        b=Vl1yP0w7dkC2K37JUCwcR6gWlrZnKjz8vWidBKP1ahFZ2dWxMzeypvHL6jmBeCQrn
         4m7KCqWqiV6hoincYcaKEjnnUviLXouGsx+6XclvGS+8X7nA1LD0mvSNRxeY9arV4J
         HptkoOzjePOhJKv2k+fg9Y1Ocx/fFlGSoIAKeX3g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190503092511.0054911e@canb.auug.org.au>
References: <20190503092511.0054911e@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: linux-next: build failure after merge of the clk tree
Message-ID: <155689894782.200842.4115245530077819749@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 03 May 2019 08:55:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2019-05-02 16:25:11)
> Hi all,
>=20
> After merging the clk tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>=20
> arch/arm/mach-omap2/omap_hwmod.c: In function '_get_clkdm':
> arch/arm/mach-omap2/omap_hwmod.c:669:35: error: 'CLK_IS_BASIC' undeclared=
 (first use in this function); did you mean 'CLOCKS_MASK'?
>    if (__clk_get_flags(oh->_clk) & CLK_IS_BASIC)
>                                    ^~~~~~~~~~~~
>                                    CLOCKS_MASK
> arch/arm/mach-omap2/omap_hwmod.c:669:35: note: each undeclared identifier=
 is reported only once for each function it appears in
>=20
> Caused by commit
>=20
>   7c36ec8a90a8 ("clk: Remove CLK_IS_BASIC clk flag")
>=20
> I have used the clk tree from next-20190502 for today.  (The above commit
> does not revert cleanly.)
>=20

Sorry, I got confused and merged the wrong branch over. Should be fixed
up now.

