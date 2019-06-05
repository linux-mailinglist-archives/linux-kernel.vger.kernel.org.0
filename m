Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B022B35989
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfFEJRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 05:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEJRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:17:18 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 778E32075B;
        Wed,  5 Jun 2019 09:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559726237;
        bh=cYxElpW0Vlv3r+RPbOHmetHZB85NQhgPvZ9XJjQHp8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+Tom2tpYqySAyxKs/a5k8md0Kdcvyol+5i29ZMARg92tJkM3PfeCqA+tsVG0skgo
         co5GY8aqSapFhci0wSKc4JAY/mHnqiHy2bgmxvyK1DNQDMtbe72W3QLD8x/r21/OI7
         RZSVzUzgWfJMcNEkxHfoQB+TjMZNSZyB9zAHu05c=
Date:   Wed, 5 Jun 2019 17:17:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7d-sdb: Make SW2's voltage fixed
Message-ID: <20190605091659.GM29853@dragon>
References: <20190529065056.27516-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529065056.27516-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:50:56PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> On i.MX7D SDB board, SW2 supplies a lot of peripheral devices,
> its voltage should be fixed at 1.8V. The commit 43967d9b5a7c
> ("ARM: dts: imx7d-sdb: Assign corresponding power supply for LDOs")
> assigns SW2 as the supplier of vdd1p0d, and when its comsumers
> pcie-phy/mipi-phy try to set the vdd1p0d to 1.0V, regulator core
> will also set SW2 to its best(min) voltage to 1.5V, and it will
> lead to board reset.
> 
> This patch makes SW2's voltage fixed at 1.8V to avoid this issue.
> 
> Fixes: 43967d9b5a7c ("ARM: dts: imx7d-sdb: Assign corresponding power supply for LDOs")
> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
