Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 175A8F4EE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 16:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfKHPFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 10:05:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfKHPFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:05:48 -0500
Received: from linux-8ccs (x2f7fce5.dyn.telefonica.de [2.247.252.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E38921D7F;
        Fri,  8 Nov 2019 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573225547;
        bh=0hKvS/0IH6XejevnnsZApZYvBIdYssIAT0f+aTciCPA=;
        h=Date:From:To:Cc:Subject:From;
        b=mXDWiL8FZMhOxSjObWdccOPmLFP5WeSSao+tg+HlaiGFasi1ivPVxIHoiJJLjt97j
         RQHaCLxEzM5nVkhR3HtAfGICxv3kZr5Ov/sqlsyUTyLcjcdQVGzYSTOmWE47c+KYty
         NzLL+iE4icDVGvirEyh2cfy1QbGBgkiV5EnLE51s=
Date:   Fri, 8 Nov 2019 16:05:41 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules fix for v5.4-rc7
Message-ID: <20191108150541.GA27264@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this modules fix for v5.4-rc7. Details are in the signed
tag as usual.

Thanks!

Jessica
---

The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.4-rc7

for you to fetch changes up to 57baec7b1b0459ef885e816d8c28a9d9a62bb8de:

  scripts/nsdeps: make sure to pass all module source files to spatch (2019-11-05 14:08:29 +0100)

----------------------------------------------------------------
Modules fixes for v5.4-rc7

- Fix `make nsdeps` for modules composed of multiple source files. Since
  $mod_source_files is not in quotes in the call to generate_deps_for_ns(), not
  all the source files for a module were being passed to spatch.

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Jessica Yu (1):
      scripts/nsdeps: make sure to pass all module source files to spatch

 scripts/nsdeps | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
