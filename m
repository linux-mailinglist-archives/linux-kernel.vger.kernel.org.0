Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD7DD730
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 09:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfJSH5K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Oct 2019 03:57:10 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52943 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfJSH5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 03:57:09 -0400
Received: from surfer-172-29-2-69-hotspot.internet-for-guests.com (p2E5701B0.dip0.t-ipconnect.de [46.87.1.176])
        by mail.holtmann.org (Postfix) with ESMTPSA id F3E01CED04;
        Sat, 19 Oct 2019 10:06:05 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH -next] Bluetooth: btusb: Remove return statement in
 btintel_reset_to_bootloader
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191018222924.49256-1-natechancellor@gmail.com>
Date:   Sat, 19 Oct 2019 09:57:06 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Transfer-Encoding: 8BIT
Message-Id: <859945F9-E674-4906-A18D-BCA6027AA535@holtmann.org>
References: <20191018111343.5a34ee33@canb.auug.org.au>
 <20191018222924.49256-1-natechancellor@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

> When building with Clang and CONFIG_BT_INTEL unset, the following error
> occurs:
> 
> In file included from drivers/bluetooth/hci_ldisc.c:34:
> drivers/bluetooth/btintel.h:188:2: error: void function
> 'btintel_reset_to_bootloader' should not return a value [-Wreturn-type]
>        return -EOPNOTSUPP;
>        ^      ~~~~~~~~~~~
> 1 error generated.
> 
> Remove the unneeded return statement to fix this.
> 
> Fixes: b9a2562f4918 ("Bluetooth: btusb: Trigger Intel FW download error recovery")
> Link: https://github.com/ClangBuiltLinux/linux/issues/743
> Reported-by: <ci_notify@linaro.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> drivers/bluetooth/btintel.h | 1 -
> 1 file changed, 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

