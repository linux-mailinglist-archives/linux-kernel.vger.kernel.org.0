Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E73209EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 16:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfEPOlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 10:41:05 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15985 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfEPOlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:41:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdd767a0000>; Thu, 16 May 2019 07:41:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 May 2019 07:41:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 May 2019 07:41:04 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 14:41:02 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 14:41:02 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.147]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cdd767c0004>; Thu, 16 May 2019 07:41:02 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <keescook@chromium.org>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v10 0/2] usb: xhci: Add Clear_TT_Buffer
Date:   Thu, 16 May 2019 22:40:55 +0800
Message-ID: <1558017657-13835-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558017660; bh=v2kdg0G9OB35EhsiUGeW5BB34SuON9Dmd2af6lTUn60=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=mKnvF0RvRwNv3ft+9LtXSA+tGcl9pG8thUaoFWxP0h+pNAax3tEW7WCK7DvWo260W
         /hqBoGm91fR8n6C6ckPlbFmXXKBZWYrqAv6K3qAhaSk+/OOcrwCKA0YgrAEaz95Z0v
         riB8/wlW0rm5KS7PwWDSqrCE5I4gFmBYgPIaPpSfslfwSyBaRDEWqMVeeTH1vrVvxf
         tiuFxWRh4gzVGuQjAt738Z5G+dXco2LP7HJ5DzqZ/pvzTiEh0yNJQfsgu8GP31gaAs
         dD0NmJqvaswtwzqOabgpnvXASWVYR45xKacp7/9SOabZiR4mkCCC4YklvD0J0/BrgR
         wTmaou7KVmQAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
processing for full-/low-speed endpoints connected via a TT, the host
software must use the Clear_TT_Buffer request to the TT to ensure
that the buffer is not in the busy state".

In our case, a full-speed speaker (ConferenceCam) is behind a high-
speed hub (ConferenceCam Connect), sometimes once we get STALL on a
request we may continue to get STALL with the folllowing requests,
like Set_Interface.

Solution is to invoke usb_hub_clear_tt_buffer() to send
Clear_TT_Buffer request to the hub of the device for the following
Set_Interface requests to the device to get ACK successfully.

The Clear_TT_Buffer request sent to the hub includes the address of
the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
uses udev->devnum to set the address wValue. This won't work for
devices connected to xHC.

For other host controllers udev->devnum is the same as the address of
the usb device, chosen and set by usb core. With xHC the controller
hardware assigns the address, and won't be the same as devnum.

Here we have two patches.
One is to add devaddr in struct usb_device for
usb_hub_clear_tt_buffer() to use.
Another is to invoke usb_hub_clear_tt_buffer() for halt processing.
 
Signed-off-by: Jim Lin <jilin@nvidia.com>

Jim Lin (2):
  usb: xhci : Add devaddr in struct usb_device
  usb: xhci: Add Clear_TT_Buffer

 drivers/usb/core/hub.c       |  4 +++-
 drivers/usb/host/xhci-ring.c | 27 ++++++++++++++++++++++++++-
 drivers/usb/host/xhci.c      | 18 ++++++++++++++++++
 drivers/usb/host/xhci.h      |  5 +++++
 include/linux/usb.h          |  2 ++
 5 files changed, 54 insertions(+), 2 deletions(-)

-- 
2.1.4

