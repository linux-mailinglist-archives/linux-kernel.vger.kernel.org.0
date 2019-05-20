Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497E322A39
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 05:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfETDFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 23:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfETDFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:05:00 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68BFC20645;
        Mon, 20 May 2019 03:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558321500;
        bh=sZpSsCuj9TYfdRouk20kA2yqk+mSZuz4MahQwFHC/SA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KS3Wtmas5bnXKXjzvCRHxw67pjjMY6zmRD8sB/hxuWfM2ug/h6zTeymiVZV5Dy+Id
         kjw6ZiDGhgVykEoj8OmLfw7lmxFyzpiUFEOmlI2Rkw5WVyovAA4i9a5OLtpBVeclEw
         AcS94U7UmADYJTgNk1zA4zyU0AJHxQZPSrZvGZ+o=
Date:   Mon, 20 May 2019 11:04:09 +0800
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
Subject: Re: [PATCH RESEND 1/5] ARM: dts: imx6qdl-sabresd: Assign
 corresponding power supply for LDOs
Message-ID: <20190520030408.GN15856@dragon>
References: <1557654739-12564-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557654739-12564-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 09:57:20AM +0000, Anson Huang wrote:
> On i.MX6Q/DL SabreSD board, vgen5 supplies vdd1p1/vdd2p5 LDO and
> sw2 supplies vdd3p0 LDO, this patch assigns corresponding power
> supply for vdd1p1/vdd2p5/vdd3p0 to avoid confusion by below log:
> 
> vdd1p1: supplied by regulator-dummy
> vdd3p0: supplied by regulator-dummy
> vdd2p5: supplied by regulator-dummy
> 
> With this patch, the power supply is more accurate:
> 
> vdd1p1: supplied by VGEN5
> vdd3p0: supplied by SW2
> vdd2p5: supplied by VGEN5
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
