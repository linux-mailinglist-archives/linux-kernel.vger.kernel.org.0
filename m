Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3FAE89C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 14:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbfJ2NlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 09:41:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:52514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388853AbfJ2NlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:41:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84601B201;
        Tue, 29 Oct 2019 13:41:08 +0000 (UTC)
Date:   Tue, 29 Oct 2019 14:41:07 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC v2] mm: add page preemption
Message-ID: <20191029134107.GN31513@dhcp22.suse.cz>
References: <20191029123058.19060-1-hdanton@sina.com>
 <2586aa78-9120-cd33-7f02-2542b74a64a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2586aa78-9120-cd33-7f02-2542b74a64a4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29-10-19 14:26:36, David Hildenbrand wrote:
[...]
> Side note: You should really have a look what your mail client is messing up
> here. E.g., the reply from Michal correctly had
> 
> Message-ID: <20191029084153.GD31513@dhcp22.suse.cz>
> References: <20191026112808.14268-1-hdanton@sina.com>
> In-Reply-To: <20191026112808.14268-1-hdanton@sina.com>
> 
> Once you reply to that, you have
> 
> Message-Id: <20191029123058.19060-1-hdanton@sina.com>
> In-Reply-To: <20191026112808.14268-1-hdanton@sina.com>
> References:
> 
> Instead of
> 
> Message-Id: <20191029123058.19060-1-hdanton@sina.com>
> In-Reply-To: <20191029084153.GD31513@dhcp22.suse.cz>
> References: <20191029084153.GD31513@dhcp22.suse.cz>
> 
> Which flattens the whole thread hierarchy. Nasty. Please fix that.

This is not for the first time. It's been like that for a longer time
and several people have noted that before.
-- 
Michal Hocko
SUSE Labs
