Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B061A6103B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 13:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfGFLD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 07:03:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37173 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGFLD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 07:03:29 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id DC2ADCEFAE;
        Sat,  6 Jul 2019 13:11:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: hci_bcsp: Fix memory leak in rx_skb
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190528134258.3743-1-tomasbortoli@gmail.com>
Date:   Sat, 6 Jul 2019 13:03:21 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8B92FC2D-0E72-479B-8BF8-ADCCC3816286@holtmann.org>
References: <20190528134258.3743-1-tomasbortoli@gmail.com>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

> Syzkaller found that it is possible to provoke a memory leak by
> never freeing rx_skb in struct bcsp_struct.
> 
> Fix by freeing in bcsp_close()
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+98162c885993b72f19c4@syzkaller.appspotmail.com
> ---
> drivers/bluetooth/hci_bcsp.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

