Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F971A7ACF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 07:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfIDFkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 01:40:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:51398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfIDFkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:40:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07E7CADC4;
        Wed,  4 Sep 2019 05:40:06 +0000 (UTC)
Date:   Wed, 4 Sep 2019 07:40:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm, oom: disable dump_tasks by default
Message-ID: <20190904054004.GA3838@dhcp22.suse.cz>
References: <20190903144512.9374-1-mhocko@kernel.org>
 <af0703d2-17e4-1b8e-eb54-58d7743cad60@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af0703d2-17e4-1b8e-eb54-58d7743cad60@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-09-19 05:52:43, Tetsuo Handa wrote:
> On 2019/09/03 23:45, Michal Hocko wrote:
> > It's primary purpose is
> > to help analyse oom victim selection decision.
> 
> I disagree, for I use the process list for understanding what / how many
> processes are consuming what kind of memory (without crashing the system)
> for anomaly detection purpose. Although we can't dump memory consumed by
> e.g. file descriptors, disabling dump_tasks() loose that clue, and is
> problematic for me.

Does anything really prevent you from enabling this by sysctl though? Or
do you claim that this is a general usage pattern and therefore the
default change is not acceptable or do you want a changelog to be
updated?

-- 
Michal Hocko
SUSE Labs
