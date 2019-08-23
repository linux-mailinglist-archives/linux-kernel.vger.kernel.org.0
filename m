Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B1F9B912
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 01:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfHWXsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 19:48:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36869 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHWXsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 19:48:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so6622602pgp.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 16:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NyBUASuAu3Awm8j3/xOM+PgdVeP3B+2DGc7L537MPcY=;
        b=xnglPL57vW+46X8KzuAeN3MtHJx7ljxB1qbutSlLO0mTuwP3RDIXQSlHqSyBvvyf9j
         Md6pjtxbTnyBnGHyFIrjrwO2Z3i9S9uvAAXuVHVcYYVdOCr5GijgLG0PZdgzTZqoT2KX
         fdeFzb7yrCzE8+zMiGvB8zd4gFuExVfX3Q4x/e5HgPpCq544dWmJCO3fOb/r6sMxapI9
         bxCjg2vJZ3rSLLfI4PC9JmZfZ7wzyPwTtbpA8tGlpEvduqWeYpOu4AlAEOb09HzErUfx
         ZdtRVx44dEyuvrmCHYvNo2dA+lvjocTpeS0OmTrKWBkz5/WyhoKS81XQoBoOoJLB53ry
         H9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NyBUASuAu3Awm8j3/xOM+PgdVeP3B+2DGc7L537MPcY=;
        b=YdUiBahuk6pfkF4J7VjIdfCgRFvA/1H3E1AEQWdOJeaz1i4P9rjZCu+2gLc92X2tW0
         dZrscIwynBk3Db2xdpyA0+6fGT3wPdqm/E1xLfqhGBK1j7iyt6uyym6hJd9/g4wuy/zU
         XXPE5fNKL1cE92aGzjO6dwMY2bPsDvVVpArrVqh/RenDjsRX4UPAcbMB9jbaaS5KhG2F
         zh9zBHM7YjP/xhipKGF2pdaMzFLrB3O8019fYT8zS6l0EU+yAYIfs9yLp1ymozCWmjzG
         a4OwokfDtUX8DakSmn2bSEvKU8eef8/JBfWVbE4Lth+b56KPQ278nXY4VSRuij9E9STj
         UAUQ==
X-Gm-Message-State: APjAAAXsJQ83ufAtfnGOOFslX8UsJDY4FU8kI1NHOBMAirFstr4WgjKn
        0iK7jOYp1QDxV8VyqRBPQR+do72Wf1c=
X-Google-Smtp-Source: APXvYqzlDJoExt/bJZOjfEyBcorwaqj19edjKu+yBH/KVZc0U/XZ2ASdphx1NjaE2hFhkVi2S0Q6Dg==
X-Received: by 2002:a63:6947:: with SMTP id e68mr6206559pgc.60.1566604082752;
        Fri, 23 Aug 2019 16:48:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id a5sm3185097pjs.31.2019.08.23.16.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 16:48:02 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v8 5/5] kselftests: Add dma-heap test
Date:   Fri, 23 Aug 2019 23:47:47 +0000
Message-Id: <20190823234747.106510-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823234747.106510-1-john.stultz@linaro.org>
References: <20190823234747.106510-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add very trivial allocation and import test for dma-heaps,
utilizing the vgem driver as a test importer.

A good chunk of this code taken from:
  tools/testing/selftests/android/ion/ionmap_test.c
  Originally by Laura Abbott <labbott@redhat.com>

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc: Sudipto Paul <Sudipto.Paul@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Switched to use reworked dma-heap apis
v3:
* Add simple mmap
* Utilize dma-buf testdev to test importing
v4:
* Rework to use vgem
* Pass in fd_flags to match interface changes
* Skip . and .. dirs
v6:
* Number of style/cleanups suggested by Brian
v7:
* Whitespace fixup for checkpatch
v8:
* More checkpatch whitespace fixups
---
 tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 230 ++++++++++++++++++
 2 files changed, 239 insertions(+)
 create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
 create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
new file mode 100644
index 000000000000..8c4c36e2972d
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -static -O3 -Wl,-no-as-needed -Wall
+#LDLIBS += -lrt -lpthread -lm
+
+# these are all "safe" tests that don't modify
+# system time or require escalated privileges
+TEST_GEN_PROGS = dmabuf-heap
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
new file mode 100644
index 000000000000..e439d6cf3d81
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+
+#include <linux/dma-buf.h>
+#include <drm/drm.h>
+
+#include "../../../../include/uapi/linux/dma-heap.h"
+
+#define DEVPATH "/dev/dma_heap"
+
+static int check_vgem(int fd)
+{
+	drm_version_t version = { 0 };
+	char name[5];
+	int ret;
+
+	version.name_len = 4;
+	version.name = name;
+
+	ret = ioctl(fd, DRM_IOCTL_VERSION, &version);
+	if (ret)
+		return 0;
+
+	return !strcmp(name, "vgem");
+}
+
+static int open_vgem(void)
+{
+	int i, fd;
+	const char *drmstr = "/dev/dri/card";
+
+	fd = -1;
+	for (i = 0; i < 16; i++) {
+		char name[80];
+
+		sprintf(name, "%s%u", drmstr, i);
+
+		fd = open(name, O_RDWR);
+		if (fd < 0)
+			continue;
+
+		if (!check_vgem(fd)) {
+			close(fd);
+			continue;
+		} else {
+			break;
+		}
+	}
+	return fd;
+}
+
+static int import_vgem_fd(int vgem_fd, int dma_buf_fd, uint32_t *handle)
+{
+	struct drm_prime_handle import_handle = {
+		.fd = dma_buf_fd,
+		.flags = 0,
+		.handle = 0,
+	 };
+	int ret;
+
+	ret = ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &import_handle);
+	if (ret == 0)
+		*handle = import_handle.handle;
+	return ret;
+}
+
+static void close_handle(int vgem_fd, uint32_t handle)
+{
+	struct drm_gem_close close = {
+		.handle = handle,
+	};
+
+	ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &close);
+}
+
+static int dmabuf_heap_open(char *name)
+{
+	int ret, fd;
+	char buf[256];
+
+	ret = sprintf(buf, "%s/%s", DEVPATH, name);
+	if (ret < 0) {
+		printf("sprintf failed!\n");
+		return ret;
+	}
+
+	fd = open(buf, O_RDWR);
+	if (fd < 0)
+		printf("open %s failed!\n", buf);
+	return fd;
+}
+
+static int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags,
+			     int *dmabuf_fd)
+{
+	struct dma_heap_allocation_data data = {
+		.len = len,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+		.heap_flags = flags,
+	};
+	int ret;
+
+	if (!dmabuf_fd)
+		return -EINVAL;
+
+	ret = ioctl(fd, DMA_HEAP_IOC_ALLOC, &data);
+	if (ret < 0)
+		return ret;
+	*dmabuf_fd = (int)data.fd;
+	return ret;
+}
+
+static void dmabuf_sync(int fd, int start_stop)
+{
+	struct dma_buf_sync sync = {
+		.flags = start_stop | DMA_BUF_SYNC_RW,
+	};
+	int ret;
+
+	ret = ioctl(fd, DMA_BUF_IOCTL_SYNC, &sync);
+	if (ret)
+		printf("sync failed %d\n", errno);
+}
+
+#define ONE_MEG (1024 * 1024)
+
+static void do_test(char *heap_name)
+{
+	int heap_fd = -1, dmabuf_fd = -1, importer_fd = -1;
+	uint32_t handle = 0;
+	void *p = NULL;
+	int ret;
+
+	printf("Testing heap: %s\n", heap_name);
+
+	heap_fd = dmabuf_heap_open(heap_name);
+	if (heap_fd < 0)
+		return;
+
+	printf("Allocating 1 MEG\n");
+	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
+	if (ret) {
+		printf("Allocation Failed!\n");
+		goto out;
+	}
+	/* mmap and write a simple pattern */
+	p = mmap(NULL,
+		 ONE_MEG,
+		 PROT_READ | PROT_WRITE,
+		 MAP_SHARED,
+		 dmabuf_fd,
+		 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed: %m\n");
+		goto out;
+	}
+	printf("mmap passed\n");
+
+	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
+
+	memset(p, 1, ONE_MEG / 2);
+	memset((char *)p + ONE_MEG / 2, 0, ONE_MEG / 2);
+	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
+
+	importer_fd = open_vgem();
+	if (importer_fd < 0) {
+		ret = importer_fd;
+		printf("Failed to open vgem\n");
+		goto out;
+	}
+
+	ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
+	if (ret < 0) {
+		printf("Failed to import buffer\n");
+		goto out;
+	}
+	printf("import passed\n");
+
+	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
+	memset(p, 0xff, ONE_MEG);
+	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
+	printf("syncs passed\n");
+
+	close_handle(importer_fd, handle);
+
+out:
+	if (p)
+		munmap(p, ONE_MEG);
+	if (importer_fd >= 0)
+		close(importer_fd);
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+	if (heap_fd >= 0)
+		close(heap_fd);
+}
+
+int main(void)
+{
+	DIR *d;
+	struct dirent *dir;
+
+	d = opendir(DEVPATH);
+	if (!d) {
+		printf("No %s directory?\n", DEVPATH);
+		return -1;
+	}
+
+	while ((dir = readdir(d)) != NULL) {
+		if (!strncmp(dir->d_name, ".", 2))
+			continue;
+		if (!strncmp(dir->d_name, "..", 3))
+			continue;
+
+		do_test(dir->d_name);
+	}
+	closedir(d);
+
+	return 0;
+}
-- 
2.17.1

