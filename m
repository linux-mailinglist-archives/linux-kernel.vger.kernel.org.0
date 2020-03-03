Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25577177B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 17:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgCCQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 11:07:00 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52567 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgCCQG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:06:59 -0500
X-Originating-IP: 86.202.111.97
Received: from localhost (lfbn-lyo-1-16-97.w86-202.abo.wanadoo.fr [86.202.111.97])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E4AF020015;
        Tue,  3 Mar 2020 16:06:57 +0000 (UTC)
Date:   Tue, 3 Mar 2020 17:06:57 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] rtc: snvs: Improve Kconfig dependency
Message-ID: <20200303160657.GC58186@piout.net>
References: <1583136785-4973-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583136785-4973-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2020 16:13:05+0800, Anson Huang wrote:
> i.MX SNVS RTC should depend on ARCH_MXC or COMPILE_TEST.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/rtc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
