Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA9E4656
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 10:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392237AbfJYIzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 04:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437607AbfJYIze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:55:34 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D2521D7B;
        Fri, 25 Oct 2019 08:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571993734;
        bh=5i3d+HY/V9+fI+uU7h1tX+fWD57IhBHMQfmMyo6jW0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIQ/dERdy5OkfSnkwC/QgV1xafO+vBptMDHo96N++fPAbjhSmlkAGTYvw3jNb1VFi
         S7bP4XDAcKBi1T5YIgLuBu8vztAbKdPBY4ZeZ2/wEoYtZJxRlqFZ3bdlB1F17+zKeE
         pfirmEbL1hEYAsGqA5dT8DKdV+kpfLy+KRJlkJdo=
Date:   Fri, 25 Oct 2019 16:55:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] dts: Disable DMA support on the BK4 vf610 device's
 fsl_lpuart driver
Message-ID: <20191025085515.GH3208@dragon>
References: <20191010090802.16383-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010090802.16383-1-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 11:08:02AM +0200, Lukasz Majewski wrote:
> This change disables the DMA support (RX/TX) on the NXP's fsl_lpuart
> driver - the PIO mode is used instead. This change is necessary for better
> robustness of BK4's device use cases with many potentially interrupted
> short serial transfers.
> 
> Without it the driver hangs when some distortion happens on UART lines.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>

Subject prefix should be 'ARM: dts: ...'.  I fixed it up and applied the
patch.

Shawn
