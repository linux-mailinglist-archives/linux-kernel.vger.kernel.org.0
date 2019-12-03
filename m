Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB811036C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 18:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfLCR06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 12:26:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39734 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfLCR0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:26:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so1955081plk.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 09:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DaFZ5uYZhl4fxFpyOFfrIQeYGNfjAMWIYqeXJnCftOA=;
        b=xJK3Fzk/SM8qCI6Vdhh+vjeERo74/h2zYao/L0sYq6If8CW3+dN3+5AHJdwnk4p5Ni
         kkT0KejGEEBaq+l7hJEGUjbNdahEMpm9jd1mBfqkWoLPThRrqoWVQ8hzk43kXOOrrHyg
         NyMpqlyjqkL7OqjIezAGwsA+/uRYjjT9jtAE08kc6Z23FJr6AbYNlbxkZ45r91P0K/G7
         rTq2LuQIVILui8m4hgkeLdSNHcfnkX3MLxB0zx7DGpxjPa7Ka5EMX+5WgSbn23OvZm14
         o72kCnh0Bg8FbciARCSsZq7hR/ejqP+EfYZkwo+X8ZcJsib/KS8WTe9aMhGya4KZzaEB
         Qi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DaFZ5uYZhl4fxFpyOFfrIQeYGNfjAMWIYqeXJnCftOA=;
        b=EQggHQbS0z+3EPkP2fO/hUXyNT4iVirNIQjoZ/mz1DnFN35mjDXAc8gOpxPR7ZQvPz
         UenAPOvWR3u8ZQwtobYzCELtAYVB6gyUANB3QQFhMEk5RKCXZw+N/nUtr8XqMvIglOxg
         qeIdSaNJ5Ml6hpKyudQMPuJKLWIVJMGZWYUGAK2QhiIN7/Io5f6G3Rz/h1vb0qAzAp8e
         O7G27oivN4m78c9XaQnQn5UvBOZj3X7Io8C4twqmIoukr6ZXl9fRFQMnxwdowxkx8FUt
         +LgqtnylJCXVeCjAQgNddZzMdt8ElpALZlf+70KTAird8uABrHl1/dIZqBA1OI5Mv1+r
         2XAQ==
X-Gm-Message-State: APjAAAX/NHBK5uyn0uFccfcVWDgzIKf/GD+2niUb3YRrLXDRRFGlvyWJ
        768vYcIOLvHGAhIkuOu48cQQR4Cy5uw=
X-Google-Smtp-Source: APXvYqwxYMp+k3Askq5Qqbg8BCkPrsdZrRFJOzqfdSJDIi9fHg66/qEC5ehhco+UDbJGjB2+OhmU8A==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4mr6137102plo.82.1575394010801;
        Tue, 03 Dec 2019 09:26:50 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l9sm4066177pgh.34.2019.12.03.09.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 09:26:50 -0800 (PST)
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
Subject: [RESEND][PATCH v16 5/5] kselftests: Add dma-heap test
Date:   Tue,  3 Dec 2019 17:26:41 +0000
Message-Id: <20191203172641.66642-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203172641.66642-1-john.stultz@linaro.org>
References: <20191203172641.66642-1-john.stultz@linaro.org>
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
Acked-by: Sandeep Patil <sspatil@android.com>
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
v15:
* Remove usage of dropped get_features ioctl
v16:
* Add extra ioctl compatibility testing suggested by
  Daniel Vetter
---
 tools/testing/selftests/dmabuf-heaps/Makefile |   6 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 396 ++++++++++++++++++
 2 files changed, 402 insertions(+)
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
index 000000000000..3e53ad331bdc
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -0,0 +1,396 @@
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
+static int dmabuf_heap_alloc_fdflags(int fd, size_t len, unsigned int fd_flags,
+				     unsigned int heap_flags, int *dmabuf_fd)
+{
+	struct dma_heap_allocation_data data = {
+		.len = len,
+		.fd = 0,
+		.fd_flags = fd_flags,
+		.heap_flags = heap_flags,
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
+static int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags,
+			     int *dmabuf_fd)
+{
+	return dmabuf_heap_alloc_fdflags(fd, len, O_RDWR | O_CLOEXEC, flags,
+					 dmabuf_fd);
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
+static int test_alloc_and_import(char *heap_name)
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
+		return -1;
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
+/* Test the ioctl version compatibility w/ a smaller structure then expected */
+static int dmabuf_heap_alloc_older(int fd, size_t len, unsigned int flags,
+				   int *dmabuf_fd)
+{
+	int ret;
+	unsigned int older_alloc_ioctl;
+	struct dma_heap_allocation_data_smaller {
+		__u64 len;
+		__u32 fd;
+		__u32 fd_flags;
+	} data = {
+		.len = len,
+		.fd = 0,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+	};
+
+	older_alloc_ioctl = _IOWR(DMA_HEAP_IOC_MAGIC, 0x0,
+				  struct dma_heap_allocation_data_smaller);
+	if (!dmabuf_fd)
+		return -EINVAL;
+
+	ret = ioctl(fd, older_alloc_ioctl, &data);
+	if (ret < 0)
+		return ret;
+	*dmabuf_fd = (int)data.fd;
+	return ret;
+}
+
+/* Test the ioctl version compatibility w/ a larger structure then expected */
+static int dmabuf_heap_alloc_newer(int fd, size_t len, unsigned int flags,
+				   int *dmabuf_fd)
+{
+	int ret;
+	unsigned int newer_alloc_ioctl;
+	struct dma_heap_allocation_data_bigger {
+		__u64 len;
+		__u32 fd;
+		__u32 fd_flags;
+		__u64 heap_flags;
+		__u64 garbage1;
+		__u64 garbage2;
+		__u64 garbage3;
+	} data = {
+		.len = len,
+		.fd = 0,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+		.heap_flags = flags,
+		.garbage1 = 0xffffffff,
+		.garbage2 = 0x88888888,
+		.garbage3 = 0x11111111,
+	};
+
+	newer_alloc_ioctl = _IOWR(DMA_HEAP_IOC_MAGIC, 0x0,
+				  struct dma_heap_allocation_data_bigger);
+	if (!dmabuf_fd)
+		return -EINVAL;
+
+	ret = ioctl(fd, newer_alloc_ioctl, &data);
+	if (ret < 0)
+		return ret;
+
+	*dmabuf_fd = (int)data.fd;
+	return ret;
+}
+
+static int test_alloc_compat(char *heap_name)
+{
+	int heap_fd = -1, dmabuf_fd = -1;
+	int ret;
+
+	heap_fd = dmabuf_heap_open(heap_name);
+	if (heap_fd < 0)
+		return -1;
+
+	printf("Testing (theoretical)older alloc compat\n");
+	ret = dmabuf_heap_alloc_older(heap_fd, ONE_MEG, 0, &dmabuf_fd);
+	if (ret) {
+		printf("Older compat allocation failed!\n");
+		ret = -1;
+		goto out;
+	}
+	close(dmabuf_fd);
+
+	printf("Testing (theoretical)newer alloc compat\n");
+	ret = dmabuf_heap_alloc_newer(heap_fd, ONE_MEG, 0, &dmabuf_fd);
+	if (ret) {
+		printf("Newer compat allocation failed!\n");
+		ret = -1;
+		goto out;
+	}
+	printf("Ioctl compatibility tests passed\n");
+out:
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+	if (heap_fd >= 0)
+		close(heap_fd);
+
+	return ret;
+}
+
+static int test_alloc_errors(char *heap_name)
+{
+	int heap_fd = -1, dmabuf_fd = -1;
+	int ret;
+
+	heap_fd = dmabuf_heap_open(heap_name);
+	if (heap_fd < 0)
+		return -1;
+
+	printf("Testing expected error cases\n");
+	ret = dmabuf_heap_alloc(0, ONE_MEG, 0x111111, &dmabuf_fd);
+	if (!ret) {
+		printf("Did not see expected error (invalid fd)!\n");
+		ret = -1;
+		goto out;
+	}
+
+	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0x111111, &dmabuf_fd);
+	if (!ret) {
+		printf("Did not see expected error (invalid heap flags)!\n");
+		ret = -1;
+		goto out;
+	}
+
+	ret = dmabuf_heap_alloc_fdflags(heap_fd, ONE_MEG,
+					~(O_RDWR | O_CLOEXEC), 0, &dmabuf_fd);
+	if (!ret) {
+		printf("Did not see expected error (invalid fd flags)!\n");
+		ret = -1;
+		goto out;
+	}
+
+	printf("Expected error checking passed\n");
+out:
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
+		ret = test_alloc_and_import(dir->d_name);
+		if (ret)
+			break;
+
+		ret = test_alloc_compat(dir->d_name);
+		if (ret)
+			break;
+
+		ret = test_alloc_errors(dir->d_name);
+		if (ret)
+			break;
+	}
+	closedir(d);
+
+	return ret;
+}
-- 
2.17.1

