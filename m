Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA4A153AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfEFSbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 14:31:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43912 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfEFSbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:31:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id t22so6861590pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IfCUWTvSpe/ObcPM/LvXdQ0XKYCGSq77k0PD73RxjWI=;
        b=EIe86cQ7K8TderF8T7VdJ9IfpOXHbQ4Dzy2wT0wXDDyf6obptddgHxnwhoZi+ehABK
         yOmUlKW35Oo/Alh8q2aCAPAxQyxZ/AoBBlb1QCOj3Df7DId59pn45lc+9Tf4jXpF0Yd4
         PloBwXKn79IsNG6avU6/JP0r8IicZzIyVLyOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IfCUWTvSpe/ObcPM/LvXdQ0XKYCGSq77k0PD73RxjWI=;
        b=dT9pJb47Ctl2rHPsr7glHMbBcxajAql9iE+ZR2VylraaTOl/NdsaHug1L4V0IMHGTn
         iH5EHUrdSpCO0ypfjHra/bVn5KRIyAcvDz9szsk2lE8EdSSOqfgcvz+0VV+GgDUH9i6h
         F3nT/pPGjEOOGdlaBufU4kH4FtPONnpNe2S1R2arZwabQJYsIgsozlcNC+TOTDvRHN8x
         k7IzsBfcb8gndQ19Tw+mgG36XW6SpiBnxY0GAXmzbTu5lakld2fP9hHCjvSCF2kB00GC
         Wb0qGJmB66yhQjMwgq6/FEZUiPG8AlUvg8ie8uphPB9r67ubsa+1BGaPMmAyhDQvy3WX
         RwKA==
X-Gm-Message-State: APjAAAWisMVvTgtbV8tc9toeqeD5R78ef/vRq/uii1NzY8VdefcojDZ4
        mRsp8MWbu27rKrRDR+7c5aS4X2kY0LM=
X-Google-Smtp-Source: APXvYqw87aBaFaX0JfldiFHxy8FnYx3ibxSNeKODs8Fn08SOhD4IlfvMrdf+aewDAAvL101n3sCA7A==
X-Received: by 2002:a63:a18:: with SMTP id 24mr33507004pgk.332.1557167491372;
        Mon, 06 May 2019 11:31:31 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h30sm21412414pgi.38.2019.05.06.11.31.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 11:31:30 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Brendan Gregg <brendan.d.gregg@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        duyuchao <yuchao.du@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>, netdev@vger.kernel.org,
        Peter Ziljstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 3/4] bpf: Add warning when program uses deprecated bpf_probe_read
Date:   Mon,  6 May 2019 14:31:15 -0400
Message-Id: <20190506183116.33014-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190506183116.33014-1-joel@joelfernandes.org>
References: <20190506183116.33014-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpf_probe_read is deprecated and ambiguous. Add a warning if programs
still use it, so that they may be moved to not use it. After sufficient
time, the warning can be removed.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09d5d972c9ff..f8cc77e85b48 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7656,6 +7656,10 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			continue;
 
+		if (insn->imm == BPF_FUNC_probe_read)
+			pr_warn_once("bpf_probe_read is deprecated, please use "
+				     "bpf_probe_read_{kernel,user} in eBPF programs.\n");
+
 		if (insn->imm == BPF_FUNC_get_route_realm)
 			prog->dst_needed = 1;
 		if (insn->imm == BPF_FUNC_get_prandom_u32)
-- 
2.21.0.1020.gf2820cf01a-goog

