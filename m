Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680A914D4F3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 02:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgA3BWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 20:22:15 -0500
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:49140 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726618AbgA3BWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 20:22:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 04DC9100E7B42;
        Thu, 30 Jan 2020 01:22:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3870:3871:3872:4250:4321:5007:6117:7901:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: tank25_3070df626a919
X-Filterd-Recvd-Size: 1170
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Jan 2020 01:22:12 +0000 (UTC)
Message-ID: <14c4cd0d74d9de88f8cf16bad8910f1273a46a47.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check SPDX tags in YAML files
From:   Joe Perches <joe@perches.com>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Jan 2020 17:21:05 -0800
In-Reply-To: <20200129123356.388669-1-lkundrak@v3.sk>
References: <20200129123356.388669-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-29 at 13:33 +0100, Lubomir Rintel wrote:
> This adds a warning when a YAML file is lacking a SPDX header on first
> line, or it uses incorrect commenting style.
> 
> Currently the only YAML files in three are Devicetree binding documents.

three/tree typo?

Otherwise, looks fine.

