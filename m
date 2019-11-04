Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4CFEE20C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 15:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfKDOTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 09:19:54 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41538 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfKDOTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:19:54 -0500
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1F88ECECD7;
        Mon,  4 Nov 2019 15:28:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] Fix invalid-free in bcsp_close()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191101204244.14509-1-tomasbortoli@gmail.com>
Date:   Mon, 4 Nov 2019 15:19:52 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, syzkaller@googlegroups.com,
        syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <E16896E5-B946-450F-BF42-04665D219EEA@holtmann.org>
References: <000000000000109f9605964acf6c@google.com>
 <20191101204244.14509-1-tomasbortoli@gmail.com>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

> Syzbot reported an invalid-free that I introduced fixing a memleak.
> 
> bcsp_recv() also frees bcsp->rx_skb but never nullifies its value.
> Nullify bcsp->rx_skb every time it is freed.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
> ---
> drivers/bluetooth/hci_bcsp.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

