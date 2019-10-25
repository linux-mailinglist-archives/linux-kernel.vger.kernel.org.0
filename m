Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2EE4331
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 08:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394050AbfJYGF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 02:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393713AbfJYGFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:05:09 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFE621929;
        Fri, 25 Oct 2019 06:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571983507;
        bh=fBJRRwheXU1MJ98d8dPNJRL9K8CPlTP6wigRKmHU5H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CItcbHo19ZH8Tsjrxq66F0Ak0UPU72fpIEjLBf71IiAhSTnjilyrxdbhpXaEkrbx/
         EEVqNgzKCjJN4DHwBsSbSDkB4IHkyI2ze7TTjScrr+5gfiRzj+XaasvDNI2Cpt+G2m
         Zjt5zct0NmzVQMqoR5FNSXyJlyFoVicy02V/9Ajo=
Date:   Fri, 25 Oct 2019 14:04:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        ccaione@baylibre.com, daniel.baluta@nxp.com,
        andrew.smirnov@gmail.com, abel.vesa@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: VDD_ARM power rail is always ON
Message-ID: <20191025060444.GC3208@dragon>
References: <1570604659-28314-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570604659-28314-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 03:04:19PM +0800, Anson Huang wrote:
> On i.MX8MQ EVK board, VDD_ARM is from a DC-DC converter which
> is always ON, the GPIO1_IO13 is ONLY to switch VDD_ARM's voltage
> between 0.9V and 1V for CPU DVFS, so VDD_ARM's GPIO regulator
> should be always ON to avoid below confusion after kernel boot
> up:
> 
> imx8mqevk login:
> [   31.776619] vdd_arm: disabling
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
