Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 186B549971
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 08:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfFRGxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 02:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfFRGxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:53:15 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B22A420673;
        Tue, 18 Jun 2019 06:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560840794;
        bh=8L1sOBtKkOdBG9JnByNFuljhi61mfWOhgOyCwTLXC0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUFegAn05uCokc7L6tkxyWBBinzbsqUPsz+U4qQrCZLo+FCdeopsaML8pxAmFz+KV
         /avcenHn3FIubbM3hzBbdTHRMLxo5LJ84OSYHhYcKaDEfeoEjj07OzVGQOtwk2oAYG
         Pzr314E/1fMi0mwnj2Yc2r5bU7Tj8i2vmXAiPCJA=
Date:   Tue, 18 Jun 2019 14:52:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        l.stach@pengutronix.de, ccaione@baylibre.com,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx8mq: Use devm_platform_ioremap_resource()
 instead of of_iomap()
Message-ID: <20190618065221.GB29881@dragon>
References: <20190610053922.30355-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610053922.30355-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 01:39:22PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> i.MX8MQ clock driver uses platform driver model, better to use
> devm_platform_ioremap_resource() instead of of_iomap() to get
> IO base.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
