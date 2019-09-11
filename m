Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF3B04E2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 22:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfIKUa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 16:30:57 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:52594 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728808AbfIKUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 16:30:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E1B2718025E8E;
        Wed, 11 Sep 2019 20:30:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2689:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:4321:4605:5007:6119:7774:10004:10400:10562:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13184:13229:13255:13311:13357:13439:14181:14659:14721:21080:21324:21451:21627:30054:30064:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:31,LUA_SUMMARY:none
X-HE-Tag: paste13_7c63038856825
X-Filterd-Recvd-Size: 1990
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Sep 2019 20:30:54 +0000 (UTC)
Message-ID: <37a9f105f85b7accb5eefe788f8d129e9fddaa2c.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org
Date:   Wed, 11 Sep 2019 13:30:53 -0700
In-Reply-To: <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
         <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-11 at 08:48 -0700, Dan Williams wrote:
> Document the basic policies of the libnvdimm subsystem and provide a first
> example of a Maintainer Entry Profile for others to duplicate and edit.
[]
> +Coding Style Addendum
> +---------------------
> +libnvdimm expects multi-line statements to be double indented. I.e.
> +
> +        if (x...
> +                        && ...y) {

I don't find a good reason to do this.

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -9185,6 +9185,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>  M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Dave Jiang <dave.jiang@intel.com>
>  L:	linux-nvdimm@lists.01.org
> +P:	Documentation/nvdimm/maintainer-entry-profile.rst

I also think the indirection to a separate
file is not a good thing.

Separate styles for individual subsystems is
not something I would want to encourage.

