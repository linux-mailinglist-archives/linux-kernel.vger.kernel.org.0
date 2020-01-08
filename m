Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B366D133E42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 10:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgAHJZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 04:25:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38393 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAHJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:25:06 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ip7aK-0008O9-E7; Wed, 08 Jan 2020 10:25:04 +0100
Message-ID: <d32d1c1e6f32eeed811fa00e1b5d8ca121eea70f.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/3] ata: ahci_brcm: Follow-up changes for BCM7216
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Date:   Wed, 08 Jan 2020 10:25:03 +0100
In-Reply-To: <20200107183022.26224-1-f.fainelli@gmail.com>
References: <20200107183022.26224-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, 2020-01-07 at 10:30 -0800, Florian Fainelli wrote:
> Hi Jens, Philipp,
> 
> These three patches are a follow-up to my previous series titled: ata:
> ahci_brcm: Fixes and new device support.
> 
> After submitting the BCM7216 RESCAL reset driver, Philipp the reset
> controller maintained indicated that the reset line should be self
> de-asserting and so reset_control_reset() should be used instead.
> 
> These three patches update the driver in that regard. It would be great if
> you could apply those and get them queued up for 5.6 since they are
> directly related to the previous series.
> 
> Changes in v3:
> - introduced a preliminary patch making use of the proper reset control
>   API in order to manage the optional reset controller line
> - updated patches after introducing that preliminary patch

The third patch could be simplified by storing the rescal reset control
in a separate struct member and relying on the optional reset control
API more. This is just a suggestion though, the series looks fine as-is.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

