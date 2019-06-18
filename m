Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC349646
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 02:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFRAZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 20:25:21 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:48362 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725829AbfFRAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 20:25:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 29EC41F0A;
        Tue, 18 Jun 2019 00:25:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2828:2897:3138:3139:3140:3141:3142:3352:3622:3870:3876:4250:4321:4605:5007:6742:10004:10400:10848:11026:11232:11658:11914:12043:12296:12438:12740:12760:12895:13069:13311:13357:13439:13972:14181:14659:14721:21080:21627:30054:30064:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: clock60_4b5582c271355
X-Filterd-Recvd-Size: 2222
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Jun 2019 00:25:17 +0000 (UTC)
Message-ID: <547e251d87e307fa4d1e31dfc61b496c152f0905.camel@perches.com>
Subject: Re: [PATCH v5 2/3] mtd: spi-nor: add support to unlock flash device
From:   Joe Perches <joe@perches.com>
To:     Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>
Date:   Mon, 17 Jun 2019 17:25:16 -0700
In-Reply-To: <CAARK3HmFg=v+cMGAykPPpwxDGaSKk5k+Gz4fSHQPQmg-rCjPhQ@mail.gmail.com>
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
         <1560336476-31763-3-git-send-email-sagar.kadam@sifive.com>
         <70732c8e-111f-7c46-9e93-11894d944a1d@ti.com>
         <CAARK3HmFg=v+cMGAykPPpwxDGaSKk5k+Gz4fSHQPQmg-rCjPhQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-17 at 21:10 +0530, Sagar Kadam wrote:
> On Sun, Jun 16, 2019 at 6:35 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
[]
> > > +static int issi_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
> > > +{
[]
> > > +     if (ret > 0 && !(ret & mask)) {
> > > +             dev_info(nor->dev,
> > > +                     "ISSI Block Protection Bits cleared SR=0x%x", ret);

Please use '\n' terminations on formats

> > > +             ret = 0;
> > > +     } else {
> > > +             dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");

like this one

> > > +             ret = -EINVAL;
> > > +     }
> > > +     return ret;
> > > +}
> > > +
> > > +/**
> > >   * spansion_quad_enable() - set QE bit in Configuraiton Register.

s/Configuraiton/Configuration/


