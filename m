Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC49E2CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389413AbfJXJMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 05:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbfJXJMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:12:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2672D20856;
        Thu, 24 Oct 2019 09:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571908351;
        bh=lDS+Iiks292xAR/BkIZdtQqFuWRD4PijXCpeCaa9LaI=;
        h=From:To:Cc:Subject:Date:From;
        b=Oj7wylBfvXmuSQhN6loawNSkbvSIrFVx/fCDV6gxxZiukak3YeJVorfo/cRWnkyvu
         nWLQXIohJhe9v2YexiETFDBcevgaKeq8TTY6/OsPh6b1gNBHeKJa0SFqOlkZOedvi7
         DQnjwAh8s5t0JGbrc501Zdj2lNNGQI2hgUFgo9sY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 0/3] perf/probe: Fix available line bugs
Date:   Thu, 24 Oct 2019 18:12:27 +0900
Message-Id: <157190834681.1859.7399361844806238387.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some bugfixes related to showing available line (--line/-L)
option. I found that gcc generated some subprogram DIE with only
range attribute but no entry_pc or low_pc attributes.
In that case, perf probe failed to show the available lines in that
subprogram (function). To fix that, I introduced some bugfixes to
handle such cases correctly.

Thank you,

---

Masami Hiramatsu (3):
      perf/probe: Fix to find range-only function instance
      perf/probe: Walk function lines in lexical blocks
      perf/probe: Fix to show function entry line as probe-able


 tools/perf/util/dwarf-aux.c |   44 ++++++++++++++++++++++++++++++++++++-------
 tools/perf/util/dwarf-aux.h |    3 +++
 2 files changed, 40 insertions(+), 7 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
