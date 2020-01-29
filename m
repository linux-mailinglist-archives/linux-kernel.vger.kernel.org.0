Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD25114C44A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 02:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgA2BDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 20:03:20 -0500
Received: from ishtar.tlinx.org ([173.164.175.65]:42064 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgA2BDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 20:03:20 -0500
X-Greylist: delayed 1519 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jan 2020 20:03:20 EST
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id 00T0bwu8058366
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 16:38:00 -0800
Message-ID: <5E30D3E6.6050300@tlinx.org>
Date:   Tue, 28 Jan 2020 16:37:58 -0800
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
CC:     Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] build-sys: fix configure --without-systemd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/01/28 04:07, Karel Zak wrote:

> On Fri, Jan 24, 2020 at 12:29:47PM -0500, Theodore Ts'o wrote:
>   
>>  AC_ARG_WITH([systemd],
>>    AS_HELP_STRING([--without-systemd], [do not build with systemd support]),
>> -  [], [with_systemd=check]
>> +  [], [with_systemd=no]
>>     
>
> The current default is to check for the libraries, if installed than
> enable systemd support. This is generic way we use for many libs and
> features. Why do you think that explicit --enable-* will be better?
>   
---

    Perhaps Ted didn't realize that the line he replaced
was only the default action (1st bracket pair empty => no option).
Initially, I thought the same until I read further
down (two lines):

have_systemd=no
AS_IF([test "x$with_systemd" != xno], [ ...
   test for positive case ]

If any of the tests fail, then 'have_systemd=no'
is the option passed along.

I don't _think_ Ted is asking for for the default to be
changed, as the subject of his note states it is
to fix the "--without-systemd" case, but a
fix was added for a bug that wasn't present,
so I don't think he knowingly did what he
intended to do.









