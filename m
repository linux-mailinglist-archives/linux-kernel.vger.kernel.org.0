Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F32EACE1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 10:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfJaJvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 05:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfJaJvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:51:38 -0400
Received: from localhost (lns-bzn-32-82-254-4-138.adsl.proxad.net [82.254.4.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF292086D;
        Thu, 31 Oct 2019 09:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572515498;
        bh=EBq3RU5D0YquRdZnknO4EAQ5B1wcu4KvtBhrbZq1/Lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPXFrhI+s4MOrEa4toxMkWxb6Qtf1u6r/MeGQeFqYFISb6DMbt7UG1ZQXowz+TaOU
         5jGhmMZp1jMa5/h6us1kUe/VyWdVh0cTUSL51O/wiTwbSAqlfQJrjWeOBz1l2GHY4/
         ygZUa8NAGPivshS+StO2xHlg1o3K2tau6FKA+yeA=
Date:   Thu, 31 Oct 2019 10:51:03 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm: sun4i: Add support for suspending the display
 driver
Message-ID: <20191031095103.jmuwbyr6eqa4kuru@hendrix>
References: <20191029112846.3604925-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029112846.3604925-1-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:28:46PM +0100, Ondrej Jirman wrote:
> Shut down the display engine during suspend.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks

Maxime
