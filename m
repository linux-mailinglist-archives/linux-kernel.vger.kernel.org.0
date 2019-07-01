Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6693094C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfEaHYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 03:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaHYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:24:33 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4870F264E7;
        Fri, 31 May 2019 07:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559287472;
        bh=PUlWGNY+r975vxDcEpTi7f2g6hL+q1Np/YBHL+1KNZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjZr9/RlqGkkGqq000MJYl5GUL6xfQHeufeggZmHINec9mRtN43RpiYHdym+cD4NQ
         PNle/f1BFDR2TmypsJiTUGaJxpOec3YrmtlJK3fMVbhgubExYccJzKXK6rF7BO7sbD
         P5Xzu9BP5gRM4uiIlCJEPEss8ybb8hW/MgUcCOZs=
Date:   Fri, 31 May 2019 15:23:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        abel.vesa@nxp.com, andrew.smirnov@gmail.com, ccaione@baylibre.com,
        angus@akkea.ca, agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH RESEND] arm64: dts: imx8mq: add clock for SNVS RTC node
Message-ID: <20190531072309.GA23453@dragon>
References: <20190524054406.3220-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524054406.3220-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:44:06PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> i.MX8MQ has clock gate for SNVS module, add clock info to SNVS
> RTC node for clock management.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
