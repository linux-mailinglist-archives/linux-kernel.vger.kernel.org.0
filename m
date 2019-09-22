Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DFEBA893
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 21:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfIVTF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 15:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbfIVTF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:05:27 -0400
Subject: Re: [GIT PULL] remoteproc updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569179126;
        bh=MCqZR6CFebqHPUrtn/vpHzY/2O155lN6ggfCXqlOrw8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HzvRMLZxuHDjAR1YYxyVQXMAVp9n+sMuc9rjzcedq9rmH1Z1AsWxUTD9hA5hS1/MA
         +nh/qTXWJ7cLKq7zSoN+Ey2IC2FkqlmmF6zrcw8PLxO010v7Z6v+j56hptNnDQieLV
         7BJfTrEF7rDzCVw3yjzzX0maQr+h6JlxRAt9w1lk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190921165845.GA6693@tuxbook-pro>
References: <20190921165845.GA6693@tuxbook-pro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190921165845.GA6693@tuxbook-pro>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc
 tags/rproc-v5.4
X-PR-Tracked-Commit-Id: 150997fac770c37b12459ec52fdf67a5dc1366f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28de978ba346f4d5baee4e59841b473a7ff38f0d
Message-Id: <156917912677.24588.10977042119425435480.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Sep 2019 19:05:26 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, Suman Anna <s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Sep 2019 09:58:45 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc tags/rproc-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28de978ba346f4d5baee4e59841b473a7ff38f0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
