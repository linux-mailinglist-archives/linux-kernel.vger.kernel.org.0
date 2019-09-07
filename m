Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F80AC931
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 22:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436691AbfIGUaQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Sep 2019 16:30:16 -0400
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:20052 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390111AbfIGUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 16:30:15 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6hLV-000Glu-Pz; Sat, 07 Sep 2019 22:30:09 +0200
Received: from 145-126.cable.senselan.ch ([83.222.145.126] helo=[192.168.1.99])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6hLV-0001u5-MY; Sat, 07 Sep 2019 22:30:09 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 7 Sep 2019 22:30:09 +0200
Message-Id: <C511485C-6194-4B31-BA98-C4C9000062AD@volery.com>
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
In-Reply-To: <529940f5dd3ca0426f8e953d232a16b4eccfbfb7.camel@perches.com>
References: <529940f5dd3ca0426f8e953d232a16b4eccfbfb7.camel@perches.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (17A5572a)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Sandro V

>> On 7 Sep 2019, at 22:04, Joe Perches <joe@perches.com> wrote:
>> 
>> ﻿On Sat, 2019-09-07 at 11:09 +0200, volery wrote:
>> There were a lot of styling problems using space then tab or spaces
>> instead of tabs in that file. Especially the entire function at line
>> 2677.
>> Also added a space before the : on line 2221.
> 
> You do not have an appropriate subject line.
> 
> This subject should probably be something like:
> 
> [PATCH] tty: tty_io: Use normal indentation
> 
> Please make changes only in drivers/staging until you are
> really familiar with the linux kernel patch process.
Yep, noticed that I had the subject line wrong on this one too 
after Dan told me about that today.
I'll take that drivers/staging thing into account :) 

Thanks again
Sandro





