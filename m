Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B859140AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 14:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgAQNgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 08:36:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49585 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbgAQNgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579268202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVICxkwYE819T09jumS9b6kqZZVW9alGabNhw2Byv4c=;
        b=NBgagi4vaVDraEVb5z2UKdz55Ow06HL4VwzW9qJzYRjo+al8258qd5DgxWAka0djOH1o33
        gBg7BWxeCJNHe9I/wpip7Qt8epB/JM4qsS/P3oBPsHI/DbhRQfLFiUxUbBw9Ts8nR3zxBe
        Ibl6F4CbmqlBoHVRrH5eGjfL1ZTplOM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-LaR8XwkzPNeTqWwBgZckWA-1; Fri, 17 Jan 2020 08:36:41 -0500
X-MC-Unique: LaR8XwkzPNeTqWwBgZckWA-1
Received: by mail-lf1-f70.google.com with SMTP id f18so4378165lfm.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 05:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oVICxkwYE819T09jumS9b6kqZZVW9alGabNhw2Byv4c=;
        b=FyCR2R6M6QYgoUElZ5kG6pq6nbSEgp8UqOEGdkf3JMHJPvBWEzDwojx0dvYVwSroQ7
         fPwVmnXVMa6G2vaHeocHCi/k4URxuPHcieP+yQK/mb1+Vz9JzzNmJ75WC7GZSGcH35uy
         zIIYHizWQdLlBX0AAjkjQZWWXl/6AHzLcgsY1deHIrW6lE8Xg2XNaqN3T9yD0XVsmOYz
         Dx2DH/b6jR//pCsnyo1/7i1j1/rGJ605ktTYfcXeVJK8j6dG2aCkL5p0/Ve2yomxMVeO
         5hl5YDQLnSX5cjaV16NgLbXD95sM+/MWN4MDqqKRznY7a7Iny1Sc0cdO7FOGXQNEJakN
         0fTg==
X-Gm-Message-State: APjAAAUUFnmLhPfPZrEoGfllRCCMBCsmlFoTnGVb5Hkb3FwXyRoEqYIg
        Ny+iXqpmLy3yuoHpQymwnFS/wlau21xTSG85pie8KpdCjYhxjMGY4isYjh+6b5whMQ7MdLFYEgM
        U46RgjpC/a7u9/FNLUf7JTbIR
X-Received: by 2002:a2e:3504:: with SMTP id z4mr5730189ljz.273.1579268199885;
        Fri, 17 Jan 2020 05:36:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqylN+0GVMNBaohq3jT5bbBFBEpPomA9QCEg65LVnS53cMW7Nhrc9Od5tPVFSrsyp0I8uvYr0A==
X-Received: by 2002:a2e:3504:: with SMTP id z4mr5730180ljz.273.1579268199696;
        Fri, 17 Jan 2020 05:36:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w1sm11999480lfe.96.2020.01.17.05.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:36:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 317BF1804D7; Fri, 17 Jan 2020 14:36:38 +0100 (CET)
Subject: [PATCH bpf-next v4 01/10] samples/bpf: Don't try to remove user's
 homedir on clean
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
Date:   Fri, 17 Jan 2020 14:36:38 +0100
Message-ID: <157926819814.1555735.13181807141455624178.stgit@toke.dk>
In-Reply-To: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
References: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The 'clean' rule in the samples/bpf Makefile tries to remove backup
files (ending in ~). However, if no such files exist, it will instead try
to remove the user's home directory. While the attempt is mostly harmless,
it does lead to a somewhat scary warning like this:

rm: cannot remove '~': Is a directory

Fix this by using find instead of shell expansion to locate any actual
backup files that need to be removed.

Fixes: b62a796c109c ("samples/bpf: allow make to be run from samples/bpf/ directory")
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 5b89c0370f33..f86d713a17a5 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -254,7 +254,7 @@ all:
 
 clean:
 	$(MAKE) -C ../../ M=$(CURDIR) clean
-	@rm -f *~
+	@find $(CURDIR) -type f -name '*~' -delete
 
 $(LIBBPF): FORCE
 # Fix up variables inherited from Kbuild that tools/ build system won't like

