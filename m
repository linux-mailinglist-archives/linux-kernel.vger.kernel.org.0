Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38872F3125
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 15:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbfKGORU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 09:17:20 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48353 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKGORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:17:20 -0500
Received: from marcel-macpro.fritz.box (p5B3D2BA4.dip0.t-ipconnect.de [91.61.43.164])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2A6C2CED08;
        Thu,  7 Nov 2019 15:26:23 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] bluetooth: btmtksdio: add MODULE_DEVICE_TABLE()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191107094610.22132-1-brgl@bgdev.pl>
Date:   Thu, 7 Nov 2019 15:17:18 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Transfer-Encoding: 7bit
Message-Id: <D1FAA04C-681D-4832-AEDF-B4CE78FCA127@holtmann.org>
References: <20191107094610.22132-1-brgl@bgdev.pl>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

> This adds the missing MODULE_DEVICE_TABLE() for SDIO IDs. While certain
> platforms using this driver indeed have HW issues causing problems if
> the module is loaded too early - this should be handled from user-space
> by blacklisting it or delaying the loading.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> drivers/bluetooth/btmtksdio.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

