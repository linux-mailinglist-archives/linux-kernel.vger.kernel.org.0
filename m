Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D77C2D77F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 16:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbfJOOFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 10:05:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:38310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732292AbfJOOFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:05:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88132AFBB;
        Tue, 15 Oct 2019 14:05:09 +0000 (UTC)
Date:   Tue, 15 Oct 2019 16:05:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Guilherme G. Piccoli" <guilherme@gpiccoli.net>
Cc:     Guilherme Piccoli <gpiccoli@canonical.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages
 creation
Message-ID: <20191015140508.GJ317@dhcp22.suse.cz>
References: <CAHD1Q_ynd6f2Jc54k1D9JjmtD6tGhkDcAHRzd5nZt5LUdQTvaw@mail.gmail.com>
 <4641B95A-6DD8-4E8A-AD53-06E7B72D956C@lca.pw>
 <CAHD1Q_x+m0ZT_xfLV3j6ma3Cc88fk9KnoS4yytS=PHBvJN7nnQ@mail.gmail.com>
 <20191015121803.GB24932@dhcp22.suse.cz>
 <b6617b4b-bcab-3b40-7d46-46a5d9682856@gpiccoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6617b4b-bcab-3b40-7d46-46a5d9682856@gpiccoli.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-10-19 10:58:36, Guilherme G. Piccoli wrote:
> On 10/15/19 9:18 AM, Michal Hocko wrote:
> > I do agree with Qian Cai here. Kdump kernel requires a very tailored
> > environment considering it is running in a very restricted
> > configuration. The hugetlb pre-allocation sounds like a tooling problem
> > and should be fixed at that layer.
> > 
> 
> Hi Michal, thanks for your response. Can you suggest me a current way of
> preventing hugepages for being created, using userspace? The goal for this
> patch is exactly this, introduce such a way.

Simply restrict the environment to not allocate any hugepages? Kdump
already controls the kernel command line and it also starts only a very
minimal subset of services. So who is allocating those hugepages?
sysctls should be already excluded by default as Qian mentioned.
-- 
Michal Hocko
SUSE Labs
