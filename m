Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55E1099F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 09:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKZINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 03:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfKZINC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:13:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 279CE2073F;
        Tue, 26 Nov 2019 08:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574755980;
        bh=K4/HkReIZHrO5EOLAYxEYM72msVBHQIR4SGBUnnMj+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0J/UfMLdTXQOEdPa8OBVc2zM5FSC0jOWmtISPlva5y3Rkl5I4VEFoie7afPQmLucJ
         FuD9S6AXb5BAnFrt5dlO0hXk4nVbCmC+7jFjh3oHi8UPZEA6js4fkWFqGDQ+YoGdhS
         KCXdocgCSWUnoLRMkYJwpkN5hTQFfpNnDkrCPHR0=
Date:   Tue, 26 Nov 2019 09:12:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix invalid-free in bcsp_close()
Message-ID: <20191126081258.GA1233188@kroah.com>
References: <000000000000109f9605964acf6c@google.com>
 <20191101204244.14509-1-tomasbortoli@gmail.com>
 <E16896E5-B946-450F-BF42-04665D219EEA@holtmann.org>
 <CAG_fn=Xqb1KoAvV==F5sODUYHDsxCxaz72n6qucdkR70XGCkig@mail.gmail.com>
 <8376D008-EA21-49EA-AF5A-DDDCB179EAC5@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8376D008-EA21-49EA-AF5A-DDDCB179EAC5@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 07:18:46AM +0100, Marcel Holtmann wrote:
> Hi Alexander,
> 
> >>> Syzbot reported an invalid-free that I introduced fixing a memleak.
> >>> 
> >>> bcsp_recv() also frees bcsp->rx_skb but never nullifies its value.
> >>> Nullify bcsp->rx_skb every time it is freed.
> >>> 
> >>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> >>> Reported-by: syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
> >>> ---
> >>> drivers/bluetooth/hci_bcsp.c | 3 +++
> >>> 1 file changed, 3 insertions(+)
> >> 
> >> patch has been applied to bluetooth-next tree.
> > I believe this bug requires stable tags, as it can potentially provide
> > an arbitrary write (via __skb_unlink) and is triggerable locally with
> > user privileges.
> 
> I do not have a reproducer for it, but if you do, feel free to propose it for -stable inclusion.

Now queued up, thanks.

greg k-h
