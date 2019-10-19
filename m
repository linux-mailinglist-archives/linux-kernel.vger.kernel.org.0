Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87423DD632
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 04:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfJSCfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 22:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfJSCfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 22:35:05 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571452504;
        bh=DVpcfNDXWIRE5HAyrvKVIZsitxJD5syg2ACwF02biBA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sER3u5hWII3pW118nItKqKh/+jjhzybnFKWebdb72n0td+Yuc+n5OqTZ4HswuirX+
         xDY/ZvbaRdtR8q+yGKFilQUh8Aw9Rsdz5nUV7zIaU+9axNHecJr7N6xD42CpqWuDMx
         Mrt32fzZsFJbzx2u6t4aascTyPzEdviq2IUqLxfA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1910181634460.21875@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1910181634460.21875@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1910181634460.21875@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.4-rc4
X-PR-Tracked-Commit-Id: 5bf4e52ff0317db083fafee010dc806f8d4cb0cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfdcff3215ae4ed7975b0991243d1dd8e1250bec
Message-Id: <157145250478.6008.17888015045709727703.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Oct 2019 02:35:04 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 16:36:14 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfdcff3215ae4ed7975b0991243d1dd8e1250bec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
