Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 978C413924B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 14:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAMNiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 08:38:10 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54896 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgAMNiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:38:10 -0500
Received: from wf0253.dip.tu-dresden.de ([141.76.180.253] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iqzuw-00038L-BX; Mon, 13 Jan 2020 14:38:06 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: use DIV_ROUND_UP macro for calculations.
Date:   Mon, 13 Jan 2020 14:38:05 +0100
Message-ID: <789581379.5MvcqtHuSF@phil>
In-Reply-To: <20200109142057.10744-1-wambui.karugax@gmail.com>
References: <20200109142057.10744-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 9. Januar 2020, 15:20:57 CET schrieb Wambui Karuga:
> Replace the open coded calculation with the more concise and readable
> DIV_ROUND_UP macro.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

applied to drm-misc-next

Thanks
Heiko


