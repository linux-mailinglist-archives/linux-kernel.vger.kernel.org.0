Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A431F98B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfEORqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 13:46:30 -0400
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:58377 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726466AbfEORqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:46:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 018FE181D3368;
        Wed, 15 May 2019 17:46:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:988:989:1042:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:4250:4321:5007:6691:10004:10400:10848:11232:11658:11914:12555:12663:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: glass02_3861a3593ad33
X-Filterd-Recvd-Size: 1537
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 May 2019 17:46:27 +0000 (UTC)
Message-ID: <611968bf390bd6ab669ba7311eb06a1977f74ab3.camel@perches.com>
Subject: Re: [PATCH] staging: Add rtl8821ce PCIe WiFi driver
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
Date:   Wed, 15 May 2019 10:46:26 -0700
In-Reply-To: <20190515163945.GA5719@kroah.com>
References: <20190515112401.15373-1-kai.heng.feng@canonical.com>
         <20190515114022.GA18824@kroah.com>
         <6D5557B8-8140-48A8-BED7-9587936902D8@canonical.com>
         <20190515123319.GA435@kroah.com>
         <63833AA2-AC8B-4EEA-AF36-EF2A9BFD4F9F@canonical.com>
         <20190515163945.GA5719@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 18:39 +0200, Greg KH wrote:
> On Wed, May 15, 2019 at 09:06:44PM +0800, Kai-Heng Feng wrote:
> > 296 files changed, 206166 insertions(+)
> I'm not going to take another 200k lines for a simple wifi driver.

Good.

Realtek _really_ needs to improve the driver software.


