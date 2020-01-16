Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD113DB83
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 14:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAPNWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 08:22:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36109 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728897AbgAPNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579180951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYGxxZgSLFtlH8jcI3Nu4qoKg9CPPVXnWephfx6aPc4=;
        b=A5+wcdgja+B+2fGgSHlowJY9nG9BKOo3PYK8f7SwW2oMwo0oQ66KMgTEjpyC8AKhSjm8bV
        zzQu5KduGzLIfg8gFYEM1BAfhb9CvPG6T6sqTGMx+P6CqGDktegEprDIlhF0QLl80FSdDl
        cVFkgR9Fc2zVKcyuoDBmMHj0D96eJHU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-CGdkK9APNeKnk41NZnWVPw-1; Thu, 16 Jan 2020 08:22:30 -0500
X-MC-Unique: CGdkK9APNeKnk41NZnWVPw-1
Received: by mail-lj1-f198.google.com with SMTP id r14so5126511ljc.18
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xYGxxZgSLFtlH8jcI3Nu4qoKg9CPPVXnWephfx6aPc4=;
        b=CpHx093mLS3Nn8DuNj4TVdPI9wcJs3LMcJgez2Uf3zrKdVCw71PXr8GOvOwAK6VXfw
         WavDnYQdi5iMSMdtwjhz4kFPYGmvJy4UuQbdwfUcVmFnR95K20eLMQUQpNAJaVfNqi+c
         d51d+/as5QeIed/tRPBmwqSJp0m8Xm25qwLq/klEXqL13A2jWnQ93Grzg81NIakPTsop
         Z72hnR+521ZVdNklQnjRyoDKWlQGQF1dmnzbScgLiHyjf+fiZAxJg+cUrTjDh5E0zDdN
         gybXlarpREAMWwCA8nC8NMhWXXJ5y6tgsVtz2pYEhNJO3kT/5SwZMCghwDHMRFT5Bdsu
         +S5w==
X-Gm-Message-State: APjAAAXdYu6+BzJA+z0LCb0As22jHJkQDigwCp+96NkpmaBHnJSvFX4/
        fnr1IY/PjWpFxU52LXK//e4cYIEZ/HaIq8FxPqY5UxUElHodzc97Tlc4xNvUs5YZ8p9YB0MZV8+
        gV7rAi8JFgd5F4FzrDTg6dJ6r
X-Received: by 2002:a2e:b52b:: with SMTP id z11mr2348630ljm.155.1579180947072;
        Thu, 16 Jan 2020 05:22:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfmdIbBJX76Kqg7+Yyy3+Jb6vlAiz8KLU+B3P9UXhqphkNxoSBonQsyrf+47I652QC3NESmg==
X-Received: by 2002:a2e:b52b:: with SMTP id z11mr2348613ljm.155.1579180946842;
        Thu, 16 Jan 2020 05:22:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s22sm10945565ljm.41.2020.01.16.05.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:22:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 19EEE1808D8; Thu, 16 Jan 2020 14:22:24 +0100 (CET)
Subject: [PATCH bpf-next v3 11/11] libbpf: Fix include of bpf_helpers.h when
 libbpf is installed on system
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Thu, 16 Jan 2020 14:22:24 +0100
Message-ID: <157918094400.1357254.5646603555325507261.stgit@toke.dk>
In-Reply-To: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The change to use angled includes for bpf_helper_defs.h breaks compilation
against libbpf when it is installed in the include path, since the file is
installed in the bpf/ subdirectory of $INCLUDE_PATH. Since we've now fixed
the selftest Makefile to not require this anymore, revert back to
double-quoted include so bpf_helpers.h works regardless of include path.

Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken from selftests dir")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/bpf_helpers.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 050bb7bf5be6..f69cc208778a 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -2,7 +2,7 @@
 #ifndef __BPF_HELPERS__
 #define __BPF_HELPERS__
 
-#include <bpf_helper_defs.h>
+#include "bpf_helper_defs.h"
 
 #define __uint(name, val) int (*name)[val]
 #define __type(name, val) typeof(val) *name

