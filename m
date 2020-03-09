Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0317E650
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 19:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCISEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 14:04:30 -0400
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:45623 "EHLO
        1.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgCISEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:04:30 -0400
Received: from player690.ha.ovh.net (unknown [10.110.103.180])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 10C661FE5B7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 19:04:28 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player690.ha.ovh.net (Postfix) with ESMTPSA id 5FC20101AF5E1;
        Mon,  9 Mar 2020 18:04:16 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2] docs: sysctl/kernel: document BPF entries
Date:   Mon,  9 Mar 2020 19:03:50 +0100
Message-Id: <20200309180350.21075-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9596044907779345695
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddukedguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the implementation in kernel/bpf/syscall.c,
kernel/bpf/trampoline.c, include/linux/filter.h, and the documentation
in bpftool-prog.rst.

The section style doesn't match the surrounding sections; it matches
the style of the reworked kernel.rst queued up in docs-next.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---

Notes:
    Changes since v1:
    - rebased on bpf-next instead of docs-next.

 Documentation/admin-guide/sysctl/kernel.rst | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index def074807cee..eea7afd509ac 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -174,6 +174,20 @@ See the type_of_loader and ext_loader_ver fields in
 Documentation/x86/boot.rst for additional information.
 
 
+bpf_stats_enabled
+=================
+
+Controls whether the kernel should collect statistics on BPF programs
+(total time spent running, number of times run...). Enabling
+statistics causes a slight reduction in performance on each program
+run. The statistics can be seen using ``bpftool``.
+
+= ===================================
+0 Don't collect statistics (default).
+1 Collect statistics.
+= ===================================
+
+
 cap_last_cap:
 =============
 
@@ -1123,6 +1137,16 @@ NMI switch that most IA32 servers have fires unknown NMI up, for
 example.  If a system hangs up, try pressing the NMI switch.
 
 
+unprivileged_bpf_disabled
+=========================
+
+Writing 1 to this entry will disabled unprivileged calls to ``bpf()``;
+once disabled, calling ``bpf()`` without ``CAP_SYS_ADMIN`` will return
+``-EPERM``.
+
+Once set, this can't be cleared.
+
+
 watchdog:
 =========
 

base-commit: 3e7c67d90e3ed2f34fce42699f11b150dd1d3999
-- 
2.20.1

