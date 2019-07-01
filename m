Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7893A24CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 12:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfEUKeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 06:34:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbfEUKeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:34:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D287ABF4;
        Tue, 21 May 2019 10:34:34 +0000 (UTC)
Date:   Tue, 21 May 2019 12:34:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190521103433.GL32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <dbe801f0-4bbe-5f6e-9053-4b7deb38e235@arm.com>
 <CAEe=Sxka3Q3vX+7aWUJGKicM+a9Px0rrusyL+5bB1w4ywF6N4Q@mail.gmail.com>
 <1754d0ef-6756-d88b-f728-17b1fe5d5b07@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1754d0ef-6756-d88b-f728-17b1fe5d5b07@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-05-19 08:25:55, Anshuman Khandual wrote:
> On 05/20/2019 10:29 PM, Tim Murray wrote:
[...]
> > not seem to introduce a noticeable hot start penalty, not does it
> > cause an increase in performance problems later in the app's
> > lifecycle. I've measured with and without process_madvise, and the
> > differences are within our noise bounds. Second, because we're not
> 
> That is assuming that post process_madvise() working set for the application is
> always smaller. There is another challenge. The external process should ideally
> have the knowledge of active areas of the working set for an application in
> question for it to invoke process_madvise() correctly to prevent such scenarios.

But that doesn't really seem relevant for the API itself, right? The
higher level logic the monitor's business.
-- 
Michal Hocko
SUSE Labs
