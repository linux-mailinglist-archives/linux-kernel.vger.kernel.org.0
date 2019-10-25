Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C99E4700
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 11:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438466AbfJYJV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 05:21:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438394AbfJYJVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:21:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F29F3B553;
        Fri, 25 Oct 2019 09:21:43 +0000 (UTC)
Date:   Fri, 25 Oct 2019 11:21:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Robert Stupp <snazy@snazy.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191025092143.GE658@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
 <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-10-19 16:34:46, Randy Dunlap wrote:
> [adding linux-mm + people]
> 
> I see only one change in the last 4 years:
> 
> commit dedca63504a204dc8410d98883fdc16dffa8cb80
> Author: Potyra, Stefan <Stefan.Potyra@elektrobit.com>
> Date:   Thu Jun 13 15:55:55 2019 -0700
> 
>     mm/mlock.c: mlockall error for flag MCL_ONFAULT
> 
> 
> On 10/24/19 12:36 AM, Robert Stupp wrote:
> > Hi guys,
> > 
> > I've got an issue with `mlockall(MCL_CURRENT)` after upgrading Ubuntu 19.04 to 19.10 - i.e. kernel version change from 5.0.x to 5.3.x.
> > 
> > The following simple program hangs forever with one CPU running at 100% (kernel):

Can you capture everal snapshots of proc/$(pidof $YOURTASK)/stack while
this is happening?
-- 
Michal Hocko
SUSE Labs
