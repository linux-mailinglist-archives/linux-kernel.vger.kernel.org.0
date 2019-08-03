Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4258056D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 10:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbfHCI5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 04:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387730AbfHCI5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 04:57:19 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B4F21726;
        Sat,  3 Aug 2019 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564822638;
        bh=l3mc7sIAGnYKZ5dbrLxRC+O8nRnUq21i3R4wry0I2AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x45xeD4Z7e/Wn6MpDqvNmYZHAeBDgQ39s0X53S8yYKsAQYkxG1XpFoqakkI6sixQy
         v3CBCkLWo3P7beQeaaAPwKVR9cpeXwXq2EpF5eOCQp7f/2CeHgCn86NKcOhEY/zFGK
         KF6Fq1RH1iLeB6BqHjSqDrIPrnHWoy83HK4xgRCk=
Date:   Sat, 3 Aug 2019 10:57:11 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        gustavo@embeddedor.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx7ulp: Make sure earlycon's clock is enabled
Message-ID: <20190803085708.GG8870@X250.getinternet.no>
References: <20190724030600.17839-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724030600.17839-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:06:00AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Earlycon's clock could be disabled during kernel boot up,
> if earlycon is enabled and its clock is gated, then kernel
> boot up will fail. Make sure earlycon's clock is enabled
> during kernel boot up.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
