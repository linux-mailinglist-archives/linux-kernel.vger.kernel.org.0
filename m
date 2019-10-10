Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0D4D3370
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 23:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfJJVbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 17:31:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33860 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJJVbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:31:07 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iIg1S-0007Bv-HL; Thu, 10 Oct 2019 23:30:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, ezequiel@collabora.com,
        vicencb@gmail.com, akash@openedev.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix usb-c on Hugsun X99 TV Box
Date:   Thu, 10 Oct 2019 23:30:57 +0200
Message-ID: <1594003.l3tWjkc0Ga@phil>
In-Reply-To: <20190929032230.24628-1-npcomplete13@gmail.com>
References: <20190929032230.24628-1-npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 29. September 2019, 05:22:30 CEST schrieb Vivek Unune:
> Fix usb-c on X99 TV Box. Tested with armbian w/ kernel 5.3
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>

applied as fix for 5.4

Thanks
Heiko


