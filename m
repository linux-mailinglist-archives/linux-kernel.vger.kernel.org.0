Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F19163A05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 03:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgBSCT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 21:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgBSCT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:19:58 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE290207FD;
        Wed, 19 Feb 2020 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582078797;
        bh=6KO77SOFrH1Ddyvoza5ZvqYLAvpu4o8si99XFZUtu2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wkg5dbfOP2V8936xVv3qGO4JVvE8Ra8ZgwlcxCzfJIlVgIFWdmQCnh7xcj9B1DvAx
         TRGQ950vP95jp7ww384KVIM4CpY5fc2SGzYA/NBnCH0DwGatvDspIoTeKcvj4tfiL2
         JBleHomkbTQbPmmwkTrW770ZCmuRiv45Sud0HYXE=
Date:   Wed, 19 Feb 2020 10:19:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/3] clk: imx8mp: Include slab.h instead of clkdev.h
Message-ID: <20200219021950.GK6075@dragon>
References: <1582023806-6261-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582023806-6261-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 07:03:24PM +0800, Anson Huang wrote:
> slab.h is necessary and included indirectly by clkdev.h,
> actually, there is nothing in use from clkdev.h, so just
> include slab.h instead of clkdev.h.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
