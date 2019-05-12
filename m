Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F521AA04
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 04:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfELCeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 22:34:13 -0400
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:39783 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726124AbfELCeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 22:34:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 272FBC1DC93;
        Sun, 12 May 2019 02:34:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1536:1559:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3622:3865:3867:3870:4321:5007:10004:10400:10848:11658:11914:12048:12196:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: cream79_41757a7749e48
X-Filterd-Recvd-Size: 1278
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun, 12 May 2019 02:34:09 +0000 (UTC)
Message-ID: <1e6ec2fac918b4dcad2c8579970f2fea664c5474.camel@perches.com>
Subject: Re: [PATCH 02/18] soc: qcom: create "include/soc/qcom/rmnet.h"
From:   Joe Perches <joe@perches.com>
To:     Alex Elder <elder@linaro.org>, davem@davemloft.net, arnd@arndb.de,
        bjorn.andersson@linaro.org, ilias.apalodimas@linaro.org,
        subashab@codeaurora.org, stranche@codeaurora.org,
        yuehaibing@huawei.com
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org
Date:   Sat, 11 May 2019 19:34:08 -0700
In-Reply-To: <20190512012508.10608-3-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
         <20190512012508.10608-3-elder@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-11 at 20:24 -0500, Alex Elder wrote:
>  include/soc/qcom/rmnet.h

Should this file be added to the MAINTAINERS file
update in patch 16/18 ?

