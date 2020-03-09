Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3616517E36B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 16:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgCIPUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 11:20:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:56870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgCIPUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:20:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0FE2AAD2B;
        Mon,  9 Mar 2020 15:20:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20200304132437.20164-1-nsaenzjulienne@suse.de>
Date:   Mon, 09 Mar 2020 16:20:33 +0100
Cc:     <devicetree@vger.kernel.org>, <f.fainelli@gmail.com>,
        <phil@raspberrypi.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ARM: dts: bcm2711: Move emmc2 into its own bus
From:   "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
To:     "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        "Rob Herring" <robh+dt@kernel.org>
Message-Id: <C16EMMYP9HNH.163772OHL9QL4@linux-9qgx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Mar 4, 2020 at 3:24 PM PST, Nicolas Saenz Julienne wrote:
> Depending on bcm2711's revision its emmc2 controller might have
> different DMA constraints. Raspberry Pi 4's firmware will take care of
> updating those, but only if a certain alias is found in the device tree.
> So, move emmc2 into its own bus, so as not to pollute other devices with
> dma-ranges changes and create the emmc2bus alias.
>
> Based in Phil ELwell's downstream implementation.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied to for-next

Regards,
Nicolas
