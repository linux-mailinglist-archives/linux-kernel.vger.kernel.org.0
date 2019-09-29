Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7642EC13D6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 09:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfI2HoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 03:44:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfI2HoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 03:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0A4218C4262;
        Sun, 29 Sep 2019 07:44:11 +0000 (UTC)
Received: from krava (ovpn-204-44.brq.redhat.com [10.40.204.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 89BBF643C1;
        Sun, 29 Sep 2019 07:44:08 +0000 (UTC)
Date:   Sun, 29 Sep 2019 09:44:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf: add support for logging debug messages to
 file
Message-ID: <20190929073951.GA15099@krava.homenet.telecomitalia.it>
References: <20190922023823.12543-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190922023823.12543-1-changbin.du@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Sun, 29 Sep 2019 07:44:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 10:38:21AM +0800, Changbin Du wrote:
> When in TUI mode, it is impossible to show all the debug messages to
> console. This make it hard to debug perf issues using debug messages.
> This patch adds support for logging debug messages to file to resolve
> this problem.
> 
> v2:
>   o specific all debug options one time.
> 
> Changbin Du (2):
>   perf: support multiple debug options separated by ','
>   perf: add support for logging debug messages to file

hi,
getting segfault with:

[jolsa@krava perf]$ ./perf --debug verbose=2,file report
build id event received for [kernel.kallsyms]: bf6ca14c03795fd67b4d88113681ba4af2b8c18a
Segmentation fault (core dumped)

jirka

> 
>  tools/perf/Documentation/perf.txt |  14 ++--
>  tools/perf/util/debug.c           | 106 ++++++++++++++++++------------
>  2 files changed, 73 insertions(+), 47 deletions(-)
> 
> -- 
> 2.20.1
> 
