Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9ACCA317D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 09:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfH3Hqs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Aug 2019 03:46:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53169 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfH3Hqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:46:44 -0400
Received: from [172.20.10.2] (tmo-106-216.customers.d1-online.com [80.187.106.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9FA86CECD9;
        Fri, 30 Aug 2019 09:55:28 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Revert "Bluetooth: btusb: driver to enable the usb-wakeup
 feature"
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1566234248-13799-1-git-send-email-mario.limonciello@dell.com>
Date:   Fri, 30 Aug 2019 09:46:41 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Christian Kellner <ckellner@redhat.com>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <C267E729-1029-43A3-8665-BF1CFA894378@holtmann.org>
References: <1566234248-13799-1-git-send-email-mario.limonciello@dell.com>
To:     Mario Limonciello <Mario.Limonciello@dell.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

> This reverts commit a0085f2510e8976614ad8f766b209448b385492f.
> 
> This commit has caused regressions in notebooks that support suspend
> to idle such as the XPS 9360, XPS 9370 and XPS 9380.
> 
> These notebooks will wakeup from suspend to idle from an unsolicited
> advertising packet from an unpaired BLE device.
> 
> In a bug report it was sugggested that this is caused by a generic
> lack of LE privacy support.  Revert this commit until that behavior
> can be avoided by the kernel.
> 
> Fixes: a0085f2510e8 ("Bluetooth: btusb: driver to enable the usb-wakeup feature")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=200039
> Link: https://marc.info/?l=linux-bluetooth&m=156441081612627&w=2
> Link: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/750073/
> CC: Bastien Nocera <hadess@hadess.net>
> CC: Christian Kellner <ckellner@redhat.com>
> CC: Sukumar Ghorai <sukumar.ghorai@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
> drivers/bluetooth/btusb.c | 5 -----
> 1 file changed, 5 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

