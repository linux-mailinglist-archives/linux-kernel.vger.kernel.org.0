Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538747D595
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 08:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfHAGiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 02:38:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:43068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfHAGiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:38:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 531F4AD1E;
        Thu,  1 Aug 2019 06:38:17 +0000 (UTC)
Date:   Thu, 1 Aug 2019 08:38:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190801063814.GC11627@dhcp22.suse.cz>
References: <20190731161151.26ef081e@canb.auug.org.au>
 <1564554484.28000.3.camel@mtkswgap22>
 <20190801155130.29a07b1b@canb.auug.org.au>
 <20190801061527.GB11627@dhcp22.suse.cz>
 <1564641003.25219.7.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564641003.25219.7.camel@mtkswgap22>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-08-19 14:30:03, Miles Chen wrote:
[...]
> It's the first time that I receive a build warning after the patch has
> been merged to -mm tree. The build warning had been fixed by Qian,
> should I send another change for this?
 
No need. Andrew has already picked up the fix for mmotm tree and it
should show up in linux-next soon.

Thanks!
-- 
Michal Hocko
SUSE Labs
