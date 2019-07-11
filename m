Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0719165237
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 09:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfGKHJF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Jul 2019 03:09:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59491 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfGKHJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 03:09:04 -0400
Received: from [192.168.23.168] (unknown [157.25.100.178])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5EBADCF2B8;
        Thu, 11 Jul 2019 09:17:35 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: btqca: Use correct byte format for opcode of
 injected command
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190708215742.65960-1-mka@chromium.org>
Date:   Thu, 11 Jul 2019 09:09:01 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        kbuild test robot <lkp@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <043AF8B7-8128-4470-B02F-3429A3F0CF54@holtmann.org>
References: <20190708215742.65960-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> The opcode of the command injected by commit 32646db8cc28 ("Bluetooth:
> btqca: inject command complete event during fw download") uses the CPU
> byte format, however it should always be little endian. In practice it
> shouldn't really matter, since all we need is an opcode != 0, but still
> let's do things correctly and keep sparse happy.
> 
> Fixes: 32646db8cc28 ("Bluetooth: btqca: inject command complete event during fw download")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> drivers/bluetooth/btqca.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

