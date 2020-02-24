Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FCA169DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 06:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgBXF1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 00:27:09 -0500
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:57106 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725535AbgBXF1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 00:27:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id BF725100E7B42;
        Mon, 24 Feb 2020 05:27:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1559:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3590:3622:3865:3867:4321:5007:8957:10004:10400:10848:11658:11914:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:21080:21611:21627:30029:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: cave85_3be75cfac61e
X-Filterd-Recvd-Size: 1078
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Feb 2020 05:27:05 +0000 (UTC)
Message-ID: <5fb70429b277a714be52f2ca3d15fc4e42b870d9.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8723bs: remove temporary variable CrystalCap
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 23 Feb 2020 21:25:37 -0800
In-Reply-To: <20200223151438.415542-1-colin.king@canonical.com>
References: <20200223151438.415542-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-02-23 at 15:14 +0000, Colin King wrote:
> odm_GetDefaultCrytaltalCap

Might change the likely function name typo too

from
	odm_GetDefaultCrytaltalCap
to
	odm_GetDefaultCrystalCap


