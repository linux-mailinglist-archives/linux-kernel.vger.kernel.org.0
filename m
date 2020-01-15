Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F98313CC59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 19:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgAOSng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 13:43:36 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:40121 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbgAOSnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:43:32 -0500
Received: by mail-pj1-f73.google.com with SMTP id g12so460638pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bTzv6GNpgfrRZmeHOV0jVc+oFdZ9HuTWtPYHIUcg/W4=;
        b=u6yLAPqVa3ro09ZQhcPDbZBH6GA5ByMOsoiAYioTquy1hYzT8AeaEuB4kL/6IqUBPx
         0AqW1RIVD5mdOKoW9TemSg0AcKRhjLT3fUbCuIyhuy1yWsB7VlhrjwJkPRNshtCrszdb
         F/1Pk3RRjKtgGFtVaKh/hwIV28EmWUB8esDtd+10tZGMRs2tIXL1Eh8Dl72vyVMDfkgn
         Vl1LasdRigJ4pIrOOmCVj6GfgOZDFO2RQX1Gqxv2zrTraGVkFdNO+Iv+F+YDswQTy/dz
         MtqEXUYbt2z18+QEjMLnKygiEOVfMNunMnm29fORAte0NRZSBRmHgylNnqlh76NQSB7G
         GH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bTzv6GNpgfrRZmeHOV0jVc+oFdZ9HuTWtPYHIUcg/W4=;
        b=mRVoRWly6L0kIIylyoAr+i1kwpw0jUQ+B8HKdLXU+c2ZrYxhBDx6Vm2fdVOTFppHTB
         3PGUH1rIITQGUzQ54kmclrLasNG1Bqi/MlCWWHlGJqHUrWHjwauclngtcm5CsW+pIXaU
         pyNNjO+b+SJ3V++75hJ8cUCJwRl+FW90XtAKhDP5S1eyCw+R8GkfhG06weeB2RFDjQoO
         30iSTXzRb6opMs++sx1Nj6jfzvK1KJqHlDDxjTXzDpGk6WabgQhUUvo+RNyS2fgScica
         qH7toGt19DbHkFdOtgHtd9rvP4knNYTyWliSOC7KcCmiHIdLSt89HFubTDQlaSsSrdCs
         731Q==
X-Gm-Message-State: APjAAAVbm/pirm+bv0wmJiryJPwsLW1fandZpHIbACfFIu+tjhv2PC6x
        KHvC7eQQnyDVBlhfDZo+MSeiUyqMK3x6
X-Google-Smtp-Source: APXvYqxTfe7jLbFuDD+gZt1hs9KW/RLDoX7XAgEuKsCqDnYZQRqqvUy6B5pjHryPABA00K3D9D/UlRd4jAFC
X-Received: by 2002:a65:578e:: with SMTP id b14mr34722927pgr.444.1579113811637;
 Wed, 15 Jan 2020 10:43:31 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:43:03 -0800
In-Reply-To: <20200115184308.162644-1-brianvv@google.com>
Message-Id: <20200115184308.162644-5-brianvv@google.com>
Mime-Version: 1.0
References: <20200115184308.162644-1-brianvv@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v5 bpf-next 4/9] bpf: add lookup and update batch ops to arraymap
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the generic batch ops functionality to bpf arraymap, note that
since deletion is not a valid operation for arraymap, only batch and
lookup are added.

Signed-off-by: Brian Vazquez <brianvv@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/arraymap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index f0d19bbb9211e..95d77770353c9 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -503,6 +503,8 @@ const struct bpf_map_ops array_map_ops = {
 	.map_mmap = array_map_mmap,
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
+	.map_lookup_batch = generic_map_lookup_batch,
+	.map_update_batch = generic_map_update_batch,
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
-- 
2.25.0.rc1.283.g88dfdc4193-goog

