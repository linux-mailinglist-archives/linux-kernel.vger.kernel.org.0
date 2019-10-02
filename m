Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6ABCC4549
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 03:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfJBBIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 21:08:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55080 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfJBBIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 21:08:17 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:b5c5:ae11:3e54:6a07])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4903C14C612AE;
        Tue,  1 Oct 2019 18:08:17 -0700 (PDT)
Date:   Tue, 01 Oct 2019 21:08:14 -0400 (EDT)
Message-Id: <20191001.210814.415335033876213685.davem@davemloft.net>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hso: fix NULL-deref on tty open
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190930151241.25646-1-johan@kernel.org>
References: <20190930151241.25646-1-johan@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 01 Oct 2019 18:08:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>
Date: Mon, 30 Sep 2019 17:12:41 +0200

> Fix NULL-pointer dereference on tty open due to a failure to handle a
> missing interrupt-in endpoint when probing modem ports:
> 
> 	BUG: kernel NULL pointer dereference, address: 0000000000000006
> 	...
> 	RIP: 0010:tiocmget_submit_urb+0x1c/0xe0 [hso]
> 	...
> 	Call Trace:
> 	hso_start_serial_device+0xdc/0x140 [hso]
> 	hso_serial_open+0x118/0x1b0 [hso]
> 	tty_open+0xf1/0x490
> 
> Fixes: 542f54823614 ("tty: Modem functions for the HSO driver")
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied, thanks.
