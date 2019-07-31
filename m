Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 395CC7B747
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 02:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfGaAkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 20:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfGaAkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 20:40:13 -0400
Subject: Re: [GIT PULL] dax fix for v5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564533613;
        bh=NHbuxyEgLSoC499SN8BkNunymePONLRyhWu422VBgO4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dzz8sipVgdMN+nmkaVXM/Gpiw5lrM8TohMY8IIATGzAxmm45ZzmF+N0OjI8g+xuig
         Qq92IHbddQD2VumMKTHWPHF7lBqdBjDZoIJzVOEJRrcomk6YJbCXjaIDQvs+1ExakS
         +YH2RQxqgvjD1/5+TZqsnrQebij/v4IKbzb1mSL4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4hJcRY3aop4jgH8NLsz1A8HH7sH6gnGs02Wy8A=p5o=jg@mail.gmail.com>
References: <CAPcyv4hJcRY3aop4jgH8NLsz1A8HH7sH6gnGs02Wy8A=p5o=jg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4hJcRY3aop4jgH8NLsz1A8HH7sH6gnGs02Wy8A=p5o=jg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm dax-fix-5.3-rc3
X-PR-Tracked-Commit-Id: 61c30c98ef17e5a330d7bb8494b78b3d6dffe9b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4010b622f1d2a6112244101f38225eaee20c07f2
Message-Id: <156453361310.6472.7034768044112756538.pr-tracker-bot@kernel.org>
Date:   Wed, 31 Jul 2019 00:40:13 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 30 Jul 2019 14:32:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm dax-fix-5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4010b622f1d2a6112244101f38225eaee20c07f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
