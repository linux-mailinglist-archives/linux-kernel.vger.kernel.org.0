Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A966D8A407
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 19:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfHLRK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 13:10:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36092 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfHLRKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:10:55 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7D922CECF5;
        Mon, 12 Aug 2019 19:19:35 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next] Bluetooth: hci_bcm: Fix -Wunused-const-variable
 warnings
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190812062211.69984-1-yuehaibing@huawei.com>
Date:   Mon, 12 Aug 2019 19:10:53 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <AE59FB65-6D4A-46AA-AFF7-EC80D11028D1@holtmann.org>
References: <20190812062211.69984-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

> If CONFIG_ACPI is not set, gcc warn this:
> 
> drivers/bluetooth/hci_bcm.c:831:39: warning:
> acpi_bcm_int_last_gpios defined but not used [-Wunused-const-variable=]
> drivers/bluetooth/hci_bcm.c:838:39: warning:
> acpi_bcm_int_first_gpios defined but not used [-Wunused-const-variable=]
> 
> move them to #ifdef CONFIG_ACPI block.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> drivers/bluetooth/hci_bcm.c | 30 +++++++++++++++---------------
> 1 file changed, 15 insertions(+), 15 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

