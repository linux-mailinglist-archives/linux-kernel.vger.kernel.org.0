Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF10BA3189
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfH3Hti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 03:49:38 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37181 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfH3Hti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:49:38 -0400
Received: from [172.20.10.2] (tmo-106-216.customers.d1-online.com [80.187.106.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 71670CECD9;
        Fri, 30 Aug 2019 09:58:22 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Revert "Bluetooth: btusb: driver to enable the usb-wakeup
 feature"
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190828121349.24966-1-msuchanek@suse.de>
Date:   Fri, 30 Aug 2019 09:49:35 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        oneukum@suse.com, acho@suse.com, tiwai@suse.com, jlee@suse.com
Content-Transfer-Encoding: 7bit
Message-Id: <C481EEBC-0280-4A20-BEBD-9A888AF5F03F@holtmann.org>
References: <20190828121349.24966-1-msuchanek@suse.de>
To:     Michal Suchanek <msuchanek@suse.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

> This reverts commit a0085f2510e8976614ad8f766b209448b385492f.
> 
> After this commit systems wake up at random, most commonly when
> 
> - put to sleep while bluetooth audio stream is running
> - connected bluetooth audio device is powered off while system is
> asleep
> 
> This is broken since the commit was merged up to 5.3-rc6.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> drivers/bluetooth/btusb.c | 5 -----
> 1 file changed, 5 deletions(-)

I think that Mario send in the same patch already.

Regards

Marcel

