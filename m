Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C13819728F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 04:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgC3ChS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 22:37:18 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:56806 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbgC3ChS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:37:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7D4E8180A8CA9;
        Mon, 30 Mar 2020 02:37:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2561:2564:2682:2685:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7903:8985:9025:9121:10004:10400:11233:11658:11914:12043:12297:12555:12663:12679:12760:12986:13069:13161:13229:13311:13357:13439:13868:14096:14097:14181:14659:14721:21080:21451:21627:21740:21749:21811:21987:30054:30056:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: event23_79c1558705c46
X-Filterd-Recvd-Size: 1860
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Mar 2020 02:37:16 +0000 (UTC)
Message-ID: <f53fdf2283e1c847a4c44ea7bea4cb6600c06991.camel@perches.com>
Subject: re: commit  23cb8490c0d3 ("MAINTAINERS: fix bad file pattern")
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 29 Mar 2020 19:35:22 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   MAINTAINERS: fix bad file pattern
    
    Testing 'parse-maintainers' due to the previous commit shows a bad file
    pattern for the "TI VPE/CAL DRIVERS" entry in the MAINTAINERS file.
    
    There's also a lot of mis-ordered entries, but I'm still a bit nervous
    about the inevitable and annoying merge problems it would probably cause
    to fix them up.
    
    The MAINTAINERS file is one of my least favorite files due to being huge
    and centralized, but fixing it is also horribly painful for that reason.

The identical commit was sent at least twice.
Once directly to you.

https://patchwork.kernel.org/patch/11361131/
https://lore.kernel.org/linux-media/20200128145828.74161-1-andriy.shevchenko@linux.intel.com/


About the pain associated to fixing the file:
I think it would be minimally painful to run

$ ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order

Immediately before an -rc1 is released.

Relatively few of any pending patches to MAINTAINERS
in -next would be impacted and there would be better
consistency in the silly file.


