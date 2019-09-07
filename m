Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A0AC70B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 16:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394685AbfIGOsc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Sep 2019 10:48:32 -0400
Received: from mxout014.mail.hostpoint.ch ([217.26.49.174]:36075 "EHLO
        mxout014.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391160AbfIGOsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 10:48:31 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6c0k-0001B0-95; Sat, 07 Sep 2019 16:48:22 +0200
Received: from 145-126.cable.senselan.ch ([83.222.145.126] helo=[192.168.1.99])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6c0k-000Oar-4s; Sat, 07 Sep 2019 16:48:22 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fixed parentheses malpractice in apex_driver.c
Date:   Sat, 7 Sep 2019 16:48:21 +0200
Message-Id: <C3F8799B-2CFE-4F3B-A01A-DFDF248BA01F@volery.com>
References: <20190907143849.GA30834@kadam>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190907143849.GA30834@kadam>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: iPhone Mail (17A5572a)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 7 Sep 2019, at 16:39, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> ﻿You need a subject prefix.  It should be something like:
> 
> [PATCH] Staging: gasket: Fix parentheses malpractice in apex_driver.c
> 

Thanks for the reply! I'll try to do that better for my next patch.

> Generally "Fix" is considered better style than "Fixed".  We aren't
> going to care about that in staging, but the patch prefix is mandatory
> so you will need to redo it anyway and might as well fix that as well.
> 
>> On Fri, Sep 06, 2019 at 08:38:01PM +0200, volery wrote:
>> There were some parentheses at the end of lines, which I took care of.
>> This is my first patch.
>  ^^^^^^^^^^^^^^^^^^^^^^
> Put this sort of comments after the --- cut off line
> 
>> 
>> Signed-off-by: Sandro Volery <sandro@volery.com>
>> ---
>  ^^^
> Put it here.  It will be removed when we apply the patch so it won't
> be recorded in the git log.
> 

Alright :)

>> drivers/staging/gasket/apex_driver.c | 9 ++++++---
>> 1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Joe's comments are, of course, correct as well.
> 
> regards,
> dan carpenter
> 

I'll take a look at Joe's suggestions too sometime tonight. I'd feel kinda bad tho if I just apply his work and send it in?

- Sandro Volery
