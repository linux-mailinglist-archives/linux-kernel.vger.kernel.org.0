Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD581010EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 02:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfKSBoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 20:44:34 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:49695 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfKSBoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:44:32 -0500
Received: by mail-pl1-f201.google.com with SMTP id v1so12178167plz.16
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 17:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+lN+OnV/OGJwrxgrmDkzu2oxVw2ucT8UYsYGvvebriE=;
        b=SgxZGNUVWYGGXkISad1kgT6U14PAx1pYar/m0xNV/3NNFEf6NzDllpscBgMFeLQ5lF
         dft6a8iZOTnTvVVsdNOmbswFnRj1d1xZiPgX51/b+cBLvg4HO30UIqKU+r+GXogOfJih
         PJO8nmNkKWEEd6+fX2TswwINxJ3CNZjMLmZGHqwLIi/2K/oLIpD30/iV7+UXjB6Mt9uM
         /Qy6ye3RZMM+9nFeLh4kn1mkSH3UTa2EJJOAgCFUSnO7AyWRAC8JZ6gAT27V/rpm6cBH
         BWi/d6AjaKgOg1F+JHm9Z0QT4jNWQCsBCa1j3H3BZ42KB5ivt4pmacFFdzx/k4c5Ov7I
         2wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+lN+OnV/OGJwrxgrmDkzu2oxVw2ucT8UYsYGvvebriE=;
        b=bfNzS9KXP2VxxPvdqyPbW8zPxLwDbXTQ0NNF6rXtLp8jzhBkIJ8+EO8WXcJlDgKMz6
         o25P/PUg8mkP9lEgm9Cb5+biANNz8S3XLP9q1Cjg9WNA+OO0rLwSAIAYneW6RX6nQs+p
         vylUZG4MNKvfTz0QoPTWJfyrwuG39Bdw+hWVLYvx/BnMiZd9O4kv+NH7acZMsabp7/TF
         Eywm0WNYgFtd1Zi9vBN5I+XVGtn2GXDDuLMlHVPQe48iRiRyjWCoVWJnfLsNMpamu8bJ
         zIzre8G8CHYI5Dir+NSEvC8z5PbfX9u2e2nJ/6NvTT3BMQeDg0pi4MJmtcIzHD4Tiw4c
         JIng==
X-Gm-Message-State: APjAAAVekAjJKmsHkqodIKXG2WFFGEcAfbsW9ZcBqunO+RJrkWNa8F3K
        CyWzXTDKsmux7UShKKQpdwoqthTeSerO
X-Google-Smtp-Source: APXvYqyB2Y5/Wmt+HsgSIkvPHaLgzw0qyYa7UcYgcIX8FTmQbpHeFUjIzNWtvmKgynWAz8wtTscL+ylNecL6
X-Received: by 2002:a63:4501:: with SMTP id s1mr2642645pga.5.1574127871391;
 Mon, 18 Nov 2019 17:44:31 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:43:55 -0800
In-Reply-To: <20191119014357.98465-1-brianvv@google.com>
Message-Id: <20191119014357.98465-8-brianvv@google.com>
Mime-Version: 1.0
References: <20191119014357.98465-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf-next 7/9] libbpf: add libbpf support to batch ops
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

Added four libbpf API functions to support map batch operations:
  . int bpf_map_delete_batch( ... )
  . int bpf_map_lookup_batch( ... )
  . int bpf_map_lookup_and_delete_batch( ... )
  . int bpf_map_update_batch( ... )

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/bpf.c      | 61 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h      | 14 +++++++++
 tools/lib/bpf/libbpf.map |  4 +++
 3 files changed, 79 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 98596e15390fb..9acd9309b47b3 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -443,6 +443,67 @@ int bpf_map_freeze(int fd)
 	return sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
 }
 
+static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
+				void *out_batch, void *keys, void *values,
+				__u32 *count, __u64 elem_flags,
+				__u64 flags)
+{
+	union bpf_attr attr = {};
+	int ret;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.batch.map_fd = fd;
+	attr.batch.in_batch = ptr_to_u64(in_batch);
+	attr.batch.out_batch = ptr_to_u64(out_batch);
+	attr.batch.keys = ptr_to_u64(keys);
+	attr.batch.values = ptr_to_u64(values);
+	if (count)
+		attr.batch.count = *count;
+	attr.batch.elem_flags = elem_flags;
+	attr.batch.flags = flags;
+
+	ret = sys_bpf(cmd, &attr, sizeof(attr));
+	if (count)
+		*count = attr.batch.count;
+
+	return ret;
+}
+
+int bpf_map_delete_batch(int fd, void *in_batch, void *out_batch, __u32 *count,
+			 __u64 elem_flags, __u64 flags)
+{
+	return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, in_batch,
+				    out_batch, NULL, NULL, count,
+				    elem_flags, flags);
+}
+
+int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch, void *keys,
+			 void *values, __u32 *count,
+			 __u64 elem_flags, __u64 flags)
+{
+	return bpf_map_batch_common(BPF_MAP_LOOKUP_BATCH, fd, in_batch,
+				    out_batch, keys, values, count,
+				    elem_flags, flags);
+}
+
+int bpf_map_lookup_and_delete_batch(int fd, void *in_batch, void *out_batch,
+				    void *keys, void *values,
+				    __u32 *count, __u64 elem_flags,
+				    __u64 flags)
+{
+	return bpf_map_batch_common(BPF_MAP_LOOKUP_AND_DELETE_BATCH,
+				    fd, in_batch, out_batch, keys, values,
+				    count, elem_flags, flags);
+}
+
+int bpf_map_update_batch(int fd, void *keys, void *values, __u32 *count,
+			 __u64 elem_flags, __u64 flags)
+{
+	return bpf_map_batch_common(BPF_MAP_UPDATE_BATCH,
+				    fd, NULL, NULL, keys, values,
+				    count, elem_flags, flags);
+}
+
 int bpf_obj_pin(int fd, const char *pathname)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 3c791fa8e68e8..3ec63384400f1 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -126,6 +126,20 @@ LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
 LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
+LIBBPF_API int bpf_map_delete_batch(int fd, void *in_batch, void *out_batch,
+				    __u32 *count, __u64 elem_flags,
+				    __u64 flags);
+LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
+				    void *keys, void *values, __u32 *count,
+				    __u64 elem_flags, __u64 flags);
+LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
+					       void *out_batch, void *keys,
+					       void *values, __u32 *count,
+					       __u64 elem_flags, __u64 flags);
+LIBBPF_API int bpf_map_update_batch(int fd, void *keys, void *values,
+				    __u32 *count, __u64 elem_flags,
+				    __u64 flags);
+
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
 LIBBPF_API int bpf_obj_get(const char *pathname);
 LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ddc2c40e482d..56462fea66f74 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -207,4 +207,8 @@ LIBBPF_0.0.6 {
 		bpf_program__size;
 		btf__find_by_name_kind;
 		libbpf_find_vmlinux_btf_id;
+		bpf_map_delete_batch;
+		bpf_map_lookup_and_delete_batch;
+		bpf_map_lookup_batch;
+		bpf_map_update_batch;
 } LIBBPF_0.0.5;
-- 
2.24.0.432.g9d3f5f5b63-goog

