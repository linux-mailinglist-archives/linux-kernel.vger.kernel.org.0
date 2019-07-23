Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE3D7133E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 09:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbfGWHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 03:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730814AbfGWHsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:48:40 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A53121BF6;
        Tue, 23 Jul 2019 07:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563868119;
        bh=fYJy18b12uxUluNQs7guTNUxA+SS983H3pUEsD9H7sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boo8pI2VDHOEXyE2zPUQwA3I29Op4qSdrGhTSd8FcilguUgWzouQWkXvVZTWMGK30
         O6BFRjc734To0scyhd+3M1FbFr6VyNdCSAjUanRAtUF4KItTPllN+o46js1oYlqMUI
         2oOsZqLp+vb1Qd31QEKb41wd4zYfxAx7fvkaRAVg=
Date:   Tue, 23 Jul 2019 15:48:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/4] ARM: dts: imx6sx: move GIC to right location in DT
Message-ID: <20190723074809.GK15632@dragon>
References: <20190718091508.3248-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718091508.3248-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 05:15:05PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> GIC is inside of SoC from architecture perspective, it should
> be located inside of soc node in DT.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
