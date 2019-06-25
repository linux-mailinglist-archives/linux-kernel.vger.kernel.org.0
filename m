Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF53526A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 10:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfFYI3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 04:29:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfFYI3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:29:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 636DD3082B6B;
        Tue, 25 Jun 2019 08:29:42 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-223.ams2.redhat.com [10.36.116.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EEDF608C2;
        Tue, 25 Jun 2019 08:29:41 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Subject: bpf: test_verifier: sanitation: alu with different scalars
Date:   Tue, 25 Jun 2019 11:29:40 +0300
Message-ID: <xunytvceoyob.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 25 Jun 2019 08:29:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm wondering, how the sanitaion tests (#903 5.2-rc6 for example)
are supposed to work on BE arches:

{
	"sanitation: alu with different scalars 1",
	.insns = {
	BPF_MOV64_IMM(BPF_REG_0, 1),
	BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
	BPF_MOV64_REG(BPF_REG_ARG2, BPF_REG_FP),
	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -16),
	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
	BPF_EXIT_INSN(),
	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),

reads one byte 0 on BE and 28 on LE (from ->index) since

	struct test_val {
		unsigned int index;
		int foo[MAX_ENTRIES];
	};

        struct test_val value = {
		.index = (6 + 1) * sizeof(int),
		.foo[6] = 0xabcdef12,
	};

	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),

So different branches are taken depending of the endianness.

	BPF_MOV64_IMM(BPF_REG_2, 0),
	BPF_MOV64_IMM(BPF_REG_3, 0x100000),
	BPF_JMP_A(2),
	BPF_MOV64_IMM(BPF_REG_2, 42),
	BPF_MOV64_IMM(BPF_REG_3, 0x100001),
	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
	BPF_EXIT_INSN(),
	},
	.fixup_map_array_48b = { 1 },
	.result = ACCEPT,
	.retval = 0x100000,
},



-- 
WBR,
Yauheni Kaliuta
