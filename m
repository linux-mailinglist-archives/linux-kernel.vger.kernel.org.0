Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B891520
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfHRGtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 02:49:03 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:53337 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725290AbfHRGtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 02:49:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E48AA1800B863;
        Sun, 18 Aug 2019 06:49:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1536:1559:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3867:3868:3872:4321:5007:8784:10004:10400:10848:11232:11658:11914:12196:12296:12297:12740:12760:12895:13019:13069:13311:13357:13439:14659:14721:21060:21080:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: board99_88e9ef4a09a19
X-Filterd-Recvd-Size: 1000
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 18 Aug 2019 06:49:00 +0000 (UTC)
Message-ID: <c3f3f8394a018bab44081b00563ab3aa4b1aca22.camel@perches.com>
Subject: Re: [PATCH] toshiba: Add correct printk log level while emitting
 error log
From:   Joe Perches <joe@perches.com>
To:     Rishi Gupta <gupt21@gmail.com>, jonathan@buzzard.org.uk
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 17 Aug 2019 23:48:59 -0700
In-Reply-To: <1566110368-30133-1-git-send-email-gupt21@gmail.com>
References: <1566110368-30133-1-git-send-email-gupt21@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-08-18 at 12:09 +0530, Rishi Gupta wrote:
> TOSH_DEBUG

Perhaps better to remove it altogether and just use pr_debug.



