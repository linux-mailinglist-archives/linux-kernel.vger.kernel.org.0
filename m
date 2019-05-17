Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD32C211A3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 03:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfEQBLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 21:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfEQBLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 21:11:44 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C5B3206BF;
        Fri, 17 May 2019 01:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558055503;
        bh=v8ur96ilx7klTthe7jJO6SMElFMgiokDxbEycSV8fMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isBtt1fbeiPbegVIF+v/krAjs6pL1N+Rh4af+stinmvpbnApl+GxnuCELbDJBau6z
         DW1p7vvl+3q0Fnuyobn598bko7rY3kZbYmJYR1qzvy2NW/SguZ++F9ggcqu6dVIFVf
         MFUblPPGtoD/4CNTWZcWzav4GaHOIdJfV/2s0Wqw=
Date:   Fri, 17 May 2019 09:11:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND 1/2] ARM: dts: imx6sl: Assign corresponding clocks
 instead of dummy clock
Message-ID: <20190517011101.GU15856@dragon>
References: <1557655028-12654-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557655028-12654-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 10:02:10AM +0000, Anson Huang wrote:
> i.MX6SL's KPP and WDOG use IMX6SL_CLK_IPG as clock root,
> assign IMX6SL_CLK_IPG to them instead of IMX6SL_CLK_DUMMY.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied both ,thanks.
