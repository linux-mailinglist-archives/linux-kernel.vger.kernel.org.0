Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0204D60FF4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 12:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfGFKv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 06:51:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58029 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGFKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:51:24 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id C3C90CF164;
        Sat,  6 Jul 2019 12:59:54 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] Bluetooth: btrtl: HCI reset on close for Realtek BT
 chip
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190625083051.7525-1-jian-hong@endlessm.com>
Date:   Sat, 6 Jul 2019 12:51:22 +0200
Cc:     Daniel Drake <drake@endlessm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3544D13C-5774-45C4-B266-71FC1C254BA0@holtmann.org>
References: <B8AD29F1-444A-4BB7-8C12-9C31EB974D11@holtmann.org>
 <20190625083051.7525-1-jian-hong@endlessm.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian-Hong,

> Realtek RTL8822BE BT chip on ASUS X420FA cannot be turned on correctly
> after on-off several times. Bluetooth daemon sets BT mode failed when
> this issue happens. Scanning must be active while turning off for this
> bug to be hit.
> 
> bluetoothd[1576]: Failed to set mode: Failed (0x03)
> 
> If BT is turned off, then turned on again, it works correctly again.
> 
> According to the vendor driver, the HCI_QUIRK_RESET_ON_CLOSE flag is set
> during probing. So, this patch makes Realtek's BT reset on close to fix
> this issue.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203429
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
> v2:
> - According to the vendor driver, it makes "all" Realtek's BT reset on
>   close. So, this version makes it the same.
> - Change to the new subject for all Realtek BT chips.
> 
> v3:
> - Fix the commit message and add the bug link.
> - Have btrtl_shutdown_realtek() which sends HCI reset command and as
>   the callback function of hdev->shutdown for Realtek BT instead of
>   setting HCI_QUIRK_RESET_ON_CLOSE flag.
> 
> drivers/bluetooth/btrtl.c | 20 ++++++++++++++++++++
> drivers/bluetooth/btrtl.h |  6 ++++++
> drivers/bluetooth/btusb.c |  1 +
> 3 files changed, 27 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

