Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B590EECA6C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 22:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfKAVmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 17:42:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45951 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfKAVms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:42:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id z4so1871170pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BKopGp18VfB8thzYt3B0RriqVl7rtglmz7RmjgpOFFU=;
        b=KrVy1MKKM2w+NP5NbHceS58OGoeZN6dYS27RPSclt0xd3XWuYV6w5lEthbMmYmlLlL
         x3QpmB3a6Fzmywa0O9SRlUcAUC2ZW2z8/u+/FyuHQ7ogLNi4LVKNQBhj9qh+h3kIO2bi
         2exN+l3mY+HWqQZw6AUEscSN6x1QbvUn+PtKnQgo4Lwz3VdKBkcJitQjHcaVkrfZeQZP
         LA1HyzeR3cH9mlXZS+frQI3bPYjNcMUr66tTGGK0DrkgEteUI18DNtJde/F22WN4Cest
         bZ1kKMycP1QM4w7YUojd2aqAE2ZHdmr8oH9PY7sqcfrg/HmZDo/1RSFas3Y3kGakKZK3
         CAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BKopGp18VfB8thzYt3B0RriqVl7rtglmz7RmjgpOFFU=;
        b=L/Dnpb4VAAzFX1/G1m3+RKiEHuuq8qCH1JUb2MSUWQ+Yzz1rtzMV4FB5pM16lVTdtl
         uFkiAS0OrG+jAOEng1uvv3CfPG1mVZmDiIp3tthjuakoPkUfOeM32ATc5xQ77Wdymg95
         V9+BlI/+XPLGifBvURWeCqVb2oXN3OhgfXmScaFVGpHZMK+Hj5yDkTSLzuSUIwbtYndF
         m6RhTakuQmH/Km+1lOOJBG/YmHWlU83GR9/m+5aBTl+pJLh2ziqfkMHbRTtnlP5cAkgG
         wFkrshnT8eEzO+Xmhqk19uqrwsUJjrp3Q0NeN6zgoe9B2mBmqCcz+ZDcJZTZmq1TblXs
         9uJQ==
X-Gm-Message-State: APjAAAXmYqdaIaX/BcNk5zS9+00vt7dttHw1IS0U1lfyk1CLdAVTMDtL
        N2GpkQ+a+GGB6QlnnAC67FSa1o/u8sk=
X-Google-Smtp-Source: APXvYqzVnfDmbrk/uqmXW1DjOyXPCzoLFf/gLPS8NVxfobXsXQcOTxM2J9LazYgBPcCnG7O8yWAAuw==
X-Received: by 2002:a62:1ad6:: with SMTP id a205mr16030502pfa.64.1572644567226;
        Fri, 01 Nov 2019 14:42:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id u36sm8299058pgn.29.2019.11.01.14.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 14:42:46 -0700 (PDT)
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
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v14 5/5] kselftests: Add dma-heap test
Date:   Fri,  1 Nov 2019 21:42:38 +0000
Message-Id: <20191101214238.78015-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101214238.78015-1-john.stultz@linaro.org>
References: <20191101214238.78015-1-john.stultz@linaro.org>
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
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Acked-by: Laura Abbott <labbott@redhat.com>
Tested-by: Ayan Kumar Halder <ayan.halder@arm.com>
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
v9:
* Better handling error returns out to main, suggested
  by Brian Starkey
* Switch to using snprintf, suggested by Brian
v14:
* Fix a missing return value
* Add calls to test the GET_FEATURES ioctl
* Build fix reported by kernel test robot <lkp@intel.com>
  and fixed by Xiao Yang <ice_yangxiao@163.com>
* Minor Makefile cleanups
---
 tools/testing/selftests/dmabuf-heaps/Makefile |   6 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 255 ++++++++++++++++++
 2 files changed, 261 insertions(+)
 create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
 create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
new file mode 100644
index 000000000000..607c2acd2082
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -static -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include
+
+TEST_GEN_PROGS = dmabuf-heap
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
new file mode 100644
index 000000000000..ec47901ef2e2
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -0,0 +1,255 @@
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
+		snprintf(name, 80, "%s%u", drmstr, i);
+
+		fd = open(name, O_RDWR);
+		if (fd < 0)
+			continue;
+
+		if (!check_vgem(fd)) {
+			close(fd);
+			fd = -1;
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
+	ret = snprintf(buf, 256, "%s/%s", DEVPATH, name);
+	if (ret < 0) {
+		printf("snprintf failed!\n");
+		return ret;
+	}
+
+	fd = open(buf, O_RDWR);
+	if (fd < 0)
+		printf("open %s failed!\n", buf);
+	return fd;
+}
+
+static int dmabuf_heap_get_features(int fd, unsigned long long *features)
+{
+	struct dma_heap_get_features_data data = {0};
+	int ret;
+
+	ret = ioctl(fd, DMA_HEAP_IOC_GET_FEATURES, &data);
+	if (ret < 0)
+		return ret;
+
+	*features = (int)data.features;
+	return ret;
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
+static int do_test(char *heap_name)
+{
+	int heap_fd = -1, dmabuf_fd = -1, importer_fd = -1;
+	uint32_t handle = 0;
+	void *p = NULL;
+	unsigned long long features;
+	int ret;
+
+	printf("Testing heap: %s\n", heap_name);
+
+	heap_fd = dmabuf_heap_open(heap_name);
+	if (heap_fd < 0)
+		return -1;
+
+	dmabuf_heap_get_features(heap_fd, &features);
+	printf("Interface features: 0x%llx\n", features);
+
+	printf("Allocating 1 MEG\n");
+	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
+	if (ret) {
+		printf("Allocation Failed!\n");
+		ret = -1;
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
+		ret = -1;
+		goto out;
+	}
+	printf("mmap passed\n");
+
+	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
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
+	ret = 0;
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
+
+	return ret;
+}
+
+int main(void)
+{
+	DIR *d;
+	struct dirent *dir;
+	int ret = -1;
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
+		ret = do_test(dir->d_name);
+		if (ret)
+			break;
+	}
+	closedir(d);
+
+	return ret;
+}
-- 
2.17.1

