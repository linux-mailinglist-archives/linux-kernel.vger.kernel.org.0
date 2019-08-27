Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346859E5C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 12:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfH0Kia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 06:38:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:52216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfH0Ki3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:38:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56FC8AF2C;
        Tue, 27 Aug 2019 10:38:28 +0000 (UTC)
Date:   Tue, 27 Aug 2019 12:38:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Edward Chron <echron@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
Message-ID: <20190827103827.GV7538@dhcp22.suse.cz>
References: <20190826193638.6638-1-echron@arista.com>
 <20190827071523.GR7538@dhcp22.suse.cz>
 <5768394f-1511-5b00-f715-c0c5446a2d2a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5768394f-1511-5b00-f715-c0c5446a2d2a@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 19:10:18, Tetsuo Handa wrote:
> On 2019/08/27 16:15, Michal Hocko wrote:
> > All that being said, I do not think this is something we want to merge
> > without a really _strong_ usecase to back it.
> 
> Like the sender's domain "arista.com" suggests, some of information is
> geared towards networking devices, and ability to report OOM information
> in a way suitable for automatic recording/analyzing (e.g. without using
> shell prompt, let alone manually typing SysRq commands) would be convenient
> for unattended devices.

Why cannot the remote end of the logging identify the host. It has to
connect somewhere anyway, right? I also do assume that a log collector
already does store each log with host id of some form.

-- 
Michal Hocko
SUSE Labs
