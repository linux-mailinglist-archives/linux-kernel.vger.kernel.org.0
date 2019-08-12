Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5037589E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfHLMdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 08:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfHLMdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:33:00 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5359214C6;
        Mon, 12 Aug 2019 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565613179;
        bh=aLWVPZtEhIC0ZToFy8HKYrFEJRZhfGRRAZIOZ4qH66w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CyNEbnKcMBrF2RJKc3B5a3Jk2xvrM16+jGHdh6O/axkKJbUjtLWcFxPzuL+1P+EXy
         RUqVEMkW/BX+X6DdWbt9T9XIlYy4sR4Sg4ZU7swKek01UB5EMxVvitRgJAOXyn6spw
         VyojDy8iaxt8KMXx8ctdioAEApEYP9VGAwJD6Gao=
Date:   Mon, 12 Aug 2019 14:32:46 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        andrew.smirnov@gmail.com, manivannan.sadhasivam@linaro.org,
        j.neuschaefer@gmx.net, u.kleine-koenig@pengutronix.de,
        leoyang.li@nxp.com, aisheng.dong@nxp.com, l.stach@pengutronix.de,
        vabhav.sharma@nxp.com, bhaskar.upadhaya@nxp.com, ping.bai@nxp.com,
        pramod.kumar_1@nxp.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V4 1/4] dt-bindings: arm: imx: Add the soc binding for
 i.MX8MN
Message-ID: <20190812123245.GB27041@X250>
References: <20190619022145.42398-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619022145.42398-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:21:42AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> This patch adds the soc & board binding for i.MX8MN.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied 1 ~ 3, thanks.
