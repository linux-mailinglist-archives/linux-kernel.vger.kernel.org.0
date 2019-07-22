Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35E86F7C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 05:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfGVDM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 23:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfGVDM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 23:12:56 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0538521926;
        Mon, 22 Jul 2019 03:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563765175;
        bh=4J1ZS8KDxWC9kU9QNz5EVAz+X7JyqG51qQGWo6AiJVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJQ+rBDExWiTZ5ZHlB0Guc4sYnJvfjBrQd30L7GHEgRWlhvmM8iGOWPhvdAy3SUCG
         zzJ7Bd64+zMSU5PfmqSyZp0/qXNZw2n5j4UHBWlRq0g8AdnSaEemdWdv7PRiUcPF/+
         HxDIr8IF/F12DaxO6wQonc9qB8KdMq51Hpr8yb38=
Date:   Mon, 22 Jul 2019 11:12:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        daniel.baluta@nxp.com, ping.bai@nxp.com, l.stach@pengutronix.de,
        abel.vesa@nxp.com, andrew.smirnov@gmail.com, ccaione@baylibre.com,
        angus@akkea.ca, agx@sigxcpu.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 2/5] arm64: Enable TIMER_IMX_SYS_CTR for ARCH_MXC
 platforms
Message-ID: <20190722031224.GS3738@dragon>
References: <20190710063056.35689-1-Anson.Huang@nxp.com>
 <20190710063056.35689-2-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710063056.35689-2-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 02:30:53PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> ARCH_MXC platforms needs system counter as broadcast timer
> to support cpuidle, enable it by default.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

This one is identical to what I just picked up from v4 series, right?

Shawn
