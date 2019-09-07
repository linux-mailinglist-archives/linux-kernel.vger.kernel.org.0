Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD46AC769
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406758AbfIGP4l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Sep 2019 11:56:41 -0400
Received: from mxout014.mail.hostpoint.ch ([217.26.49.174]:42821 "EHLO
        mxout014.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406748AbfIGP4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 11:56:40 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6d4o-000CYW-5r; Sat, 07 Sep 2019 17:56:38 +0200
Received: from [213.55.224.80] (helo=[100.100.89.92])
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6d4n-0005nH-Vy; Sat, 07 Sep 2019 17:56:38 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fixed parentheses malpractice in apex_driver.c
Date:   Sat, 7 Sep 2019 17:56:37 +0200
Message-Id: <10B80D83-A473-4F46-8CCC-C50231DC42EA@volery.com>
References: <25c248afff16f2b16b1c7ca4209e8ab727113f0d.camel@perches.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <25c248afff16f2b16b1c7ca4209e8ab727113f0d.camel@perches.com>
To:     Joe Perches <joe@perches.com>
X-Mailer: iPhone Mail (17A5572a)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 7 Sep 2019, at 17:44, Joe Perches <joe@perches.com> wrote:
> 
> ﻿On Sat, 2019-09-07 at 17:34 +0200, Sandro Volery wrote:
>> On patchwork I entered 'volery' as my username because I didn't know better, and now checkpatch always complains when I add 'signed-off-by' with my actual full name.
> 
> How does checkpatch complain?
> There is no connection between patchwork
> and checkpatch.

Checkpatch tells me that I haven't used 'volery' as
my signed off name.


> 
> And do please set your email client to use shorter line lengths
> or remember to add returns.
> 
> 72 or so is typical.
> 

Alright! Using my phone right now as I
am out of office but will do :)
