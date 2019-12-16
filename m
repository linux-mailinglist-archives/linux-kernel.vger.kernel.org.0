Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D53021219E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 20:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfLPT27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 14:28:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:7077 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfLPT26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:28:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 10:34:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="227205218"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 16 Dec 2019 10:34:55 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 61E903003B3; Mon, 16 Dec 2019 10:34:55 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Mon, 16 Dec 2019 10:34:55 -0800
In-Reply-To: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
        (Tetsuo Handa's message of "Mon, 16 Dec 2019 18:59:55 +0900")
Message-ID: <87v9qgunjk.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> While syzkaller is finding many bugs, sometimes syzkaller examines
> stupid operations. But disabling operations using kernel config option
> is problematic because "kernel config option excludes whole module when
> there is still room for examining all but specific operation" and
> "the list of kernel config options becomes too complicated to maintain
> because such list changes over time". Thus, this patch introduces a
> kernel config option which allows disabling only specific operations.
> This kernel config option should be enabled only when building kernels
> for fuzz testing.

It seems this should rather be a run time setting. Otherwise it's
impossible to fuzz existing kernel binaries without rebuilding them.

Yes syzkaller requires rebuilding anyways for the new compiler options,
but there are other options (e.g. PT guided fuzzing) that do not.

Maybe the run time setting can be the same as locked down kernels.
It seems to me locked down kernels should avoid all these operations too.

-Andi
