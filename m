Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF6E018AA86
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 03:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgCSCAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 22:00:19 -0400
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:53368 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726596AbgCSCAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 22:00:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 00188100E7B40;
        Thu, 19 Mar 2020 02:00:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:4321:5007:6119:7903:8957:10004:10400:10848:11232:11658:11914:12048:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:21080:21433:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: straw74_1f78e6f50a94d
X-Filterd-Recvd-Size: 1205
Received: from XPS-9350 (unknown [172.58.27.183])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 19 Mar 2020 02:00:16 +0000 (UTC)
Message-ID: <bb163d6b706a7b07e8b2e1c51b0da72a5923af97.camel@perches.com>
Subject: Re: [PATCH v2] staging: rtl8192u: Corrects 'Avoid CamelCase' for
 variables
From:   Joe Perches <joe@perches.com>
To:     Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Date:   Wed, 18 Mar 2020 18:58:24 -0700
In-Reply-To: <20200318211205.188-1-c.cantanheide@gmail.com>
References: <20200318211205.188-1-c.cantanheide@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-18 at 21:12 +0000, Camylla Goncalves Cantanheide wrote:
> The variables of function setKey triggered a 'Avoid CamelCase'
> warning from checkpatch.pl. This patch renames these
> variables to correct this warning.

Please always try to improve the code for humans to read
over correcting mindless checkpatch messages.


