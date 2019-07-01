Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57ED21A9F8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 03:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfELBac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 21:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfELBac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:30:32 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4527A2146F;
        Sun, 12 May 2019 01:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557624631;
        bh=sa7egvkcBjJP+/4O4tBOAUF0eYA7a90YlTdMgsQcJes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i55OgSq1V5HkURHE2MoeBK+V2oS9cbSJyIO+AlYhTFS4hA2W/2k7uJwwVLNi+ucIK
         O7JMKaewb8NzZPlv6QM0/sC69O+SHZ74/s7a4AtWFLTT1uZCF95ZLqqlRcDyJpnqaq
         KKHS8JFK4QHXE1PDVRW28BfKJhnCLL2DiIEg768U=
Date:   Sun, 12 May 2019 09:30:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] Enable wm8524 codec on i.MX8MM EVK
Message-ID: <20190512012959.GM15856@dragon>
References: <20190424150350.7963-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424150350.7963-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:04:12PM +0000, Daniel Baluta wrote:
> This patch series introduces the SAI nodes on i.MX8MM EVK then
> creates the wm8524 codec node and finally uses simple card machine
> driver to create a sound card.
> 
> Changes since v2:
> 	- place compatible strings one a single lines
> 	- move GPIO pinctrl in a node of its own
> 	- remove codec phandle
> 
> Changes since v1:
>         - use "fsl,imx8mm-sai", "fsl,imx8mq-sai" compatbile strings and
>           remove "fsl,imx6sx-sai" because SAI module on i.MX8M is not
>           compatbile with SAI modules form i.MX6
> 
> Daniel Baluta (2):
>   arm64: dts: imx8mm: Add SAI nodes
>   arm64: dts: imx8mm-evk: Enable audio codec wm8524

Hi Marco,

Are you fine with this version?

Shawn
