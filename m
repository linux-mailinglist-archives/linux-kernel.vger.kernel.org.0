Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A0AA56B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 16:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfIEOIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 10:08:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:40136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbfIEOIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:08:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F3F5AD07;
        Thu,  5 Sep 2019 14:08:33 +0000 (UTC)
Date:   Thu, 5 Sep 2019 16:08:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm, oom: disable dump_tasks by default
Message-ID: <20190905140833.GB3838@dhcp22.suse.cz>
References: <20190903144512.9374-1-mhocko@kernel.org>
 <af0703d2-17e4-1b8e-eb54-58d7743cad60@i-love.sakura.ne.jp>
 <20190904054004.GA3838@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909041302290.95127@chino.kir.corp.google.com>
 <12bcade2-4190-5e5e-35c6-7a04485d74b9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12bcade2-4190-5e5e-35c6-7a04485d74b9@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-09-19 22:39:47, Tetsuo Handa wrote:
[...]
> There is nothing that prevents users from enabling oom_dump_tasks by sysctl.
> But that requires a solution for OOM stalling problem.

You can hardly remove stalling if you are not reducing the amount of
output or get it into a different context. Whether the later is
reasonable is another question but you are essentially losing "at the
OOM event state".

> Since I know how
> difficult to avoid problems caused by printk() flooding, I insist that
> we need "mm,oom: Defer dump_tasks() output." patch.

insisting is not a way to cooperate.
-- 
Michal Hocko
SUSE Labs
