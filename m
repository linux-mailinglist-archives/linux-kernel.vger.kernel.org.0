Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B576D764E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfJOMSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 08:18:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbfJOMSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:18:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02C7CB3C4;
        Tue, 15 Oct 2019 12:18:03 +0000 (UTC)
Date:   Tue, 15 Oct 2019 14:18:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Guilherme Piccoli <gpiccoli@canonical.com>
Cc:     Qian Cai <cai@lca.pw>, linux-mm@kvack.org, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages
 creation
Message-ID: <20191015121803.GB24932@dhcp22.suse.cz>
References: <CAHD1Q_ynd6f2Jc54k1D9JjmtD6tGhkDcAHRzd5nZt5LUdQTvaw@mail.gmail.com>
 <4641B95A-6DD8-4E8A-AD53-06E7B72D956C@lca.pw>
 <CAHD1Q_x+m0ZT_xfLV3j6ma3Cc88fk9KnoS4yytS=PHBvJN7nnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHD1Q_x+m0ZT_xfLV3j6ma3Cc88fk9KnoS4yytS=PHBvJN7nnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-10-19 21:41:01, Guilherme Piccoli wrote:
> On Fri, Oct 11, 2019 at 8:52 PM Qian Cai <cai@lca.pw> wrote:
> >
> >
> > It simply error-prone to reuse the sysctl.conf from the first kernel, as it could contains lots of things that will kill kdump kernel.
> 
> Makes sense, I agree with you. But still, there's no
> formal/right/single way to do kdump, so I don't think we should rely
> on "rootfs kdump is wrong" to refuse this patch's idea. If so, we
> should then formalize the right way of kdumping.
> Of course, this is only my opinion, let's see what people think about it!

I do agree with Qian Cai here. Kdump kernel requires a very tailored
environment considering it is running in a very restricted
configuration. The hugetlb pre-allocation sounds like a tooling problem
and should be fixed at that layer.
-- 
Michal Hocko
SUSE Labs
