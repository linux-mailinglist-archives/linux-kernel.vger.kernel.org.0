Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844573C031
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 01:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbfFJXwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 19:52:05 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:52551 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390568AbfFJXwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 19:52:04 -0400
Received: by mail-oi1-f201.google.com with SMTP id y81so3392868oig.19
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 16:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=M35jpHh+HUdAc93UKOjDO7JbyHiHSckhQH2gYDGobXY=;
        b=V/8aJ9BoljeksjjbvJVkvok+M4cu/Zi4V0ZnLJks3J17Tx2XIcaTwiX2OC2jFldJme
         KtkOvG/qkTOvKgG2G4oUhsML/44UixS0oT25mPxx6sNem5IhlTl9fXvMHG3FeDtzuh6+
         i5DJbsd1R1JO0xdAtlSwPayiik4d7p211BflfA2sTdbuizialJPgbaXXaCVmmQyVcQvx
         /zkGhwsZYFcDGZJQ05AMGyhdh6EZEVMIoq+/8ujnk8LODnw1l8q9MC2zgSZ1/H9AuOfC
         vwCVF8fqu/yTnwv7wJAWEtxrUpxU5ldhDJZq7B95WXQK+9nRo53DeEdaPqFbZKUCTgi+
         danQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=M35jpHh+HUdAc93UKOjDO7JbyHiHSckhQH2gYDGobXY=;
        b=gIGTYXKirNYxr5YXrIA2Psqae/NXbdHDLpX9aTvmM+JwCmKRYrPCOrx3Hh03uUTYSI
         jLF4roqA156Mu27cYd/EaPBb8v81yKz/Hm7WnZTY9zV+GD8Q9bjwMmwpn0IsrSwmxId6
         yd2Ujk19QrpIvxgabpbkNgPvElakvr/eGYpXvLGELpA/BwwIYcyoyKWrx3xtun2+xHom
         K+dDcCGUC4eqp1i+ZX5gJUG75eBPIEZt3DJKijOCptxBgIzKTZaiCyfciKDVY50fFEcN
         YclWq5154+FPRDX1Kt29basP411eEJS74ZhU/nc0fv7PfVarYoHgDoU7Gtsbck1Yj5Ho
         xlbw==
X-Gm-Message-State: APjAAAX6fupHdL0jKq6TmZFL12oq57IsYSNatqFTiPY+tMIQ8HYBoFxL
        fw3mxyLUNpxWqDnpLM2WSi62krYbOWoRqiBbwQ0e+1VaCHjpAGq+l4BPRBO8lTchYIzW78e87pP
        F554WTpuCUnscOH7cIF/hkW7IYfgUjLKRd/aLi177WGWAHOznkRlx2AVCQUZGieLdHos=
X-Google-Smtp-Source: APXvYqz5HVmvYAuUjwPj5rFsB8gNIYhrw9pY5CGqSimzEyfTZABC92Z+V648M/PgUJEFOqt/y8mKBWL+1g==
X-Received: by 2002:aca:f4ce:: with SMTP id s197mr14299094oih.45.1560210723679;
 Mon, 10 Jun 2019 16:52:03 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:51:58 -0700
Message-Id: <20190610235201.145457-1-fengc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [RESEND PATCH v3 0/3] Improve the dma-buf tracking
From:   Chenbo Feng <fengc@google.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        --validate@google.com
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all dma-bufs share the same anonymous inode. While we can count
how many dma-buf fds or mappings a process has, we can't get the size of
the backing buffers or tell if two entries point to the same dma-buf. And
in debugfs, we can get a per-buffer breakdown of size and reference count,
but can't tell which processes are actually holding the references to each
buffer.

To resolve the issue above and provide better method for userspace to track
the dma-buf usage across different processes, the following changes are
proposed in dma-buf kernel side. First of all, replace the singleton inode
inside the dma-buf subsystem with a mini-filesystem, and assign each
dma-buf a unique inode out of this filesystem.  With this change, calling
stat(2) on each entry gives the caller a unique ID (st_ino), the buffer's
size (st_size), and even the number of pages assigned to each dma-buffer.
Secoundly, add the inode information to /sys/kernel/debug/dma_buf/bufinfo
so in the case where a buffer is mmap()ed into a process=E2=80=99s address =
space
but all remaining fds have been closed, we can still get the dma-buf
information and try to accociate it with the process by searching the
proc/pid/maps and looking for the corresponding inode number exposed in
dma-buf debug fs. Thirdly, created an ioctl to assign names to dma-bufs
which lets userspace assign short names (e.g., "CAMERA") to buffers. This
information can be extremely helpful for tracking and accounting shared
buffers based on their usage and original purpose. Last but not least, add
dma-buf information to /proc/pid/fdinfo by adding a show_fdinfo() handler
to dma_buf_file_operations. The handler will print the file_count and name
of each buffer.

Change in v2:
* Add a check to prevent changing dma-buf name when it is attached to
  devices.
* Fixed some compile warnings

Change in v3:
* Removed the GET_DMA_BUF_NAME ioctls, add the dma_buf pointer to dentry
  d_fsdata so the name can be displayed in proc/pid/maps and
  proc/pid/map_files.

Greg Hackmann (3):
  dma-buf: give each buffer a full-fledged inode
  dma-buf: add DMA_BUF_{GET,SET}_NAME ioctls
  dma-buf: add show_fdinfo handler

 drivers/dma-buf/dma-buf.c    | 122 +++++++++++++++++++++++++++++++++--
 include/linux/dma-buf.h      |   5 +-
 include/uapi/linux/dma-buf.h |   3 +
 include/uapi/linux/magic.h   |   1 +
 4 files changed, 124 insertions(+), 7 deletions(-)

--=20
2.21.0.1020.gf2820cf01a-goog

