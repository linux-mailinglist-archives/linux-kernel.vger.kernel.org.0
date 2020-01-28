Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777B814C0A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 20:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgA1TKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 14:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgA1TKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:10:03 -0500
Subject: Re: [GIT PULL] perf/core improvements and fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580238602;
        bh=+uDVMUtEhs6pzXZEV7Sqgzktkr4wtz6oymBKV1GL0Xk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lWFlKNbGWVkMPPP6xkGl5Yj7MEMMHj6z5Olhg5ZNn2TBoq5Zy7Y4xbhciHXx2ZoRz
         lPvVya6rp4diPoyyxCHYg7utecIUcFaBCcDPiiAplu4bfieJ27ccKB6Uks6JGewXpM
         iFhdg+WnynGkuplVDNVcr1FkG2HJwl+ZLJOZM/Lk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200106160705.10899-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
 tags/perf-core-for-mingo-5.6-20200106
X-PR-Tracked-Commit-Id: 6c4798d3f08b81c2c52936b10e0fa872590c96ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53f3feeb7bd2d78039b3dc9ab158bad2a5dbe012
Message-Id: <158023860252.9583.8458853393585082822.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 19:10:02 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        David Ahern <dsahern@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  6 Jan 2020 13:06:45 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.6-20200106

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53f3feeb7bd2d78039b3dc9ab158bad2a5dbe012

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
