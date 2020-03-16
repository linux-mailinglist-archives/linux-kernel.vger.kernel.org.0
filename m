Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8AB1864E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 07:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgCPGB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 02:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgCPGB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 02:01:28 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B79B320674;
        Mon, 16 Mar 2020 06:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584338488;
        bh=3E+8EY5GoqEbt0DmQz71Yz7/T4lemKjXRfDDEbV70W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VBHsJxlTgfi25qEPvpFz+mLkyN05bNt+46fz37+J39kCA7kVcXKF0uMpKKKWc2Ql9
         HvjoU9JMgHaw9u1/VhBiVkgabuPouW+cl8GVbRuGWMElla9ekWxtxOEKeTfS5d5ima
         GgNSZKxUUxQqkgSBxwOVan9Hw5etNz8eFAgwQuzE=
Date:   Mon, 16 Mar 2020 14:01:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx: drop COMPILE_TEST for IMX_SCU_SOC
Message-ID: <20200316060122.GH17221@dragon>
References: <1584328142-11810-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584328142-11810-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 11:09:02AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> With COMPILE_TEST, there will be build error, because IMX_SCU
> might be set to n, so drop COMPILE_TEST.
> 
> Suggested-by: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
