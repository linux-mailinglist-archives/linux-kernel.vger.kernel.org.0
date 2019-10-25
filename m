Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61269E4185
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 04:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390024AbfJYCbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 22:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbfJYCbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:31:31 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC7B206DD;
        Fri, 25 Oct 2019 02:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571970690;
        bh=wS+ZqOi0AxyDhn3tjgIiQc5vD2xB4fXHjduh81AOn60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x/kHHoHqs74Cg37pKPiTkfnrPUKgh6AM+ieR+A4dSF5PHEy8UzPbyiASNrXJ5IleJ
         QvfPq/e2LqArQ++vhO5SPkcoXil9olRQQ8TkzbKa9vpyo8XXja+HceR/878vs1z0+M
         bhyMKZD8vHeQzhfxTtLX57QuGtooEj8U1VBgu7l0=
Date:   Fri, 25 Oct 2019 10:31:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>, devicetree@vger.kernel.org,
        baruch@tkos.co.il, abel.vesa@nxp.com, Anson.Huang@nxp.com,
        ccaione@baylibre.com, andrew.smirnov@gmail.com,
        s.hauer@pengutronix.de, angus@akkea.ca,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        festevam@gmail.com, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Subject: Re: [PATCH v4] arm64: dts: imx8mq: Init rates and parents configs
 for clocks
Message-ID: <20191025023110.GA30015@dragon>
References: <20190728152040.15323-1-daniel.baluta@nxp.com>
 <20191022161919.GA3727@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191022161919.GA3727@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 06:19:19PM +0200, Guido G�nther wrote:
> Hi,
> On Sun, Jul 28, 2019 at 06:20:40PM +0300, Daniel Baluta wrote:
> > From: Abel Vesa <abel.vesa@nxp.com>
> > 
> > Add the initial configuration for clocks that need default parent and rate
> > setting. This is based on the vendor tree clock provider parents and rates
> > configuration except this is doing the setup in dts rather then using clock
> > consumer API in a clock provider driver.
> > 
> > Note that by adding the initial rate setting for audio_pll1/audio_pll
> > setting we need to remove it from imx8mq-librem5-devkit.dts
> 
> It seems this never made it into any tree, any particular reason for
> that?

There is some discussion going on and I haven't seen it reaches an
explicit agreement.

Shawn
