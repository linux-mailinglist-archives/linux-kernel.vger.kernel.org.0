Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B5323D0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfFBQRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 12:17:02 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:46926 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbfFBQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:17:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7C1AF100E86C4;
        Sun,  2 Jun 2019 16:17:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3868:3871:4321:5007:7875:10004:10400:10848:11232:11658:11914:12043:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:14827:21080:21212:21433:21611:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: fifth40_1fde44ffb2025
X-Filterd-Recvd-Size: 1610
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun,  2 Jun 2019 16:16:58 +0000 (UTC)
Message-ID: <16f2f9c2e34d59cdf9a7bf0f5111251c284e0a3b.camel@perches.com>
Subject: Re: [PATCH] pci: hotplug: ibmphp: Add white space to Debug Message
From:   Joe Perches <joe@perches.com>
To:     benniciemanuel78@gmail.com, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 02 Jun 2019 09:16:57 -0700
In-Reply-To: <20190602160007.24684-1-benniciemanuel78@gmail.com>
References: <20190602160007.24684-1-benniciemanuel78@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-02 at 18:00 +0200, Emanuel Bennici wrote:
> Add a Whitespace between '-' and 'Exit' to keep the log messages consistent
[]
> diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
[]
> @@ -890,7 +890,7 @@ static int set_bus(struct slot *slot_cur)
>  	/* This is for x440, once Brandon fixes the firmware,
>  	will not need this delay */
>  	msleep(1000);
> -	debug("%s -Exit\n", __func__);
> +	debug("%s - Exit\n", __func__);

These sorts of messages should just be deleted
and the function tracer (ftrace) used instead.


