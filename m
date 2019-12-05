Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7626114164
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 14:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfLENUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 08:20:16 -0500
Received: from foss.arm.com ([217.140.110.172]:34108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729402AbfLENUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:20:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E46E31B;
        Thu,  5 Dec 2019 05:20:15 -0800 (PST)
Received: from arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBB323F68E;
        Thu,  5 Dec 2019 05:20:14 -0800 (PST)
Date:   Thu, 5 Dec 2019 13:20:10 +0000
From:   Steven Price <steven.price@arm.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next 20191204: crash in mm/pagewalk.c
Message-ID: <20191205132009.GA48492@arm.com>
References: <4587.1575548582@turing-police>
 <20191205123025.GA46328@arm.com>
 <7712.1575551749@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7712.1575551749@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 01:15:49PM +0000, Valdis Klētnieks wrote:
> On Thu, 05 Dec 2019 12:30:26 +0000, Steven Price said:
> > On Thu, Dec 05, 2019 at 12:23:02PM +0000, Valdis Kl??tnieks wrote:
> > > linux-next 20191204 dies a horrid death on my laptop while booting:
> >
> > This is due to an unfortunate conflict between my series reworking of
> > the page walk infrastructure to reuse it for kernel walks and a commit
> > by Thomas Hellstrom to allow safe modification of entries in the
> > callback. See [1] for more detail.
> >
> > I believe Andrew has dropped my series for now while I rework it to fix
> > this conflict.
> 
> Thanks for the prompt response - I'll try again with today's -next if the series
> has dropped out...

The series is still in next-20191205 - but Andrew has sent me emails
saying the patch is dropped. I'm not sure how long it takes for -next to
reflect the update.

Steve
