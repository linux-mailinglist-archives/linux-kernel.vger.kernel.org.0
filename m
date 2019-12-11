Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1864911A8B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 11:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfLKKSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 05:18:05 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35069 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbfLKKSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:18:05 -0500
Received: from marcel-macpro.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2AFCFCECD1;
        Wed, 11 Dec 2019 11:27:14 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v3] bluetooth: hci_bcm: enable IRQ capability from node
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191211094923.20220-1-glaroque@baylibre.com>
Date:   Wed, 11 Dec 2019 11:18:02 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com
Content-Transfer-Encoding: 7bit
Message-Id: <CE75662F-772B-4C03-8079-4BC0D2EB84B8@holtmann.org>
References: <20191211094923.20220-1-glaroque@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

> Actually IRQ can be found from GPIO but all platforms don't support
> gpiod_to_irq, it's the case on amlogic chip.
> so to have possibility to use interrupt mode we need to add interrupts
> field in node and support it in driver.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> drivers/bluetooth/hci_bcm.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

