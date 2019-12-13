Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D09211E191
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 11:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfLMKEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 05:04:48 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60956 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfLMKEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:04:48 -0500
Received: from wf0651.dip.tu-dresden.de ([141.76.182.139] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ifhoC-0000yW-Aw; Fri, 13 Dec 2019 11:04:28 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jack Chen <redchenjs@foxmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jack Chen <redchenjs@live.com>
Subject: Re: [PATCH] ARM: dts: rockchip: Add missing cpu operating points for rk3288-tinker
Date:   Fri, 13 Dec 2019 11:04:27 +0100
Message-ID: <47785260.740ClddZN9@phil>
In-Reply-To: <20191202153540.26143-1-redchenjs@foxmail.com>
References: <20191202153540.26143-1-redchenjs@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 2. Dezember 2019, 16:35:40 CET schrieb Jack Chen:
> From: Jack Chen <redchenjs@live.com>
> 
> The Tinker Board / S devices use a special chip variant called rk3288-c
> and use different operating points with a higher max frequency.
> 
> So add the missing operating points for Tinker Board / S devices, also
> increase the vdd_cpu regulator-max-microvolt to 1400000 uV so that the
> cpu can operate at 1.8 GHz.
> 
> Signed-off-by: Jack Chen <redchenjs@live.com>

applied for 5.6

Thanks
Heiko


