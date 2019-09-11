Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE34AFA41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfIKKY3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Sep 2019 06:24:29 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:41319 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726696AbfIKKY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:24:28 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7znV-000BZB-4E; Wed, 11 Sep 2019 12:24:25 +0200
Received: from [213.55.220.251] (helo=[100.66.103.90])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7znU-000PHX-V7; Wed, 11 Sep 2019 12:24:25 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] Staging: exfat: Avoid use of strcpy
Date:   Wed, 11 Sep 2019 12:24:23 +0200
Message-Id: <EAFF08E1-747C-4084-BFEF-A89465A6F9ED@volery.com>
References: <20190911100616.GH20699@kadam>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
In-Reply-To: <20190911100616.GH20699@kadam>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: iPhone Mail (17A5831c)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 11 Sep 2019, at 12:06, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> ﻿On Wed, Sep 11, 2019 at 11:42:19AM +0200, Sandro Volery wrote:
>> Use strscpy instead of strcpy in exfat_core.c, and add a check
>> for length that will return already known FFS_INVALIDPATH.
>> 
>> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> Signed-off-by: Sandro Volery <sandro@volery.com>
>> ---
>> v2: Implement length check and return in one
>> v1: Original Patch
>> drivers/staging/exfat/exfat_core.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
>> index da8c58149c35..4c40f1352848 100644
>> --- a/drivers/staging/exfat/exfat_core.c
>> +++ b/drivers/staging/exfat/exfat_core.c
>> @@ -2964,7 +2964,8 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
>>    if (strlen(path) >= (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Delete this as it is no longer required.
> 

Yep, saw it from Rasmus response too just now.. Dumb mistake.
Will fix this this afternoon.

Sandro V

>>        return FFS_INVALIDPATH;
>> 
>> -    strcpy(name_buf, path);
>> +    if (strscpy(name_buf, path, sizeof(name_buf)) < 0)
>> +        return FFS_INVALIDPATH;
> 


