Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 090166E2E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 10:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfGSIuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 04:50:54 -0400
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:33174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbfGSIux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:50:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 35D7E802F978;
        Fri, 19 Jul 2019 08:50:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3870:3871:3873:4250:4321:4605:5007:6117:7809:7903:9010:10004:10400:10483:10848:11232:11658:11914:12043:12296:12297:12663:12681:12740:12760:12895:13161:13229:13439:13618:14096:14097:14180:14181:14659:14721:19901:19997:21060:21080:21433:21451:21627:21819:30046:30054:30085:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: mass79_24896e85a7d44
X-Filterd-Recvd-Size: 4684
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jul 2019 08:50:50 +0000 (UTC)
Message-ID: <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
Subject: Re: get_maintainers.pl subsystem output
From:   Joe Perches <joe@perches.com>
To:     "Duda, Sebastian" <sebastian.duda@fau.de>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        ralf.ramsauer@oth-regensburg.de, wolfgang.mauerer@oth-regensburg.de
Date:   Fri, 19 Jul 2019 01:50:44 -0700
In-Reply-To: <2c912379f96f502080bfcc79884cdc35@fau.de>
References: <2c912379f96f502080bfcc79884cdc35@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-19 at 07:35 +0000, Duda, Sebastian wrote:
> Hi Joe,
> 
> I'm conducting a large-scale patch analysis of the LKML with 1.8 million 
> patch emails. I'm using the `get_maintainer.pl` script to know which 
> patch is related to which subsystem.

The MAINTAINERS file is updated frequently.

Are you also using the MAINTAINERS file used
at the time each patch was submitted?

> I ran into two issues while using the script:
> 
> 1. When I use the script the trivial way
> 
>      $ scripts/get_maintainer.pl --subsystem --status --separator , 
> drivers/media/i2c/adv748x/
>      Kieran Bingham <kieran.bingham@ideasonboard.com> (maintainer:ANALOG 
> DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org> 
> (maintainer:MEDIA INPUT INFRASTRUCTURE 
> (V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC 
> ADV748X DRIVER),linux-kernel@vger.kernel.org (open list)
>      Maintained,Buried alive in reporters
>      ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE 
> (V4L/DVB),THE REST
> 
> the output is hard to parse because the status `Maintained` is displayed 
> only once but related to two subsystems.
> 
> I'd prefer a more table like representation, like this:
> 
>      Kieran Bingham <kieran.bingham@ideasonboard.com> (maintainer:ANALOG 
> DEVICES INC ADV748X DRIVER),linux-media@vger.kernel.org (open 
> list:ANALOG DEVICES INC ADV748X DRIVER),ANALOG DEVICES INC ADV748X 
> DRIVER,Maintained
>      Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA INPUT 
> INFRASTRUCTURE (V4L/DVB)),MEDIA INPUT INFRASTRUCTURE 
> (V4L/DVB),Maintained
>      linux-kernel@vger.kernel.org (open list),THE REST,Buried alive in 
> reporters
> 
> 
> 2. I want to analyze multiple patches, currently I am calling the script 
> once per patch. When calling the script with multiple files the files 
> output is merged
> 
>      $ scripts/get_maintainer.pl --subsystem --status --separator ',' 
> drivers/media/i2c/adv748x/ include/uapi/linux/wmi.h
>      Kieran Bingham <kieran.bingham@ideasonboard.com> (maintainer:ANALOG 
> DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org> 
> (maintainer:MEDIA INPUT INFRASTRUCTURE 
> (V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC 
> ADV748X DRIVER),linux-kernel@vger.kernel.org (open 
> list),platform-driver-x86@vger.kernel.org (open list:ACPI WMI DRIVER)
>      Maintained,Buried alive in reporters,Orphan
>      ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE 
> (V4L/DVB),THE REST,ACPI WMI DRIVER
> 
> I'd like to run the script with all files but separated output, like 
> this:
> 
>      $ scripts/get_maintainer.pl --subsystem --status --separator ',' 
> --separate-files drivers/media/i2c/adv748x/ include/uapi/linux/wmi.h
>      Kieran Bingham <kieran.bingham@ideasonboard.com> (maintainer:ANALOG 
> DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org> 
> (maintainer:MEDIA INPUT INFRASTRUCTURE 
> (V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC 
> ADV748X DRIVER),linux-kernel@vger.kernel.org (open list)
>      Maintained,Buried alive in reporters
>      ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE 
> (V4L/DVB),THE REST
> 
>      platform-driver-x86@vger.kernel.org (open list:ACPI WMI 
> DRIVER),linux-kernel@vger.kernel.org (open list)
>      Orphan,Buried alive in reporters
>      ACPI WMI DRIVER,THE REST
> 
> 
> My Questions are:
> 1. How can I make get_maintainer's output to be more table-like?

I suggest adding --nogit --nogit-fallback --roles --norolestats

> 2. How can I make get_maintainer.pl to separate each file's output?

Run the script with multiple invocations. once for each file
modified by the patch.


