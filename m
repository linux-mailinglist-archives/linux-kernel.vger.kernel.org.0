Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80828178E29
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 11:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbgCDKOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 05:14:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34382 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387900AbgCDKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:13:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id w27so1033948lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olVifyTMleE2iedo0uCkocgafSknigkP2OP2Ek8xo9Y=;
        b=iPqLt7CUHivuNV8QujDV0W6QulaQWe6wT9uZYQ5ZKRMJDmO8MQGos3/IzH+Krr8TzL
         V1nEmvK5FFV62gRr6+sRztw3JaEsNXJHEpcLHkOLZPkC877v4r1Qx/J/EsqMr2kDeaIJ
         7RQpEjKYkaijGth3oAl+LoIx5x2nAxyaiWqE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olVifyTMleE2iedo0uCkocgafSknigkP2OP2Ek8xo9Y=;
        b=i/ZJuJ6+HgiFeqzmfPFGYQlV/UndNlnT3DInlDjs+eKwj7h/Ab+obVzU1oZIHyIjtk
         Lss8LehB/OBTrGM4Ugm3Hw+b1FE5np/dLSlwc3vjSFtVHPU1U6mTG6VZJiNNPlJHll/V
         19IKFkNWXJNLGr4spZOcwIFyWA9jsP3ugrcVCOpuOrBAjNDpg6ylvtTx+zoaAs8nLVtf
         gTOZwFVm5cKrEIg7j4np+Z5NqfS3dd0U8Qh96A2RfgV1Ej/WgiJvop1O7AdG1AlhmV6Y
         sdxvQ8cI0iJyjJ3//jnURfP/Jih8dsp/3OOEqgD8SAy+t2tKgzH+uFUu/atkKFy8tL07
         fAdw==
X-Gm-Message-State: ANhLgQ2i6AuW/Kwej3niUylIYNmRNaVVWx4z6trp/n78RKFVYlBGUyUU
        927ytSjQv9Y3Y3rTIX2MRSH7vw==
X-Google-Smtp-Source: ADFU+vsuEdVRpVHa3R4OMO85FbKQo1R+1kABMKY1D8/UloF2u7KmlAOlqXrDgoY2Yx6iLysg/Te0XQ==
X-Received: by 2002:ac2:5dd3:: with SMTP id x19mr940358lfq.168.1583316835115;
        Wed, 04 Mar 2020 02:13:55 -0800 (PST)
Received: from localhost.localdomain ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id l7sm341777lfk.65.2020.03.04.02.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:13:54 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 11/12] selftests: bpf: enable UDP sockmap reuseport tests
Date:   Wed,  4 Mar 2020 11:13:16 +0100
Message-Id: <20200304101318.5225-12-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304101318.5225-1-lmb@cloudflare.com>
References: <20200304101318.5225-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the guard that disables UDP tests now that sockmap
has support for them.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index a1dd13b34d4b..821b4146b7b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -805,12 +805,6 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 	char s[MAX_TEST_NAME];
 	const struct test *t;
 
-	/* SOCKMAP/SOCKHASH don't support UDP yet */
-	if (sotype == SOCK_DGRAM &&
-	    (inner_map_type == BPF_MAP_TYPE_SOCKMAP ||
-	     inner_map_type == BPF_MAP_TYPE_SOCKHASH))
-		return;
-
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
 		if (t->need_sotype && t->need_sotype != sotype)
 			continue; /* test not compatible with socket type */
-- 
2.20.1

