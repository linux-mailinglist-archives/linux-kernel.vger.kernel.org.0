Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920B5FFC25
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 00:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfKQXNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 18:13:14 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49118 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfKQXNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 18:13:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id A4C032A771;
        Sun, 17 Nov 2019 18:13:10 -0500 (EST)
Date:   Mon, 18 Nov 2019 10:13:08 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Kars de Jong <jongk@linux-m68k.org>
cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] esp_scsi: Clear Transfer Count registers before PIO
 transfers
In-Reply-To: <CACz-3rjHAyi6kMQ6j9YALLm1ApYrsqKiTnGNPUhxqqEuRJ9TjQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1.1911180947020.8@nippy.intranet>
References: <2bbb6359d542f5882be67c415ecc25ad2d9eeb5e.1573875417.git.fthain@telegraphics.com.au> <CACz-3rjHAyi6kMQ6j9YALLm1ApYrsqKiTnGNPUhxqqEuRJ9TjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2019, Kars de Jong wrote:

> Hi Finn,
> 
> Op za 16 nov. 2019 om 04:36 schreef Finn Thain 
> <fthain@telegraphics.com.au>:
> >
> > The zorro_esp driver uses both PIO and DMA transfers. If a failed DMA 
> > transfer happened to be followed by a PIO transfer, the TCLOW and 
> > TCMED registers would not get cleared. It is theoretically possible 
> > that the stale value from the transfer counter or the TCLOW/TCMED 
> > registers could then be used by the controller and the driver. Avoid 
> > that by clearing these registers before each PIO transfer.
> 
> Are you sure this is really needed?
> 

No. I think it improves robustness and correctness.

I would be interested to know whether there is any measurable performance 
impact on zorro_esp.

> The only [time when] the driver reads these registers is after a data 
> transfer. These are done using DMA on all Zorro boards, so I don't think 
> there's a risk of stale values from a PIO transfer there.
> 

I'm not entirely sure that the chip is unaffected by stale counter values. 

(Stale transfer counter values are distinct from stale transfer count 
register values. Both are addressed by the patch.)

If there are DMA controllers out there that can't do very short transfers 
then this objection would seem to be invalid, because the "DMA length is 
zero!" issue could be tackled using PIO.

> The only place the controller reads these registers is when a DMA 
> command is issued. The only place where that is done is in the zorro_esp 
> send_dma_command() functions. 

Aren't you overlooking all of the ESP_CMD_DMA flags in the core driver?

Thanks for your review.

-- 

> These all set both registers explicitly before issuing the DMA command 
> to the controller, so I don't think there's a risk there either.
> 
> Kind regards,
> 
> Kars.
> 
