Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF9919771B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgC3I4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 04:56:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:60208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbgC3I4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:56:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DADD3AFB5;
        Mon, 30 Mar 2020 08:56:16 +0000 (UTC)
Date:   Mon, 30 Mar 2020 10:56:09 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: x86/RAS updates for 5.7
Message-ID: <20200330085554.GD14624@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the RAS updates which got collected this time around.

Thx.

---
The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_updates_for_5.7

for you to fetch changes up to 077168e241ec5a3b273652acb1e85f8bc1dc2d81:

  x86/mce/amd: Add PPIN support for AMD MCE (2020-03-22 11:03:47 +0100)

----------------------------------------------------------------
* Do not report spurious MCEs on some Intel platforms caused by errata;
by Prarit Bhargava.

* Change dev-mcelog's hardcoded limit of 32 error records to a dynamic
one, controlled by the number of logical CPUs, by Tony Luck.

* Add support for the processor identification number (PPIN) on AMD, by
Wei Huang.

----------------------------------------------------------------
Prarit Bhargava (1):
      x86/mce: Do not log spurious corrected mce errors

Tony Luck (1):
      x86/mce/dev-mcelog: Dynamically allocate space for machine check records

Wei Huang (1):
      x86/mce/amd: Add PPIN support for AMD MCE

 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/mce.h           |  6 ++---
 arch/x86/kernel/cpu/amd.c            | 30 +++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c       |  4 +++
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 47 +++++++++++++++++++++---------------
 arch/x86/kernel/cpu/mce/intel.c      | 17 +++++++++++++
 arch/x86/kernel/cpu/mce/internal.h   |  2 ++
 7 files changed, 84 insertions(+), 23 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
