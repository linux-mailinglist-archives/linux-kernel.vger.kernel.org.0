Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFC618B983
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 15:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgCSOhY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Mar 2020 10:37:24 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:39350 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbgCSOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:37:23 -0400
X-Greylist: delayed 872 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 10:37:22 EDT
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47]:43774 helo=diego.localnet)
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <heiko.stuebner@theobroma-systems.com>)
        id 1jEw4P-0004O5-2t; Thu, 19 Mar 2020 15:22:49 +0100
From:   Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] phy: rk-inno-usb2: Decrease verbosity of repeating log.
Date:   Thu, 19 Mar 2020 15:22:48 +0100
Message-ID: <2002640.57rdNQtM3Z@diego>
Organization: Theobroma Systems
In-Reply-To: <20200319140852.27636-1-christoph.muellner@theobroma-systems.com>
References: <20200319140852.27636-1-christoph.muellner@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 19. M�rz 2020, 15:08:52 CET schrieb Christoph Muellner:
> phy-rockchip-inno-usb2 logs the message
> 
>   "phy-ff2c0000.syscon:usb2-phy@100.2: charger = INVALID_CHARGER"
> 
> constantly with a frequency of about 1 Hz and a verbosity level
> of INFO. As this is clearly annoying, this patch decreases
> the log level to DEBUG.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>

I've noticed these messages in the past as well, but I guess in my short
test-cycles never got annoyed enough to do something about it, but it's
nice to see them go away, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


