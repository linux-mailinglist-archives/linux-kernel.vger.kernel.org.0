Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C6CE6E77
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 09:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbfJ1IsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 04:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731718AbfJ1IsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:48:12 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1390120873;
        Mon, 28 Oct 2019 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572252491;
        bh=0wg1hNqKvSi14ytb5P0C42epPI9MzMnFQY2DntLecQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPJk9XEk0iwsnbU46teKcpRIAP4EnQrTYiw1TfybIBb8ZOsaI/EIvxNC71QpXuxV3
         SvR6m9ZfcVK/fRC2ZvvAg3fWQi2cyXsfEqToOU20HcnKu8jb13+lVUo9wyGHX+zhlj
         aymaX+RluggfNLJLA7Gj01TAouLpL2yh2yayljSk=
Date:   Mon, 28 Oct 2019 16:47:51 +0800
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
Subject: Re: [PATCH V2 0/3] clk: imx: imx6x: use imx_obtain_fixed_clk_hw
Message-ID: <20191028084749.GX16985@dragon>
References: <1571885777-21662-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571885777-21662-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:59:27AM +0000, Peng Fan wrote:
> Peng Fan (3):
>   clk: imx: imx6sll: use imx_obtain_fixed_clk_hw to simplify code
>   clk: imx: imx6sx: use imx_obtain_fixed_clk_hw to simplify code
>   clk: imx: imx6ul: use imx_obtain_fixed_clk_hw to simplify code

Applied all, thanks.
