Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E6F612DA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 21:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfGFTrp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 6 Jul 2019 15:47:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53489 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfGFTrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 15:47:45 -0400
Received: from [192.168.1.175] (apn-37-247-209-172.dynamic.gprs.plus.pl [37.247.209.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 288F5CF165;
        Sat,  6 Jul 2019 21:54:20 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v7 0/2] Bluetooth: btusb: Add protocol support for
 MediaTek USB devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1559433769-23749-1-git-send-email-sean.wang@mediatek.com>
Date:   Sat, 6 Jul 2019 21:45:31 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CB48D0A4-0564-42A6-847F-08E64AAF4842@holtmann.org>
References: <1559433769-23749-1-git-send-email-sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> v7:
> * rebase to latest code base.
> 
> v6:
> * fix drivers/bluetooth/btusb.c:2683:2-3: Unneeded semicolon based reported by [1]
> * update power-on sequence with adding neccesary tci sleep comand to set up
>  low-power environmnet and a delay to wait the device to be stable.
> * sort variables declarations in reverse xmas order.
> 
> [1]
> http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017017.html
> 
> v5:
> * rebase to latest code base.
> * change the subject prefix.
> * change the place the firmware located at.
> 
> v4:
> * use new BTUSB_TX_WAIT_VND_EVT instead of BTMTKUSB_TX_WAIT_VND_EVT
>  to avoid definition conflict and to fix bulk data transfer fails.
> * use the bluetooth-next as the base
> 
> v3:
> add fixes and enhancements based on [1]
> * reuse flags and evt_skb btusb already had
> * add ctrl_anchor and the corresponding handling
> * apply mtk specific recv function
> * add more comments explaining wmt ctrl urbs behavior.
> 
> [1]
> http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014724.html
> 
> v2:
> 
> add fixes and enhancements based on [1]
> * include /sys/kernel/debug/usb/devices portion in the commit message.
> * turn default into n for config BT_HCIBTUSB_MTK in Kconfig
> * only add MediaTek support to btusb.c
> * drop cmd_sync callback usage
> * use __hci_cmd_send to send WMT commands
> * add wait event handling similar to what is being done in btmtkuart.c
> * submit a control IN URB similar to interrupt IN URB on demand for the WMT
>  commands during setup 
> * add cosmetic changes
> 
> [1]
> http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014650.html
> http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014656.html
> 
> v1:
> 
> This adds the support of enabling MT7668U and MT7663U Bluetooth
> function running on the top of btusb driver. The patch also adds
> a newly created file mtkbt.c able to be reused independently from
> the transport type such as UART, USB and SDIO.
> 
> Sean Wang (2):
>  Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB
>    devices
>  Bluetooth: btusb: Add protocol support for MediaTek MT7663U USB
>    devices
> 
> drivers/bluetooth/Kconfig |  11 +
> drivers/bluetooth/btusb.c | 581 ++++++++++++++++++++++++++++++++++++++
> 2 files changed, 592 insertions(+)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

