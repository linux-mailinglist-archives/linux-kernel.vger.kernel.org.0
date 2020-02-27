Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578A3172C87
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 00:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgB0Xu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 18:50:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbgB0Xu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:50:56 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB122469B;
        Thu, 27 Feb 2020 23:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582847456;
        bh=vLY1jGTFQ2Nzhvkfw1i1NyzuMha84wdZ9xpZL7AYyYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O82uzt650O7xx+JfWiRVk78Rn0SrVxvTMsJ7ZZytPtVLY8CgjFS5t3SFzAJTd4XZ3
         KKzdJ/vD0j/VxYVtHbWnO0zU1H70wvISPceYoHgd2s+O+C+Fx/AGdV2MUZ82d5aVTR
         5psfXwhHN+alIb/L6ssf8fp9jAlQMVOMcOXl+p5I=
Date:   Fri, 28 Feb 2020 08:50:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, zhe.he@windriver.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mhiramat@kernel.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: probe-file: Check return value of strlist__add
 for -ENOMEM
Message-Id: <20200228085050.2209133daa2dd1d7e6791522@kernel.org>
In-Reply-To: <20200227140341.GE10761@kernel.org>
References: <1582727404-180095-1-git-send-email-zhe.he@windriver.com>
        <20200226153153.GC217283@krava>
        <20200227140341.GE10761@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 11:03:41 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Wed, Feb 26, 2020 at 04:31:53PM +0100, Jiri Olsa escreveu:
> > On Wed, Feb 26, 2020 at 10:30:04PM +0800, zhe.he@windriver.com wrote:
> > > From: He Zhe <zhe.he@windriver.com>
> > > 
> > > strlist__add may fail with -ENOMEM. Check it and give debugging hint in
> > > advance.
> > > 
> > > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> Thanks, applied,

Thanks Arnaldo and He, Sorry I missed to reply my Ack.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
