Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5998A36E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfHLQfX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Aug 2019 12:35:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57334 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfHLQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:35:22 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 23B94CECF3;
        Mon, 12 Aug 2019 18:44:02 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] Bluetooth: btrtl: Save firmware and config
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190805030733.GA11069@toshiba>
Date:   Mon, 12 Aug 2019 18:35:20 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <1BB38E27-5FAD-4402-86C1-6AA47E6BA08A@holtmann.org>
References: <20190805030733.GA11069@toshiba>
To:     Alex Lu <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> usb reset resume will cause downloading firmware again and
> requesting firmware may be failed while host is resuming
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> ---
> drivers/bluetooth/btrtl.c | 101 ++++++++++++++++++++++++++++++++++++--
> 1 file changed, 97 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 208feef63de4..416a5cb676e3 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -56,6 +56,8 @@ struct btrtl_device_info {
> 	int cfg_len;
> };
> 
> +static struct btrtl_device_info dev_info;
> +

No. We are are not using magic global variables. What happens if you attach more than one device? Also I assumed that request_firmware has a caching capability of sorts so that drivers don’t have to re-implement caching of the firmware.

Regards

Marcel

