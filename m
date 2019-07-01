Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6BBE4FF33
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 04:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfFXCRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 22:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfFXCRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:17:23 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C52D922CDA;
        Mon, 24 Jun 2019 00:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561337859;
        bh=miD3wAHyi4O1ctbdmZlddUy7kefFm9ICPlAWm0WphYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x1ZliunoMMDtr76MUYyZbSnxuFYCPAbXH0yiUCbYH7o+g7nSzeXUYAtyKkxg7YmtJ
         D7DnumVulaD1UZTWiFeT5qIEI2joPWT5fX03nHedfCUjkmewLmwu3bUb/ZbCyTACcj
         PYrrhl1gPnDluoYf5Sa/qLiuQBHt3H7YbpmeBTWw=
Date:   Mon, 24 Jun 2019 08:57:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, anson.huang@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8qxp: Add lsio_mu13 node
Message-ID: <20190624005724.GG3800@dragon>
References: <20190618210516.28866-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618210516.28866-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 12:05:16AM +0300, Daniel Baluta wrote:
> lsio_mu13 node is used to communicate with DSP.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
