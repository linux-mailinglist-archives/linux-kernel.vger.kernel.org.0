Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C82276EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 09:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfEWH3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 03:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfEWH3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:29:54 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C7C9217D7;
        Thu, 23 May 2019 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558596593;
        bh=c19NWt/LnVDFdWa5G3PG11NsA8ijCR/rV/h5vpWD/KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUnxHXFaDCaj/+Bu7q+MBexqxbykrKFJGpTwTuxoc22wIq9w7U6xRHM2hyAjbMBmK
         LIR+oih5+cDxXqyJpdNT4jUIcDHfarSSpGfsysvmet33eNIPlLKQc1FTTSfgblf3fn
         kXKCTYqYQrDq/R2K6dnEqAbw5moK87v1dWDx444s=
Date:   Thu, 23 May 2019 15:28:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/3] clk: imx8mm: add SNVS clock to clock tree
Message-ID: <20190523072851.GE9261@dragon>
References: <1557883490-22360-1-git-send-email-Anson.Huang@nxp.com>
 <1557883490-22360-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557883490-22360-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 01:29:57AM +0000, Anson Huang wrote:
> i.MX8MM has clock gate for SNVS module, add it into clock tree
> for SNVS RTC driver to manage.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
