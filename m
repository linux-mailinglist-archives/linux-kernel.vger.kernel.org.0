Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5949A22A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 04:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfETC73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 22:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfETC73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 22:59:29 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43FA820644;
        Mon, 20 May 2019 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558321169;
        bh=Uey0q6RqVOdYgZIddYyOhGn8Dx2hzDyySF75LlIwS8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DNLKaYb2lYUce3nORl1Tj80X/6tI4+adTrdz9ZDUrzjdL73x5KhXYZAGLrTmyZa7n
         waZk81GBpQ9wmWWBucFc+L6Tm00rTGbUSOopg+ao4Q52zvN9uqxi1sN1vDROT0Ppvf
         V09DTok0WQhGMLs6X9RWEHIzIniTNvQfP03GxyDA=
Date:   Mon, 20 May 2019 10:58:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V12 RESEND 1/3] ARM: imx_v6_v7_defconfig: Add TPM PWM
 support by default
Message-ID: <20190520025834.GL15856@dragon>
References: <1557650772-11973-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557650772-11973-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 08:51:15AM +0000, Anson Huang wrote:
> Select CONFIG_PWM_IMX_TPM by default to support i.MX7ULP
> TPM PWM.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
