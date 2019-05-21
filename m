Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE124864
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 08:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEUGuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 02:50:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:56762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbfEUGuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:50:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C37FAF70;
        Tue, 21 May 2019 06:50:01 +0000 (UTC)
Date:   Tue, 21 May 2019 08:50:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 4/7] mm: factor out madvise's core functionality
Message-ID: <20190521065000.GH32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-5-minchan@kernel.org>
 <20190520142633.x5d27gk454qruc4o@butterfly.localdomain>
 <20190521012649.GE10039@google.com>
 <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-05-19 08:36:28, Oleksandr Natalenko wrote:
[...]
> Regarding restricting the hints, I'm definitely interested in having
> remote MADV_MERGEABLE/MADV_UNMERGEABLE. But, OTOH, doing it via remote
> madvise() introduces another issue with traversing remote VMAs reliably.
> IIUC, one can do this via userspace by parsing [s]maps file only, which
> is not very consistent, and once some range is parsed, and then it is
> immediately gone, a wrong hint will be sent.
> 
> Isn't this a problem we should worry about?

See http://lkml.kernel.org/r/20190520091829.GY6836@dhcp22.suse.cz

-- 
Michal Hocko
SUSE Labs
