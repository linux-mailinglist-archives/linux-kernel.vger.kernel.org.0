Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9399652307
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 07:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfFYFnG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jun 2019 01:43:06 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33704 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfFYFnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:43:06 -0400
Received: from marcel-macpro.fritz.box (p4FEFC3D2.dip0.t-ipconnect.de [79.239.195.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5349FCF2B1;
        Tue, 25 Jun 2019 07:51:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] Bluetooth: btrtl: HCI reset on close for Realtek BT
 chip
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD8Lp47G-+VRFGgakYyVFT8CLSgspvn_E-rMq6AMjiUrdF022A@mail.gmail.com>
Date:   Tue, 25 Jun 2019 07:43:03 +0200
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B8AD29F1-444A-4BB7-8C12-9C31EB974D11@holtmann.org>
References: <CAD8Lp44RP+ugBcDYkap3tUL1NSq+knGJbO9A6UAmCtcjPgxTQQ@mail.gmail.com>
 <20190624062114.20303-1-jian-hong@endlessm.com>
 <CAD8Lp47G-+VRFGgakYyVFT8CLSgspvn_E-rMq6AMjiUrdF022A@mail.gmail.com>
To:     Daniel Drake <drake@endlessm.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

>> Realtek RTL8822BE BT chip on ASUS X420FA cannot be turned on correctly
>> after on-off several times. Bluetooth daemon sets BT mode failed when
>> this issue happens.
> 
> You could also mention that scanning must be active while turning off
> for this bug to be hit.
> 
>> bluetoothd[1576]: Failed to set mode: Failed (0x03)
>> 
>> If BT is tunred off, then turned on again, it works correctly again.
> 
> Typo: turned
> 
>> According to the vendor driver, the HCI_QUIRK_RESET_ON_CLOSE flag is set
>> during probing. So, this patch makes Realtek's BT reset on close to fix
>> this issue.
> 
> Checked the vendor driver - I see what you are referring to, so the
> change seems correct.
> 
> #if HCI_VERSION_CODE >= KERNEL_VERSION(3, 7, 1)
>    if (!reset)
>        set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
>    RTKBT_DBG("set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);");
> #endif
> 
> However I'm pretty sure this is not saying that kernel 3.7.0 did not
> need the reset. I think it just means that the flag did not exist
> before Linux-3.7.1, so they added the ifdef to add some level of
> compatibility with older kernel versions. I think you can remove
> "since kernel v3.7.1." from the comment.
> 
> After those changes you can add:
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203429
> Reviewed-by: Daniel Drake <drake@endlessm.com>

if someone wants to use HCI_Reset to ensure that all their connections and radio usage is reset, then they should do that via the hdev->shutdown handler. Look at btusb.c if you need an example.

This quirk is for hardware that can not use HCI_Reset on init which is Bluetooth 1.0b hardware.

Regards

Marcel

