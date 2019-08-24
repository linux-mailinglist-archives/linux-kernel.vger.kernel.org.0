Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 175AF9C032
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfHXUrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 16:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfHXUrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:47:45 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B7023400;
        Sat, 24 Aug 2019 20:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566679665;
        bh=TJqij8c/dTiUq/2K83ATZKYkTkvjNo6UP+zrCOvUTKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBqEGbCuzVfuP9xucEQG37JN2EqZ5NxttIi1Vs4YkTCSn03KAWzl6V4AL+qJerkv9
         k49976kLMPUGVRwtAOcuQm06kAzqjw1ChQXaU21ER4q5LNvFtHAB/Gw4MszwhiPEsg
         rURC4XI+3/uCPpa2xTIcfBgt3wV5mbpm3bpQZV8E=
Date:   Sat, 24 Aug 2019 22:47:31 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: imx8mq: Add mux controller to iomuxc_gpr
Message-ID: <20190824204730.GM16308@X250.getinternet.no>
References: <cover.1566471985.git.agx@sigxcpu.org>
 <fa3b1df7fc5e74f375df5de53061d1a93d154b51.1566471985.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa3b1df7fc5e74f375df5de53061d1a93d154b51.1566471985.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 01:10:23PM +0200, Guido Günther wrote:
> The only mux controls the MIPI DSI input selection.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks.
