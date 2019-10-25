Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3642E46AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408719AbfJYJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 05:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408685AbfJYJIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:08:04 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB0521929;
        Fri, 25 Oct 2019 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571994484;
        bh=R/P729SiifhEPHPwNjYueBD2Eat4ZHTqfGZhGk1kjnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLM3g00uIIFEtP6j/jdHeLB/IBQdUskDL0Bb6XndB15dSDJSU+GUuYWJloLXdQSK6
         lepwHgh/RsOMIcwf4IJGNQmVbNv4RWv3wSRqvgoR8ixl1UEfKHWJCZB4e0qn4uFPjW
         w55aEjyzPUGur99ww/0cFxodiq+W3fpyooXZapRo=
Date:   Fri, 25 Oct 2019 17:07:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH V2 0/3] clk: imx: imx8m: mark sys pll1/2 as fixed clock
Message-ID: <20191025090746.GJ3208@dragon>
References: <1571882110-10191-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571882110-10191-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 01:58:32AM +0000, Peng Fan wrote:
> Peng Fan (3):
>   clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
>   clk: imx: imx8mn: mark sys_pll1/2 as fixed clock
>   clk: imx: imx8mq: mark sys1/2_pll as fixed clock

Applied all, thanks.
