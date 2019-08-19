Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC891DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfHSH1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 03:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfHSH1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:27:38 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 266852086C;
        Mon, 19 Aug 2019 07:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566199657;
        bh=SZ9Ao8FfR0PuQ6iPU0Wh/DnaqMF8VJumtYhqVss2EvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5zIXe8voouEL04ALmAx6QxC326GZiAYYGDkZjaM0n+UAjB4B/PDfVrUtLR/y4Jx8
         AxUgxMLA1VjJZG3dz84Qu0AoKYmld6W6a/SDbtuGmDKJYflXgpO3EsuWETy98HYH17
         jgcHqPM6Oq/Nd5/1T7dLU3cfrcwNtIO7E+eBLTes=
Date:   Mon, 19 Aug 2019 09:27:22 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Anson.Huang@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        tglx@linutronix.de, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        daniel.baluta@nxp.com, ping.bai@nxp.com, l.stach@pengutronix.de,
        abel.vesa@nxp.com, andrew.smirnov@gmail.com, ccaione@baylibre.com,
        angus@akkea.ca, agx@sigxcpu.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 5/5] arm64: dts: imx8mm: Enable cpu-idle driver
Message-ID: <20190819072721.GA5999@X250>
References: <20190710063056.35689-1-Anson.Huang@nxp.com>
 <20190710063056.35689-5-Anson.Huang@nxp.com>
 <34c03d76-ae61-63b4-153f-3f9911cc962e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34c03d76-ae61-63b4-153f-3f9911cc962e@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 06:12:50PM +0200, Daniel Lezcano wrote:
> 
> Hi Anson,
> 
> sorry for the late review, I've been pretty busy.
> 
> If Shawn is ok, I can pick the patches 1-4 in my tree and then this one
> after you fix the comments below.

I'm okay, so:

Acked-by: Shawn Guo <shawnguo@kernel.org>
