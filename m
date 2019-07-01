Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 606E84A1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 15:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfFRNVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 09:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfFRNVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:21:13 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358972070B;
        Tue, 18 Jun 2019 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560864073;
        bh=z2OTz29gGjO1r9/j3/FdDQwDaOmqMmdwfbDUt50zhF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=02QlH3n/pNSgksJ/eL2RLYkp3gckL3seRwli0+1D0FBoylXP6OS3XW9iqML/oAOWy
         cOkzc+4VcyVqM3AkEGdV13hgi/LJUi4el8NK2uSXg2u6hs5tvY2Wy32lNRRwZ0IsSC
         L5dAIE5rd4m/Ym2eBWaSJRKv7jADcZ7JGcy4muOw=
Date:   Tue, 18 Jun 2019 21:20:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH v16 0/3] Add support for the Purism Librem5 devkit
Message-ID: <20190618132009.GF1959@dragon>
References: <20190617135215.550-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617135215.550-1-angus@akkea.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 07:52:12AM -0600, Angus Ainslie (Purism) wrote:
> Angus Ainslie (Purism) (3):
>   arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
>   dt-bindings: Add an entry for Purism SPC
>   dt-bindings: arm: fsl: Add the imx8mq boards

Applied all, thanks.
