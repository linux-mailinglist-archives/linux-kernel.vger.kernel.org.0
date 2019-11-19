Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC5AC101922
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 07:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfKSFU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 00:20:58 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50892 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfKSFU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:20:58 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 59613CECED;
        Tue, 19 Nov 2019 06:30:03 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM4334B0 UART Bluetooth
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191117203946.233900-1-stephan@gerhold.net>
Date:   Tue, 19 Nov 2019 06:20:56 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <115C4A5E-2D84-4AED-BFB0-DBB4D74BB25F@holtmann.org>
References: <20191117203946.233900-1-stephan@gerhold.net>
To:     Stephan Gerhold <stephan@gerhold.net>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

> Add the device ID for the WiFi/BT/FM combo chip BCM4334 (rev B0).
> 
> The chip seems to use 43:34:b0:00:00:00 as default address,
> so add it to the list of default addresses and leave it up
> to the user to configure a valid one.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> drivers/bluetooth/btbcm.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

