Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38C0CCDDA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 04:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfJFCRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 22:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfJFCRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 22:17:02 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3727222C5;
        Sun,  6 Oct 2019 02:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570328222;
        bh=08IWgsYtfYEQoxuJKerHwdwPvgltMNLMDmtbgmWVK1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPpRYsJjzqd4LI8VNtqPHCqhhWF0MhM+wSbYfyvzxudK2sz+pwQsuZGizutKVDKHy
         BBbis6GY9iz7IWs6e79EW3rfUP4pEy6Lh5jkw7Nnk9YJk6Y78+v4EgseYblCQA6QH0
         aEJmeXKgO77mBDEu9gTLIif5z0Ar0WZrTAQfuNsQ=
Date:   Sun, 6 Oct 2019 10:16:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com,
        chen.fang@nxp.com, shengjiu.wang@nxp.com, aisheng.dong@nxp.com,
        sfr@canb.auug.org.au, l.stach@pengutronix.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] clk: imx8mm: Move 1443X/1416X PLL clock structure
 to common place
Message-ID: <20191006021632.GM7150@dragon>
References: <1567776846-6373-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567776846-6373-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 09:34:05AM -0400, Anson Huang wrote:
> Many i.MX8M SoCs use same 1443X/1416X PLL, such as i.MX8MM,
> i.MX8MN and later i.MX8M SoCs, moving these PLL definitions
> to pll14xx driver can save a lot of duplicated code on each
> platform.
> 
> Meanwhile, no need to define PLL clock structure for every
> module which uses same type of PLL, e.g., audio/video/dram use
> 1443X PLL, arm/gpu/vpu/sys use 1416X PLL, define 2 PLL clock
> structure for each group is enough.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
