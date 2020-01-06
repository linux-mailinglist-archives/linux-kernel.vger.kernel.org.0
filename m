Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B39131165
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 12:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgAFL0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 06:26:41 -0500
Received: from gloria.sntech.de ([185.11.138.130]:50244 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgAFL0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:26:40 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ioQWp-0004cC-Ix; Mon, 06 Jan 2020 12:26:35 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: rockchip: rk3066_hdmi: set edid fifo address
Date:   Mon, 06 Jan 2020 12:26:35 +0100
Message-ID: <6562118.EOOupxtdqP@phil>
In-Reply-To: <20191211203417.19448-1-jbx6244@gmail.com>
References: <20191211203417.19448-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 11. Dezember 2019, 21:34:17 CET schrieb Johan Jonker:
> From: Nickey Yang <nickey.yang@rock-chips.com>
> 
> Fix edid reading error when edid's block > 2.
> 
> Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied to drm-misc-next for 5.6

Thanks
Heiko


