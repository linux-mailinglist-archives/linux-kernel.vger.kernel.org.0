Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02DA3417
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfH3Jel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 05:34:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:46960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfH3Jek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:34:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87098AC37;
        Fri, 30 Aug 2019 09:34:39 +0000 (UTC)
Date:   Fri, 30 Aug 2019 11:34:37 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        oneukum@suse.com, acho@suse.com, tiwai@suse.com, jlee@suse.com
Subject: Re: [PATCH] Revert "Bluetooth: btusb: driver to enable the
 usb-wakeup feature"
Message-ID: <20190830113437.3508bce9@naga>
In-Reply-To: <C481EEBC-0280-4A20-BEBD-9A888AF5F03F@holtmann.org>
References: <20190828121349.24966-1-msuchanek@suse.de>
        <C481EEBC-0280-4A20-BEBD-9A888AF5F03F@holtmann.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 09:49:35 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Michal,
> 
> > This reverts commit a0085f2510e8976614ad8f766b209448b385492f.
> > 
> > After this commit systems wake up at random, most commonly when
> > 
> > - put to sleep while bluetooth audio stream is running
> > - connected bluetooth audio device is powered off while system is
> > asleep
> > 
> > This is broken since the commit was merged up to 5.3-rc6.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > drivers/bluetooth/btusb.c | 5 -----
> > 1 file changed, 5 deletions(-)  
> 
> I think that Mario send in the same patch already.

Yes, I found it after this copy was threaded with the previous one on
lore.kernel.org. Anyway, there are multiple reasons why this is broken.

AFAICT the wakeup feature is only workable with OSes that are able to
wakeup into a small gadget that can check if the packet is interesting
and put the system back to sleep if not without going through the whole
online/offline everything sequence.

Thanks

Michal

