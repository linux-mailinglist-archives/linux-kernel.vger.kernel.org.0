Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02566167F63
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 14:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgBUN5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 08:57:24 -0500
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:60343 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728672AbgBUN5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:57:23 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CDB7018224D78;
        Fri, 21 Feb 2020 13:57:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3871:3872:3873:3874:3876:4250:4321:5007:6119:8531:8603:10004:10400:10848:11232:11658:11914:12296:12297:12679:12740:12895:13069:13146:13230:13311:13357:13439:13894:14181:14659:14721:21080:21220:21611:21627:21990,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: noise65_4028b1475993c
X-Filterd-Recvd-Size: 1339
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Feb 2020 13:57:20 +0000 (UTC)
Message-ID: <0f2c5adb37454dacbd57d65ba8743bb6092876ff.camel@perches.com>
Subject: Re: [trivial PATCH] cifs: Use #define in cifs_dbg
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>,
        Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Feb 2020 05:55:56 -0800
In-Reply-To: <87eeuo5a2y.fsf@suse.com>
References: <862518f826b35cd010a2e46f64f6f4cfa0d44582.camel@perches.com>
         <87eeuo5a2y.fsf@suse.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-21 at 14:44 +0100, Aurélien Aptel wrote:
> Joe Perches <joe@perches.com> writes:
> > +			cifs_dbg(VFS, "bogus file nlink value %u\n",
> > +				 fattr->cf_nlink);
> 
> Good catch :)
> I realize that 1 is VFS but this should probably be FYI.

change it as you please.

fyi:

Perhaps commit f2f176b41 ("CIFS: add ONCE flag for cifs_dbg type")
may have increased object size quite a bit as it now tests
an external variable.


