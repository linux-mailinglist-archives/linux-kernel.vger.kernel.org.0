Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D61A29DC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfH2Wl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 18:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728210AbfH2WlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 530243CA20;
        Thu, 29 Aug 2019 22:41:24 +0000 (UTC)
Received: from treble.redhat.com (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FBE36060D;
        Thu, 29 Aug 2019 22:41:23 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] objtool,perf: Use shared x86 insn decoder
Date:   Thu, 29 Aug 2019 17:41:17 -0500
Message-Id: <cover.1567118001.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 29 Aug 2019 22:41:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's kind of silly that we have *three* identical copies of the x86 insn
decoder in the kernel tree.  Make it approximately 50% less silly by
reducing that number to two.

Josh Poimboeuf (4):
  objtool: Move x86 insn decoder to a common location
  perf: Update .gitignore file
  perf intel-pt: Remove inat.c from build dependency list
  perf intel-pt: Use shared x86 insn decoder

 .../{objtool => }/arch/x86/include/asm/inat.h |    0
 .../arch/x86/include/asm/inat_types.h         |    0
 .../{objtool => }/arch/x86/include/asm/insn.h |    0
 .../arch/x86/include/asm/orc_types.h          |    0
 tools/{objtool => }/arch/x86/lib/inat.c       |    0
 tools/{objtool => }/arch/x86/lib/insn.c       |    0
 .../arch/x86/lib/x86-opcode-map.txt           |    0
 .../arch/x86/tools/gen-insn-attr-x86.awk      |    0
 tools/objtool/Makefile                        |    4 +-
 tools/objtool/arch/x86/Build                  |    4 +-
 tools/objtool/arch/x86/decode.c               |    4 +-
 tools/objtool/sync-check.sh                   |   12 +-
 tools/perf/.gitignore                         |    3 +
 tools/perf/arch/x86/tests/insn-x86.c          |    2 +-
 tools/perf/arch/x86/util/archinsn.c           |    2 +-
 tools/perf/check-headers.sh                   |   11 +-
 tools/perf/util/intel-pt-decoder/Build        |   22 +-
 .../intel-pt-decoder/gen-insn-attr-x86.awk    |  392 ------
 tools/perf/util/intel-pt-decoder/inat.c       |   82 --
 tools/perf/util/intel-pt-decoder/inat.h       |  230 ----
 tools/perf/util/intel-pt-decoder/inat_types.h |   15 -
 tools/perf/util/intel-pt-decoder/insn.c       |  593 ---------
 tools/perf/util/intel-pt-decoder/insn.h       |  216 ----
 .../intel-pt-decoder/intel-pt-insn-decoder.c  |   10 +-
 .../util/intel-pt-decoder/x86-opcode-map.txt  | 1072 -----------------
 25 files changed, 34 insertions(+), 2640 deletions(-)
 rename tools/{objtool => }/arch/x86/include/asm/inat.h (100%)
 rename tools/{objtool => }/arch/x86/include/asm/inat_types.h (100%)
 rename tools/{objtool => }/arch/x86/include/asm/insn.h (100%)
 rename tools/{objtool => }/arch/x86/include/asm/orc_types.h (100%)
 rename tools/{objtool => }/arch/x86/lib/inat.c (100%)
 rename tools/{objtool => }/arch/x86/lib/insn.c (100%)
 rename tools/{objtool => }/arch/x86/lib/x86-opcode-map.txt (100%)
 rename tools/{objtool => }/arch/x86/tools/gen-insn-attr-x86.awk (100%)
 delete mode 100644 tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk
 delete mode 100644 tools/perf/util/intel-pt-decoder/inat.c
 delete mode 100644 tools/perf/util/intel-pt-decoder/inat.h
 delete mode 100644 tools/perf/util/intel-pt-decoder/inat_types.h
 delete mode 100644 tools/perf/util/intel-pt-decoder/insn.c
 delete mode 100644 tools/perf/util/intel-pt-decoder/insn.h
 delete mode 100644 tools/perf/util/intel-pt-decoder/x86-opcode-map.txt

-- 
2.20.1

