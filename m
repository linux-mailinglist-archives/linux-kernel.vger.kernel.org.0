Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7A248EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 09:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfEUHY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 03:24:58 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:56221 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbfEUHY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:24:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C7C8C837F24C;
        Tue, 21 May 2019 07:24:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:421:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1533:1534:1536:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3867:4321:5007:6120:6642:7901:10004:10400:10848:11658:11914:12043:12048:12196:12740:12760:12895:13069:13311:13357:13439:14181:14659:21080:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: rail78_481f05a1cd332
X-Filterd-Recvd-Size: 1175
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 May 2019 07:24:55 +0000 (UTC)
Message-ID: <a18a87a4ef54168148f0d278601782f5f6442830.camel@perches.com>
Subject: Re: [PATCH] powerpc/mm: mark more tlb functions as __always_inline
From:   Joe Perches <joe@perches.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Date:   Tue, 21 May 2019 00:24:54 -0700
In-Reply-To: <16d967dd-9f8f-4e9e-97fd-3f9761e5d97c@c-s.fr>
References: <20190521061659.6073-1-yamada.masahiro@socionext.com>
         <16d967dd-9f8f-4e9e-97fd-3f9761e5d97c@c-s.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-21 at 08:53 +0200, Christophe Leroy wrote:
> powerpc accepts lines up to 90 chars, see arch/powerpc/tools/checkpatch.pl

arch/powerpc/tools/checkpatch.sh


