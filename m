Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6FFE4A71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 13:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502352AbfJYLul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 07:50:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:43694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfJYLul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:50:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77D88B49A;
        Fri, 25 Oct 2019 11:50:39 +0000 (UTC)
Date:   Fri, 25 Oct 2019 13:50:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191025115038.GF17610@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
 <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
 <20191025092143.GE658@dhcp22.suse.cz>
 <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
 <20191025114633.GE17610@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025114633.GE17610@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-10-19 13:46:33, Michal Hocko wrote:
> On Fri 25-10-19 13:02:23, Robert Stupp wrote:
> > On Fri, 2019-10-25 at 11:21 +0200, Michal Hocko wrote:
> > > On Thu 24-10-19 16:34:46, Randy Dunlap wrote:
> > > > [adding linux-mm + people]
> > > >
> > > > On 10/24/19 12:36 AM, Robert Stupp wrote:
> > > > > Hi guys,
> > > > >
> > > > > I've got an issue with `mlockall(MCL_CURRENT)` after upgrading
> > > > > Ubuntu 19.04 to 19.10 - i.e. kernel version change from 5.0.x to
> > > > > 5.3.x.
> > > > >
> > > > > The following simple program hangs forever with one CPU running
> > > > > at 100% (kernel):
> > >
> > > Can you capture everal snapshots of proc/$(pidof $YOURTASK)/stack
> > > while
> > > this is happening?

Btw. I have tested
$ cat test_mlockall.c
#include <stdio.h>
#include <sys/mman.h>
int main(char** argv) {
	printf("Before mlockall(MCL_CURRENT|MCL_FUTURE)\n");
	// works in 5.0
	// hangs forever w/ 5.1 and newer
	int e = mlockall(MCL_CURRENT|MCL_FUTURE);
	printf("After mlockall(MCL_CURRENT|MCL_FUTURE) %d\n", e);
}

$./test_mlockall
Before mlockall(MCL_CURRENT|MCL_FUTURE)
After mlockall(MCL_CURRENT|MCL_FUTURE) 0
-- 
Michal Hocko
SUSE Labs
