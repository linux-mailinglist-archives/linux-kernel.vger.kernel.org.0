Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A30810DA14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 20:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfK2TWi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Nov 2019 14:22:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59120 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfK2TWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 14:22:37 -0500
Received: from [192.168.1.91] (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 923A2CECDE;
        Fri, 29 Nov 2019 20:31:44 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] Bluetooth: btusb: fix memory leak on fw
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191129173635.87479-1-colin.king@canonical.com>
Date:   Fri, 29 Nov 2019 20:22:05 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F011BBCD-8D95-4934-AB3E-0F264990D4F2@holtmann.org>
References: <20191129173635.87479-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

> Currently the error return path when the call to btusb_mtk_hci_wmt_sync
> fails does not free fw.  Fix this by returning via the error_release_fw
> label that performs the free'ing.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: a1c49c434e15 ("Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB devices")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

