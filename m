Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC0E249E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 10:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfEUIL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 04:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEUIL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:11:26 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 147EA2173E;
        Tue, 21 May 2019 08:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558426285;
        bh=R/j36jSLiHEXOJzBJjaloAyDWROilV/KiZzl4mM07a4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8vEul29sPIfyx86SKdJcCNLlbSiqiT7O9SgaqlAk+k88va2mDO6SZvtNhTTAmCnY
         10v9oDtekAuqNtj3kE5T55uQ5zgqfM1OSJo6Kzl86ahfCdhTX/3R/D5yjQxJGESfID
         4s0IkGvxjRwSEqw+rFmMUXBcQk7ILVGdMYMi0U04=
Date:   Tue, 21 May 2019 16:10:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mq: Remove unnecessary blank lines
Message-ID: <20190521081025.GD15856@dragon>
References: <1557813807-3919-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557813807-3919-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 06:08:29AM +0000, Anson Huang wrote:
> Unnecessary blank lines do NOT help readability, so remove them.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
