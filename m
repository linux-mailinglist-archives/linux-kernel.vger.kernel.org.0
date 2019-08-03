Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15B806FA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfHCPQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 11:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfHCPQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 11:16:00 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B912073D;
        Sat,  3 Aug 2019 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564845360;
        bh=BEpL6l+3xiuW/IzVuyU+RrKo0dYWHViZQBu/4eOViPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxpvC7IsJY1oxOl9aW34GdwmdCi/9TD3h8DJ+zYpVvddjomGXnatruz9azzvlFet8
         OQOz3LwIkMbWnolkOASN5g+J3vyZz7dSmGJckO5tDHzDchKMey+lIPmo9KKQOrH87d
         1+c8AwLARAAQb56ABJsx3yxjlOxDRAXGPoVorVOU=
Date:   Sat, 3 Aug 2019 17:15:52 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: defconfig: CONFIG_DRM_ETNAVIV=m
Message-ID: <20190803151551.GR8870@X250.getinternet.no>
References: <20190802122102.3932-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802122102.3932-1-christian.gmeiner@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 02:20:28PM +0200, Christian Gmeiner wrote:
> For imx8 we want to enable etnaviv, let's enable it
> in defconfig, it will be useful to have it enabled for KernelCI
> boot and runtime testing.
> 
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>

Applied, thanks.
