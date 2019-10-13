Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F572D5878
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 00:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfJMWDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 18:03:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50674 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbfJMWDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 18:03:38 -0400
Received: from i59f7e0c5.versanet.de ([89.247.224.197] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iJlxg-0004wp-SA; Mon, 14 Oct 2019 00:03:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nickey Yang <nickey.yang@rock-chips.com>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, seanpaul@chromium.org,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 1/1] drm/rockchip: vop: add the definition of dclk_pol
Date:   Mon, 14 Oct 2019 00:03:31 +0200
Message-ID: <1778208.Lq4l6xoKsQ@phil>
In-Reply-To: <20191010034452.20260-2-nickey.yang@rock-chips.com>
References: <20191010034452.20260-1-nickey.yang@rock-chips.com> <20191010034452.20260-2-nickey.yang@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 10. Oktober 2019, 05:44:52 CEST schrieb Nickey Yang:
> Some VOP's (such as px30) dclk_pol bit is at the last.
> So it is necessary to distinguish dclk_pol and pin_pol.
> 
> Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>

applied to drm-misc-next with Sandy's Reviewed-by

Thanks
Heiko


