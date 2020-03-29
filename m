Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6448C197103
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 01:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgC2XEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 19:04:44 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54270 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgC2XEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 19:04:43 -0400
Received: by mail-pj1-f67.google.com with SMTP id l36so6741835pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 16:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rCn28/5YMVoix93/RoHK+5/W1grR76h8dUAa1bzWPcE=;
        b=SKMr3/oHWImaHQ9Yfs8nzgJ9q3sBRaKeow9afbC4mDpLPm01p8TCId19wicllBL7BB
         zIa3Mw5TI06v1VQuvKnNn2egj449CJOCSBqJVqWRJYpP6A5KkWy3SeZMXi4M8RJCxyOc
         EGzoids6sU5Q8y0TSv8qMdEr0zdKWjWI42gjaG4HVaMcLDwpErXTw7RUwj2sX/MQzU/n
         K9w35Dh9i5mIsob0nVrdW19GWM8ZnV/mQuvta4gQebZqgYSPUGre8AYLPsDmP42zCaaj
         1gjtK7VFXMPGThw9AdNEVftjxQOf81gpSLhF4PMZeNAlJM/fAK599nvZLp77JGcii10X
         jjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rCn28/5YMVoix93/RoHK+5/W1grR76h8dUAa1bzWPcE=;
        b=r8nWXLQ6zYoaciVlwqwwH4vkr0axj40NAXqSD358rKasLDa4Bgy1niYoGDUvyHyUI+
         PyLo9varuI7jMEBca3BUPJCM0mzhpcu+kleRUvsoyn2yz6pDkanHKjLFf/Ny4wT1uh/1
         FtHpLZQTdlm8B9wekgOeXFecVvcZVk7Y6If8V46jmOWqW3j8bPm2qu0KuHX4DVoWukX8
         wLGdk5pV7BH4rTeGx2SjlaLyFoHnEN3q4j/hA+btCXGzgLNEL+r6BaZ6XmArfNBKgudi
         LloEfmNydf36IxzydH/ksD+2SVG23c+JE0xZ9siMgrOLjlqlpQd3iWfKhahNk5Y1mlC9
         kI2A==
X-Gm-Message-State: ANhLgQ0oVgzGtnoOVP/L3TVBqaRYbrRcRHQDJXvXNs82GZ1SWSyxCkXR
        7PjEADqKl1gelFm4McTysWHhY5y60MbIrQ==
X-Google-Smtp-Source: ADFU+vuT73Fy7RaAOyfrc4It1U8Z92zhTrQi5Wp7TtSnhXSzbHgd6NRd9eTpSpSeyYMLY8hNjLGKfQ==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr9929294plq.290.1585523080984;
        Sun, 29 Mar 2020 16:04:40 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id x71sm8709037pfd.129.2020.03.29.16.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 16:04:40 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring updates for 5.7-rc
Message-ID: <90978552-6746-1902-888b-4b6150e02b7a@kernel.dk>
Date:   Sun, 29 Mar 2020 17:04:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are the io_uring changes for this merge window. Light on new
features this time around (just splice + buffer selection), lots of
cleanups, fixes, and improvements to existing support. In particular,
this pull request contains:

- Cleanup fixed file update handling for stack fallback (Hillf)

- Re-work of how pollable async IO is handled, we no longer require
  thread offload to handle that. Instead we rely using poll to drive
  this, with task_work execution.

- In conjunction with the above, allow expendable buffer selection, so
  that poll+recv (for example) no longer has to be a split operation.

- Make sure we honor RLIMIT_FSIZE for buffered writes

- Add support for splice (Pavel)

- Linked work inheritance fixes and optimizations (Pavel)

- Async work fixes and cleanups (Pavel)

- Improve io-wq locking (Pavel)

- Hashed link write improvements (Pavel)

- SETUP_IOPOLL|SETUP_SQPOLL improvements (Xiaoguang)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.7/io_uring-2020-03-29


----------------------------------------------------------------
Chucheng Luo (1):
      io_uring: fix missing 'return' in comment

Hillf Danton (2):
      io-uring: drop completion when removing file
      io-uring: drop 'free_pfile' in struct io_file_put

Jens Axboe (17):
      io_uring: consider any io_read/write -EAGAIN as final
      io_uring: io_accept() should hold on to submit reference on retry
      io_uring: store io_kiocb in wait->private
      io_uring: add per-task callback handler
      io_uring: mark requests that we can do poll async in io_op_defs
      io_uring: use poll driven retry for files that support it
      io_uring: buffer registration infrastructure
      io_uring: add IORING_OP_PROVIDE_BUFFERS
      io_uring: support buffer selection for OP_READ and OP_RECV
      io_uring: add IOSQE_BUFFER_SELECT support for IORING_OP_READV
      net: abstract out normal and compat msghdr import
      io_uring: add IOSQE_BUFFER_SELECT support for IORING_OP_RECVMSG
      io_uring: provide means of removing buffers
      io_uring: add end-of-bits marker and build time verify it
      io_uring: dual license io_uring.h uapi header
      io_uring: fix truncated async read/readv and write/writev retry
      io_uring: honor original task RLIMIT_FSIZE

Lukas Bulwahn (1):
      io_uring: make spdxcheck.py happy

Nathan Chancellor (1):
      io_uring: Ensure mask is initialized in io_arm_poll_handler

Oleg Nesterov (1):
      task_work_run: don't take ->pi_lock unconditionally

Pavel Begunkov (28):
      io_uring: don't call work.func from sync ctx
      io_uring: don't do full *prep_worker() from io-wq
      io_uring: remove req->in_async
      splice: make do_splice public
      io_uring: add interface for getting files
      io_uring: add splice(2) support
      io_uring: clean io_poll_complete
      io_uring: extract kmsg copy helper
      io-wq: remove unused IO_WQ_WORK_HAS_MM
      io_uring: remove IO_WQ_WORK_CB
      io-wq: use BIT for ulong hash
      io_uring: remove extra nxt check after punt
      io_uring: remove io_prep_next_work()
      io_uring: clean up io_close
      io_uring: make submission ref putting consistent
      io_uring: remove @nxt from handlers
      io_uring: get next work with submission ref drop
      io-wq: shuffle io_worker_handle_work() code
      io-wq: optimise locking in io_worker_handle_work()
      io-wq: optimise out *next_work() double lock
      io_uring/io-wq: forward submission ref to async
      io-wq: remove duplicated cancel code
      io-wq: don't resched if there is no work
      io-wq: split hashing and enqueueing
      io-wq: hash dependent work
      io-wq: close cancel gap for hashed linked work
      io_uring: Fix ->data corruption on re-enqueue
      io-wq: handle hashed writes in chains

Xiaoguang Wang (2):
      io_uring: io_uring_enter(2) don't poll while SETUP_IOPOLL|SETUP_SQPOLL enabled
      io_uring: cleanup io_alloc_async_ctx()

YueHaibing (1):
      io_uring: Fix unused function warnings

 fs/io-wq.c                      |  368 ++++---
 fs/io-wq.h                      |   65 +-
 fs/io_uring.c                   | 2015 +++++++++++++++++++++++++++------------
 fs/splice.c                     |    6 +-
 include/linux/socket.h          |    4 +
 include/linux/splice.h          |    3 +
 include/net/compat.h            |    3 +
 include/trace/events/io_uring.h |  103 ++
 include/uapi/linux/io_uring.h   |   42 +-
 kernel/task_work.c              |   18 +-
 net/compat.c                    |   30 +-
 net/socket.c                    |   25 +-
 12 files changed, 1826 insertions(+), 856 deletions(-)

-- 
Jens Axboe

