Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0226327
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 13:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfEVLsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 07:48:37 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:45688 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727464AbfEVLsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:48:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4038A100E86C0;
        Wed, 22 May 2019 11:48:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3873:4321:5007:7903:8957:10004:10400:10848:11232:11658:11914:12043:12663:12740:12760:12895:13069:13095:13311:13357:13439:14659:14721:21080:21212:21433:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:35,LUA_SUMMARY:none
X-HE-Tag: spoon28_6812e54d5f51b
X-Filterd-Recvd-Size: 1441
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 May 2019 11:48:35 +0000 (UTC)
Message-ID: <7e2a727333d1d764ae3c0099e050a0521e87d9d8.camel@perches.com>
Subject: Re: [PATCH] message/fusion/mptbase.c: Use kmemdup instead of memcpy
 and kmalloc
From:   Joe Perches <joe@perches.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>,
        sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 May 2019 04:48:33 -0700
In-Reply-To: <20190522095335.GA3212@bharath12345-Inspiron-5559>
References: <20190522095335.GA3212@bharath12345-Inspiron-5559>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-22 at 15:23 +0530, Bharath Vedartham wrote:
> Replace kmalloc + memcpy with kmemdup.
> This was reported by coccinelle.
[]
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
[]
> @@ -6001,13 +6001,12 @@ mpt_findImVolumes(MPT_ADAPTER *ioc)
>  	if (mpt_config(ioc, &cfg) != 0)
>  		goto out;
>  
> -	mem = kmalloc(iocpage2sz, GFP_KERNEL);
> +	mem = kmemdup((u8 *)pIoc2, iocpage2sz, GFP_KERNEL);

You should remove the unnecessary cast here.


