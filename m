Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D93AC78E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394916AbfIGQMt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Sep 2019 12:12:49 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:23001 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388922AbfIGQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:12:48 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6dKQ-000GAM-6W; Sat, 07 Sep 2019 18:12:46 +0200
Received: from [213.55.224.80] (helo=[100.100.89.92])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6dKQ-000JaD-22; Sat, 07 Sep 2019 18:12:46 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fixed parentheses malpractice in apex_driver.c
Date:   Sat, 7 Sep 2019 18:12:45 +0200
Message-Id: <6EC85D2C-F3B5-4637-8FCF-486F037E0DC2@volery.com>
References: <8d6586f8772dd68695b9348ef977f2d9afa7645d.camel@perches.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <8d6586f8772dd68695b9348ef977f2d9afa7645d.camel@perches.com>
To:     Joe Perches <joe@perches.com>
X-Mailer: iPhone Mail (17A5572a)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, I'll do that when I get home tonight!

Thanks,
Sandro V

> On 7 Sep 2019, at 18:08, Joe Perches <joe@perches.com> wrote:
> 
> ﻿On Sat, 2019-09-07 at 17:56 +0200, Sandro Volery wrote:
>>>> On 7 Sep 2019, at 17:44, Joe Perches <joe@perches.com> wrote:
>>> 
>>> ﻿On Sat, 2019-09-07 at 17:34 +0200, Sandro Volery wrote:
>>>> On patchwork I entered 'volery' as my username because I didn't know better, and now checkpatch always complains when I add 'signed-off-by' with my actual full name.
>>> 
>>> How does checkpatch complain?
>>> There is no connection between patchwork
>>> and checkpatch.
>> 
>> Checkpatch tells me that I haven't used 'volery' as
>> my signed off name.
> 
> Please send the both the patch and the actual checkpatch output
> you get when running 'perl ./scripts/checkpatch.pl <patch>'
> 
> If this patch is a commit in your own local git tree:
> 
> $ git format-patch -1 --stdout <commit_id> > tmp
> $ perl ./scripts/checkpatch.pl --strict tmp
> 
> and send tmp and the checkpatch output.
> 
> 

