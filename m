Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19C88E501
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfHOGra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 02:47:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49406 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfHOGra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 02:47:30 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1382CCED13;
        Thu, 15 Aug 2019 08:56:10 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Make structure qca_proto constant
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190815055149.1062-1-nishkadg.linux@gmail.com>
Date:   Thu, 15 Aug 2019 08:47:27 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A5C926E6-EC4B-412D-AF03-D31A46A385A0@holtmann.org>
References: <20190815055149.1062-1-nishkadg.linux@gmail.com>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishka,

> Static structure qca_proto, of type hci_uart_proto, is used four times:
> as the last argument in function hci_uart_register_device(), and as the
> only argument to functions hci_uart_register_proto() and
> hci_uart_unregister_proto(). In all three of these functions, the
> parameter corresponding to qca_proto is declared as constant. Therefore,
> make qca_proto itself constant as well in order to protect it from
> unintended modification.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
> drivers/bluetooth/hci_qca.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

