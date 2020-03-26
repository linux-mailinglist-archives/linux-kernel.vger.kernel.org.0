Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3490E1934D2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 01:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCZADw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 20:03:52 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:45848 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727420AbgCZADv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:03:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8B54A249C;
        Thu, 26 Mar 2020 00:03:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2197:2199:2282:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3872:3874:4321:4605:5007:6119:7903:8660:9121:10004:10400:10848:11232:11658:11914:12048:12297:12555:12740:12760:12895:12986:13069:13148:13230:13311:13357:13439:13870:14581:14659:21080:21212:21221:21433:21451:21611:21627:21939:21990:30034:30041:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: scent12_42e45f963938
X-Filterd-Recvd-Size: 1862
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Mar 2020 00:03:48 +0000 (UTC)
Message-ID: <f97d9dc54178e4344512bc7986265f101f4639c6.camel@perches.com>
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
From:   Joe Perches <joe@perches.com>
To:     Jiri Slaby <jslaby@suse.cz>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 25 Mar 2020 17:01:57 -0700
In-Reply-To: <ec061c30-eace-1df9-fa7b-71a61e5710a2@suse.cz>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
         <20200324170407.16470-3-arnaud.pouliquen@st.com>
         <e458f805-c746-c88e-98f4-d874a7552933@suse.cz>
         <1e4ce821-dd9b-bb04-774b-58a255834cf5@st.com>
         <ec061c30-eace-1df9-fa7b-71a61e5710a2@suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-25 at 14:31 +0100, Jiri Slaby wrote:
> The question was exactly about that: can a compiler optimize it to a
> bare number or will strlen call remain there?

$ cat str.c
#include <string.h>

int foo(void)
{
	return strlen("abc");
}

$ gcc -c -O2 str.c
$ objdump -d str.o
str.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <foo>:
   0:	f3 0f 1e fa          	endbr64 
   4:	b8 03 00 00 00       	mov    $0x3,%eax
   9:	c3                   	retq   


