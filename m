Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C87F112A6D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 12:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfLDLpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 06:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfLDLpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:45:23 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507DB20659;
        Wed,  4 Dec 2019 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575459923;
        bh=27KM2SxAZ9hUxzDgOTHr4NSFhH5djy57lv/89UAP9sI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1xYykGuPZeHThxa2b1Dp9yaEYc7zbpMoaE6Z9F7kRdtX1p/dr2+ZBkWVNfXX3+wPl
         XljNY72L7k9bxFul+zL+J8k3uoFW+DVe8O8OZorP17c7gpFa3K7ZZ4XLjbu3eTIq8R
         /B2RnvNRyIBRqgURUxpkVOmx/Aw6poAJOESvieCI=
Date:   Wed, 4 Dec 2019 19:45:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        andrew.smirnov@gmail.com, manivannan.sadhasivam@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 0/2] dts: ARM: add Tolino Shine 3 eBook reader
Message-ID: <20191204114510.GI3365@dragon>
References: <20191108111834.18610-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108111834.18610-1-andreas@kemnade.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 12:18:32PM +0100, Andreas Kemnade wrote:
> This adds a device tree for the Tolino Shine 3 eBook reader.
> Name on mainboard is: 37NB-E60K00+4A4 and serials start with: E60K02
> These boards are also found in the Kobo Clara HD eBook reader
> but equipped with a i.MX6SLL processor.
> 
> It depends on the previously-accepted patch
> ARM: dts: add Netronix E60K02 board common file
> 
> Andreas Kemnade (2):
>   dt-bindings: arm: fsl: add compatible string for Tolino Shine 3
>   ARM: dts: add devicetree entry for Tolino Shine 3

Applied both, thanks.
