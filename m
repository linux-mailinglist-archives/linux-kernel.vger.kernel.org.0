Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 745CB160A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 07:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgBQGdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 01:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgBQGdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:33:08 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9CF6206F4;
        Mon, 17 Feb 2020 06:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581921188;
        bh=CyxzI+GzmV4pKh83UJxSW/z+UjMTnARzMVXr0BkrxE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtgbWYlOQV8N7o/dRd0bFt3DgJwiwMcpY6CtGKNYQMdXr5govhhfFasUq7epSQjSj
         sCgKdD00DgEXbw+6bG5qjLDhBMlUNAUi8+ANp16KKCih0IhAdv7XwNK7yOj9wYCfSp
         zfQeREuq3rvlrejdtKbTMJpoHlU1rcr9ru60p/5k=
Date:   Mon, 17 Feb 2020 14:33:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        peng.fan@nxp.com, broonie@kernel.org, tglx@linutronix.de,
        allison@lohutok.net, gregkh@linuxfoundation.org,
        rfontana@redhat.com, info@metux.net, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx: drop redundant initialization
Message-ID: <20200217063300.GA6952@dragon>
References: <1581498180-2652-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581498180-2652-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:03:00PM +0800, Anson Huang wrote:
> No need to initialize flags as 0, remove the initialization.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
