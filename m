Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F57E11A4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 08:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfLKHVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 02:21:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfLKHVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:21:24 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D8A32053B;
        Wed, 11 Dec 2019 07:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576048884;
        bh=kG7sfIidpR8oL8javegGgjo0SoQyKPL+2I74fCGLp+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPHk2woG8K6DR9wRxtmVn/sRpq2WuJlE4z4yLk+EOJoZk1jUjDcWsMAdBdYSJLDs/
         Aad7IxS3N+Zi704DAr1bULXTJOlTOvGaHB1rsRxhOyuWbTvVR9IRp8Rq+pRlbgwUQ9
         KeXBAWBlRflhwyxW0w4502rTI5JHTDvazs0MazmM=
Date:   Wed, 11 Dec 2019 15:21:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2] ARM: dts: colibri-imx6ull: correct wrong pinmuxing
 and add comments
Message-ID: <20191211072111.GN15858@dragon>
References: <20191209103234.35972-1-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209103234.35972-1-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 10:32:53AM +0000, Philippe Schenker wrote:
> Some pinmuxings are obviously wrong, originating from a copy/paste
> error. This patch corrects that with the following strategy:
> 
> - Set all reserved bits to zero
> - Leave drive strength and slew rate as is
> - Add sensible pull and hysteresis depending on the function of the pin
> - Not used pins are muxed to their reset-value defined by the SoC
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Applied, thanks.
