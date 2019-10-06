Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41016CCD89
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 02:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfJFAkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 20:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfJFAkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 20:40:12 -0400
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570322411;
        bh=NV2oGcs+ZsnXtOJyl6kBJvWNPIOMZjeh4TeEMe2g9Jg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PC+LCvXAXCErjwVJFHd+gx+WOoQdgkP3EHLhdqBzem1KkwcVtbFOPjHcolST+jcJE
         hDg4vcoHYVeKgVwJm5x/CuuH2e6E64FHlYZGJF4CtpIMN2exGsxhcg3dT+cpkuFfp5
         DWyAjkp7RV2df23L5V3NLzwkyS1v1HhqijuIf9e8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191005224104.qptaeg72tt2gzdyl@localhost>
References: <20191005224104.qptaeg72tt2gzdyl@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191005224104.qptaeg72tt2gzdyl@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 60c1b3e25728e0485f08e72e61c3cad5331925a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43b815c6a8e7dbccb5b8bd9c4b099c24bc22d135
Message-Id: <157032241147.18164.1985437758135528075.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Oct 2019 00:40:11 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, soc@kernel.org,
        arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Oct 2019 15:41:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43b815c6a8e7dbccb5b8bd9c4b099c24bc22d135

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
