Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1289F869
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 04:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfH1Cr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 22:47:56 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:37391 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726207AbfH1Crz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:47:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8F456182CED28;
        Wed, 28 Aug 2019 02:47:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3867:3868:3870:3872:3874:4321:5007:6119:10004:10400:10848:11026:11232:11658:11914:12043:12114:12297:12438:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30029:30030:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: van62_44cf316c12c5a
X-Filterd-Recvd-Size: 1646
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 28 Aug 2019 02:47:52 +0000 (UTC)
Message-ID: <e8851ba7888c433dac2ffa5d80f3289cd05940a3.camel@perches.com>
Subject: Re: [PATCH v2 00/14] treewide: prefer __section from
 compiler_attributes.h
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Aug 2019 19:47:51 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
References: <20190827204007.201890-1-ndesaulniers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-27 at 13:39 -0700, Nick Desaulniers wrote:
> GCC unescapes escaped string section names while Clang does not. Because
> __section uses the `#` stringification operator for the section name, it
> doesn't need to be escaped.
> 
> This fixes an Oops observed in distro's that use systemd and not
> net.core.bpf_jit_enable=1, when their kernels are compiled with Clang.
> 
> Instead, we should:
> 1. Prefer __section(.section_name_no_quotes).
> 2. Only use __attribute__((__section(".section"))) when creating the

Please use __ before and after section

i.e. __attribute__((__section__("<section_name>")))


