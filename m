Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 032F0162238
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 09:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgBRI0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 03:26:45 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39619 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgBRI0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:26:45 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 03A86CED25;
        Tue, 18 Feb 2020 09:36:07 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] Bluetooth: hci_h5: btrtl: Add support for RTL8822C
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200217081455.30938-1-max.chou@realtek.com>
Date:   Tue, 18 Feb 2020 09:26:43 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, kidman@realtek.com
Content-Transfer-Encoding: 7bit
Message-Id: <7EF06924-73AD-42C9-B372-D2FA4CD4F585@holtmann.org>
References: <20200217081455.30938-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

> Add new compatible and FW loading support for RTL8822C.
> 
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
> Changes in v2:
> - Separate the code description for ACPI and OF
> - Note that forgiving my less experience, I can not find bt3wire.c from the
> upstream. I just find hci_h5.c can support Realtek Bluetooth controller,
> so I modify the code here for new chip support.
> ---
> drivers/bluetooth/Kconfig  |  2 +-
> drivers/bluetooth/btrtl.c  | 12 ++++++++++++
> drivers/bluetooth/hci_h5.c | 19 +++++++++++++++++++
> 3 files changed, 32 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

