Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19262A380
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 10:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfEYIvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 04:51:16 -0400
Received: from skyboo.net ([94.40.87.198]:44730 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbfEYIvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:51:15 -0400
Received: from [10.1.0.1] (helo=nemesis.skyboo.net)
        by skyboo.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1hUSOW-0000r0-Na; Sat, 25 May 2019 10:51:13 +0200
Date:   Sat, 25 May 2019 10:51:12 +0200
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Message-Id: <20190525105112.0ff6e351e5f38013d932fc64@skyboo.net>
In-Reply-To: <20190524182109.GA26827@kroah.com>
References: <20190520070558.20142-1-manio@skyboo.net>
        <20190520070558.20142-4-manio@skyboo.net>
        <20190524182109.GA26827@kroah.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.1.0.1
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: manio@skyboo.net
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on nemesis.skyboo.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.1
Subject: Re: [PATCH 4/4] w1: ds2805: rename w1_family struct, fixing c-p
 typo
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 20:21:09 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, May 20, 2019 at 09:05:58AM +0200, Mariusz Bialonczyk wrote:
> > Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
> > ---
> >  drivers/w1/slaves/w1_ds2805.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> I can not take patches without any changelog text, sorry.
Greg,
I'm sorry, I thought that a subject commit line in such
simple commits is enough.

I just resend this single one with commit message filled:
https://lore.kernel.org/lkml/20190525084538.29389-1-manio@skyboo.net/

Thanks!

regards,
-- 
Mariusz Białończyk | xmpp/e-mail: manio@skyboo.net
https://skyboo.net | https://github.com/manio
