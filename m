Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D56060FEF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 12:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfGFKvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 06:51:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49470 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGFKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:51:15 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id B31F9CF12E;
        Sat,  6 Jul 2019 12:59:45 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4] Bluetooth: hci_qca: wcn3990: Drop baudrate change
 vendor event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190521195307.23874-1-mka@chromium.org>
Date:   Sat, 6 Jul 2019 12:51:13 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <9052566C-2880-4771-AAA5-DCF0E23C9C0D@holtmann.org>
References: <20190521195307.23874-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> Firmware download to the WCN3990 often fails with a 'TLV response size
> mismatch' error:
> 
> [  133.064659] Bluetooth: hci0: setting up wcn3990
> [  133.489150] Bluetooth: hci0: QCA controller version 0x02140201
> [  133.495245] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> [  133.507214] Bluetooth: hci0: QCA TLV response size mismatch
> [  133.513265] Bluetooth: hci0: QCA Failed to download patch (-84)
> 
> This is caused by a vendor event that corresponds to an earlier command
> to change the baudrate. The event is not processed in the context of the
> baudrate change and is later interpreted as response to the firmware
> download command (which is also a vendor command), but the driver detects
> that the event doesn't have the expected amount of associated data.
> 
> More details:
> 
> For the WCN3990 the vendor command for a baudrate change isn't sent as
> synchronous HCI command, because the controller sends the corresponding
> vendor event with the new baudrate. The event is received and decoded
> after the baudrate change of the host port.
> 
> Identify the 'unused' event when it is received and don't add it to
> the queue of RX frames.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v4:
> - limit the fix to WCN3990 instead of applying it to all WCN399x.
>  Harish Bandi <c-hbandi@codeaurora.org> reported frame reassembly
>  errors with WCN3998 and v3. At this point it is unknown in how far
>  WCN3998 behaves different from WCN3990, we can revisit
>  it later if it turns that it has the same problem.
> 
> Changes in v3:
> - rebased on latest bluetooth-next/master
> - removed barrier calls again, bit routines include barriers
> 
> Changes in v2:
> - make QCA_DROP_VENDOR_EVENT an enum value and don't use BIT()
> - free skb in qca_recv_event()
> - add barriers to ensure qca_recv_event() sees updated flags
> - return -ETIMEDOUT instead of -EPROTO if the vendor event isn't
>  received in time
> ---
> drivers/bluetooth/hci_qca.c | 55 ++++++++++++++++++++++++++++++++++++-
> 1 file changed, 54 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

