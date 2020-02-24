Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322BC16A817
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 15:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgBXOPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 09:15:03 -0500
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:38336 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727489AbgBXOPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:15:03 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 070C1837F27E;
        Mon, 24 Feb 2020 14:15:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3867:3870:3871:3872:3874:4321:4823:5007:6119:7903:10004:10400:10848:11658:11914:12043:12048:12296:12297:12438:12740:12760:12895:13018:13019:13161:13229:13439:14096:14097:14181:14659:21080:21212:21451:21611:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: owner35_6600d9892995f
X-Filterd-Recvd-Size: 4636
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Feb 2020 14:15:00 +0000 (UTC)
Message-ID: <8c458c189abb45fb3021f7882a40d28a24cc662d.camel@perches.com>
Subject: Re: [PATCH] staging: wfx: match parentheses alignment
From:   Joe Perches <joe@perches.com>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Feb 2020 06:13:32 -0800
In-Reply-To: <20200223193201.GA20843@kaaira-HP-Pavilion-Notebook>
References: <20200223193201.GA20843@kaaira-HP-Pavilion-Notebook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-24 at 01:02 +0530, Kaaira Gupta wrote:
> match next line with open parentheses by giving appropriate tabs.

This patch is only for data_tx.c

There are many more parentheses that are not aligned
in staging/wfx in other files.

Realistically, either change the subject to show
that it's only for data_tx or do them all.

(but not traces.h, those use a different style)

$ ./scripts/checkpatch.pl -f --terse --nosummary --types=parenthesis_alignment drivers/staging/wfx/*.[ch]
drivers/staging/wfx/data_tx.c:303: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/data_tx.c:371: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/debug.c:35: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:35: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:45: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:55: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:72: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:97: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:106: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:118: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:133: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:147: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/queue.c:393: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/queue.c:408: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/queue.c:433: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/sta.c:123: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/sta.c:235: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/sta.c:291: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/sta.c:340: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/sta.c:717: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:156: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:194: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:206: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:211: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:234: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:257: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:265: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:271: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:278: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:296: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:302: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:307: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:313: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:324: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:329: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:334: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:351: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:362: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:416: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:418: CHECK: Alignment should match open parenthesis




