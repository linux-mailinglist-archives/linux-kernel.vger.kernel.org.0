Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E513823E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 02:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfFGAlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 20:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfFGAlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 20:41:39 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BF4B20840;
        Fri,  7 Jun 2019 00:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559868099;
        bh=1vBgXQP1RrooBCqpqPpJd49Z0ROP6YAncbyQUWEg38E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RfblBthgc+Z0mKHDGUh/hG3I+ddM9slbmysMntqXwK6uHew8pK3P9uBfAR0C26rH2
         M3d22k7XkDog1lnm5AXAxFprI+6GH3qWBi4S9dAiA/VAxP+VGocEdVL1hEOzxfsYNj
         B1jaIre4e8lxXu3jQaal2HsJ5+xikw6yp7BWGe2c=
Date:   Fri, 7 Jun 2019 08:41:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND v2 00/18] clk: imx: Switch the imx6 and imx7 to clk_hw
 based API
Message-ID: <20190607004117.GZ29853@dragon>
References: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
 <20190606182940.F0D8C20872@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606182940.F0D8C20872@mail.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:29:40AM -0700, Stephen Boyd wrote:
> Quoting Abel Vesa (2019-05-29 05:26:38)
> > Resend for the following:
> > 
> > https://lkml.org/lkml/2019/5/2/170
> 
> What's left after this series to convert over to clk_hw based APIs? I'm
> happy to see this merge as long as we eventually delete the clk based
> versions of the code in the imx driver so that we can complete the task.
> 
> I took a look over everything and nothing stuck out, so:
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> 
> for the series.

I just applied the series to my for-next branch, so that it can be
pulled into linux-next for testing.

Shawn
