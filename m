Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76365BC784
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 14:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504862AbfIXMEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 08:04:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:41768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439102AbfIXMEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:04:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0E30ACC3;
        Tue, 24 Sep 2019 12:04:00 +0000 (UTC)
Date:   Tue, 24 Sep 2019 14:04:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab, memcontrol: undefined reference to
 `memcg_kmem_get_cache'
Message-ID: <20190924120400.GN23050@dhcp22.suse.cz>
References: <DB7PR02MB397977A2959BFFA89AA67538BB840@DB7PR02MB3979.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR02MB397977A2959BFFA89AA67538BB840@DB7PR02MB3979.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 24-09-19 08:46:48, Mircea CIRJALIU - MELIU wrote:
> Having CONFIG_MEMCG turned off causes these issues:
> 	mm/slub.o: In function `slab_pre_alloc_hook':
> 	/home/mircea/build/mm/slab.h:425: undefined reference to `memcg_kmem_get_cache'
> 	mm/slub.o: In function `slab_post_alloc_hook':
> 	/home/mircea/build/mm/slab.h:444: undefined reference to `memcg_kmem_put_cache'

You should be adding your Sign-off-by to every patch you post to the
kernel mailing list (see Documentation/SubmittingPatches).

It is also really important to mention which tree does this apply to and
ideally also note which change has broken the code. In this particular
case I have tried the current Linus tree (4c07e2ddab5b) and
$ grep 'CONFIG_SLUB\|CONFIG_MEMCG' .config
# CONFIG_MEMCG is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB=y
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set

which means CONFIG_MEMCG_KMEM is not enabled as well. And the
compilation succeeds. What is your config file?
-- 
Michal Hocko
SUSE Labs
