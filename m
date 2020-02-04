Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F81151766
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 10:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgBDJKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 04:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgBDJKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:10:15 -0500
Subject: Re: [GIT PULL] remoteproc updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580807415;
        bh=7UoyUd6eZyHhHXtwo/ibSZODYAQCVkBdlj/gf01XWZc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=POpMMIqSrkTr8lcI88LsOIHmjxxFwomlXc8+vj+XDiAzkDK+Upo6Zr6wpKlKQ2wtv
         3Jl4qOUDIaWoOWyw7YiSX9dy/YPViaF4fcwxOgp8uOmLBE3dBp6MF7x1yxv5LjKaEA
         +fGJ76413cXmMErcC9Ktrj4Ko05XFXlBzkibeFos=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200204053527.GB130281@yoga>
References: <20200204053527.GB130281@yoga>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200204053527.GB130281@yoga>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/rproc-v5.6
X-PR-Tracked-Commit-Id: 600c39b34369e2a1bf78eb67afb99ce550f271cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a45ad71e8995eed2b95c6ef0f4c442da0c4f6677
Message-Id: <158080741512.26461.18233793131597857197.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Feb 2020 09:10:15 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Erin Lo <erin.lo@mediatek.com>,
        Brandon Maier <brandon.maier@rockwellcollins.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ma Feng <mafeng.ma@huawei.com>,
        Pi-Hsun Shih <pihsun@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Feb 2020 21:35:27 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a45ad71e8995eed2b95c6ef0f4c442da0c4f6677

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
