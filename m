Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2827E21E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 21:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfEQThB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 15:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbfEQTg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:36:57 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3853521744;
        Fri, 17 May 2019 19:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121816;
        bh=r/5kHT8qNCmds9vT1Eew7p8unfIomQyC6md1FbdYsJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/fXUswA8zHmz/Gmo5Nxz/YNpbf8bYwl/IlI9k6NqLScy3uSJ81UxIQeoRJA8CGUD
         rgMZz90F2ikwO3fEDfLbNQglJl8yN8ydLc2OhfHxlxV7DX5BYTcyC3+YO70PJqFZRn
         hWNSPXgqZFVhcT/h/yYjUplPflVbKjqZchR8HFyQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/73] tools arch uapi: Sync the x86 kvm.h copy
Date:   Fri, 17 May 2019 16:35:05 -0300
Message-Id: <20190517193611.4974-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  59073aaf6de0 ("kvm: x86: Add exception payload fields to kvm_vcpu_events")

This silences the following perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

The changes in this file are in something not used at this time in any
tools/perf/ tool.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/n/tip-6uh8tpraons0h22dmxgfyony@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index dabfcf7c3941..7a0e64ccd6ff 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -381,6 +381,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
+#define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
 
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
-- 
2.20.1

