Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0D54FAA1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfFWHgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 03:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfFWHgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 03:36:18 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C7E92073F;
        Sun, 23 Jun 2019 07:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561275377;
        bh=GoqMkEGAkw9RsRi9oynfQuaA0MqWs5oMzUhbx6/BIjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5cwObSJLtfGBmPwzlpJCw9ntlEZ/Hv7gCDQ5Zjnf8e0FlS3aGFVVwL1lY0V5NFVK
         69x89nQrjd3MQ4CM3CrnMxSmU6LJSyuooXR0Np6mZhoPpahmsX4TO4pRx2XDckXB9A
         NCM4R0rgY0oNLtu2yDTrgSg3PL3TNKjBwmKCwXM8=
Date:   Sun, 23 Jun 2019 15:36:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     daniel.baluta@nxp.com
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.felsch@pengutronix.de
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
Message-ID: <20190623073605.GA3800@dragon>
References: <20190604123257.2920-1-daniel.baluta@nxp.com>
 <20190604123257.2920-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604123257.2920-3-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 08:32:57PM +0800, daniel.baluta@nxp.com wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> i.MX8MM has one wm8524 audio codec connected with
> SAI3 digital audio interface.
> 
> This patch uses simple-card machine driver in order
> to enable wm8524 codec.
> 
> We need to set:
> 	* SAI3 pinctrl configuration
> 	* codec reset gpio pinctrl configuration
> 	* clock hierarchy
> 	* codec node
> 	* simple-card configuration
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
