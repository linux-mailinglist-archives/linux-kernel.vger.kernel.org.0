Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71977139242
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 14:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgAMNgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 08:36:50 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54840 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMNgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:36:50 -0500
Received: from wf0253.dip.tu-dresden.de ([141.76.180.253] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iqztb-00037T-18; Mon, 13 Jan 2020 14:36:43 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] drm/rockchip: fix integer type used for storing dp data rate
Date:   Mon, 13 Jan 2020 14:36:42 +0100
Message-ID: <4097172.Yl1PJM63nH@phil>
In-Reply-To: <20200109073129.378507-2-t.schramm@manjaro.org>
References: <20200109073129.378507-1-t.schramm@manjaro.org> <20200109073129.378507-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 9. Januar 2020, 08:31:29 CET schrieb Tobias Schramm:
> commmit 2589c4025f13 ("drm/rockchip: Avoid drm_dp_link helpers") changes
> the type of variables used to store the display port data rate and
> number of lanes to u8. However u8 is not sufficient to store the link
> data rate of the display port.
> This commit reverts the type of data rate to unsigned int.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

applied to drm-misc-fixes

Thanks
Heiko


