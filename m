Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D429169F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 08:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgBXHt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 02:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgBXHt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:49:59 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 777B020675;
        Mon, 24 Feb 2020 07:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582530599;
        bh=uN/mf/cIKhX+Ioyz/MHScF/+mLz2fKQr2PZkKgF9n+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ip3DBLS7gV1Oa6Wrpcxg2sWfSCPThUYY6QXhso9dMzTugE6rwFvimMUU9w1wEF21h
         fuGdZS0cGc95R16nBOJXFNvE8JCg0EAsc/v3L22HYgp88n8r3jImZjz7tXA6pO/Jnm
         j8X6J0BNj0cHZFPAEXOhU1w+J2LrZKpekKW63KTs=
Date:   Mon, 24 Feb 2020 15:49:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        john@phrozen.org, heiko@sntech.de, jonas.gorski@gmail.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx: clk-sscg-pll: Drop unnecessary initialization
Message-ID: <20200224074950.GA27688@dragon>
References: <1582268376-1672-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582268376-1672-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 02:59:36PM +0800, Anson Huang wrote:
> No need to initialize 'ret' in many functions, as it will get
> the return value from function call, so remove the initializtion
> of 'ret'.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
