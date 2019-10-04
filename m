Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A667CC292
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 20:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfJDSZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 14:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfJDSZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:25:17 -0400
Subject: Re: [GIT PULL] xen: fixes and cleanups for 5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570213516;
        bh=hCJV6Cb9k1a8OM+r+Tfan49CvsXCBba1CExk57vZePQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Daas7tnC03wHKKLBfYuMzjQrox/zIgjqmFzy8fq2OzEsTFzoYO+ABgnLR1T+KQbeB
         2l1cI0L/CZk24VIdjmIkWorsPHj+ykN5SDQUfYPueFthXtfhI5zsI3uoA6+RDLdeIl
         GakbnvZPF9XGmqnO7c+XSdLQYd7DnGvs56jooeOk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191004050520.7270-1-jgross@suse.com>
References: <20191004050520.7270-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191004050520.7270-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.4-rc2-tag
X-PR-Tracked-Commit-Id: a8fabb38525c51a094607768bac3ba46b3f4a9d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50dfd03d9579cde9150679e90f8f244c626b7a09
Message-Id: <157021351644.30669.7701403465634234565.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Oct 2019 18:25:16 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  4 Oct 2019 07:05:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.4-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50dfd03d9579cde9150679e90f8f244c626b7a09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
