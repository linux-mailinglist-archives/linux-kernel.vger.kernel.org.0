Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93FAB4FF34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 04:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfFXCSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 22:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfFXCSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:18:14 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87AB120674;
        Mon, 24 Jun 2019 02:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561342693;
        bh=257F5fxJKWLetwl7yOwDez+PdfcDjnS/2ElB4GNJgGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJAjRz9lILz/xQ1VLh10zL0/rpq5WmV7WyaW6EtDdSODNn9+GsG9GMRE5PVkDsUEO
         jFnKpHOuquZWgg+hjU9ZKjUlBWlvwC87BAeFWfiA8O6DwbcXunIecKSXdJtnMaWGuX
         M+57Ztvo19r3SI7NUYL9ZqS+58XK1sZTMtVsiDKs=
Date:   Mon, 24 Jun 2019 10:18:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     catalin.marinas@arm.com, will@kernel.org,
        maxime.ripard@bootlin.com, olof@lixom.net,
        jagan@amarulasolutions.com, bjorn.andersson@linaro.org,
        leonard.crestez@nxp.com, dinguyen@kernel.org,
        enric.balletbo@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: defconfig: Enable CONFIG_KEYBOARD_SNVS_PWRKEY as
 module
Message-ID: <20190624021759.GM3800@dragon>
References: <20190621050603.20392-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621050603.20392-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 01:06:03PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Enable CONFIG_KEYBOARD_SNVS_PWRKEY as module to support i.MX8M
> series SoCs' power key.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
