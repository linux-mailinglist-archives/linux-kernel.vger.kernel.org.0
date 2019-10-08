Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E83ECF3E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfJHHbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 03:31:46 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:32808 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729740AbfJHHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:31:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 409DA180A68B8;
        Tue,  8 Oct 2019 07:31:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3872:4184:4321:5007:10004:10400:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14180:14181:14659:21060:21080:21611:21627:21974:30054:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: bait88_839f77442f42d
X-Filterd-Recvd-Size: 978
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Oct 2019 07:31:44 +0000 (UTC)
Message-ID: <aadb19c32e7d6b2560d257b459920da9e935c5e8.camel@perches.com>
Subject: Re: checkpatch error
From:   Joe Perches <joe@perches.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     apw@canonical.com
Date:   Tue, 08 Oct 2019 00:31:43 -0700
In-Reply-To: <02cc0e89-8b48-14f6-aabe-ec1201df59aa@oracle.com>
References: <02cc0e89-8b48-14f6-aabe-ec1201df59aa@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 12:02 +0800, Zhenzhong Duan wrote:
> Hi,
> 
> When I run checkpatch.pl with a patch doing reverting operation, it 
> reports a false positive error, Should I ignore the error or it's a bug?

Ignore it.


