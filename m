Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F9CBD9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 16:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389154AbfJDOn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 10:43:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388724AbfJDOn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:43:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C2E2AC69;
        Fri,  4 Oct 2019 14:43:25 +0000 (UTC)
Date:   Fri, 4 Oct 2019 16:43:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, Qian Cai <cai@lca.pw>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] Make SPLIT_RSS_COUNTING configurable
Message-ID: <20191004144325.GP9578@dhcp22.suse.cz>
References: <CAKOZuesMoBj-APjCipJmWcAgSzkbD1mvyOp0UvHLnkwR-EU4Ww@mail.gmail.com>
 <1C584B5C-E04E-4B04-A3B5-4DC8E5E67366@lca.pw>
 <CAKOZuesKY_=qkSXfmDO_1ALaqQtU0kz5Z+fBh05c8BR7oCDxKw@mail.gmail.com>
 <20191004123349.GB10845@dhcp22.suse.cz>
 <20191004132624.ctaodxaxsd7wzwlh@box>
 <CAKOZuesqgEBSNvpsdw1QhVvYBNBUjAL0pu1x_b-C5q22Z7BZ4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesqgEBSNvpsdw1QhVvYBNBUjAL0pu1x_b-C5q22Z7BZ4g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 06:45:21, Daniel Colascione wrote:
[...]
> Nobody has demonstrated that split RSS accounting actually helps in
> the real world. But I've described above, concretely, how split RSS
> accounting hurts. I've been trying for over a year to either disable
> split RSS accounting or to let people opt out of it. If you won't
> remove split RSS accounting and you won't let me add a configuration
> knob that lets people opt out of it, what will you accept?

What is an argument to keep it around?

-- 
Michal Hocko
SUSE Labs
