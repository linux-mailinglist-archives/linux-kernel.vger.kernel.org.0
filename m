Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE9A8D56C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfHNNxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 09:53:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57072 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfHNNxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:53:42 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id A728ECED0B;
        Wed, 14 Aug 2019 16:02:22 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] Bluetooth: btusb: Fix suspend issue for Realtek
 devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190814120252.GA4572@toshiba>
Date:   Wed, 14 Aug 2019 15:53:40 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <B5282441-D76E-41B4-901B-664974EC0E50@holtmann.org>
References: <20190814120252.GA4572@toshiba>
To:     Alex Lu <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> From the perspective of controller, global suspend means there is no
> SET_FEATURE (DEVICE_REMOTE_WAKEUP) and controller would drop the
> firmware. It would consume less power. So we should not send this kind
> of SET_FEATURE when host goes to suspend state.
> Otherwise, when making device enter selective suspend, host should send
> SET_FEATURE to make sure the firmware remains.
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> ---
> Changes in v3:
>  - Change to fit for bluetooth-next
> Changes in v2:
>  - Change flag to be more descriptive
>  - Delete pointless #ifdef CONFIG_BT_HCIBTUSB_RTL and #endif
> 
> drivers/bluetooth/btusb.c | 34 ++++++++++++++++++++++++++++++----
> 1 file changed, 30 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

