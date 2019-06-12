Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD0242307
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 12:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408153AbfFLKvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 06:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408073AbfFLKvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:51:33 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA2B2082C;
        Wed, 12 Jun 2019 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560336693;
        bh=5jRu86QAzs8zA/gs6Ny1LZmMgOJJIteMCKmKfzBwhHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0ls4eEvZEtUNYXQwDlIQ4pDBNaY2f40S56gTpQwSvu0MSqD38juSsqmRfqKf1KnW
         2ysxeCtP8pcQv9OpTLgAtGTR8X0fjCiDCTBJwxM6YHYOuw+bTJq17DCwCisAUFtqh2
         4MxqM16t3QM1jduhmlQY9N9RHdhYruyUm5hoqV50=
Date:   Wed, 12 Jun 2019 18:51:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20190612105059.GG11086@dragon>
References: <20190607074652.4b3d0c97@canb.auug.org.au>
 <20190607002407.GY29853@dragon>
 <AM0PR04MB44817EB65913F29630453E1A88ED0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB44817EB65913F29630453E1A88ED0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:36:52AM +0000, Peng Fan wrote:
> Hi Shawn, Stephen
> > Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
> > 
> > On Fri, Jun 07, 2019 at 07:46:52AM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > In commit
> > >
> > >   f6a8ff82ce68 ("clk: imx: imx8mm: correct audio_pll2_clk to
> > > audio_pll2_out")
> > >
> > > Fixes tag
> > >
> > >   Fixes: ba5625c3e27 ("clk: imx: Add clock driver support for imx8mm")
> > >
> > > has these problem(s):
> > >
> > >   - SHA1 should be at least 12 digits long
> > >     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> > >     or later) just making sure it is not set (or set to "auto").
> > 
> > Hi Stephen,
> > 
> > Thanks for reporting.  I just got it fixed, will be more careful about that in the
> > future.
> > 
> > @Peng, please check your git configuration as suggested above, thanks.
> 
> Sorry for this. Do I need to resend the patch?

No.  I have fixed it on my branch.

Shawn
