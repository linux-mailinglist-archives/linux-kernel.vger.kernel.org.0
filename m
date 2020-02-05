Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE6CE153A3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 22:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBEV0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 16:26:31 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:35749 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgBEV0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:26:31 -0500
Received: by mail-io1-f53.google.com with SMTP id h8so3900427iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 13:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tJmiO/yRHhnwlodxj+avzdgR3GE4PT9F+7F0LzH0k+g=;
        b=0ptMGK8jhKOJbEn5RUbmutn53A7d5gaVf9HFzvlU5n8JuxFAR3wWhEBwBNGUoDDe8F
         Elj6qtj7QzMR0tqQUUugRNyLLbBlfQzqC+AwaDI9OxZrftgGPSJJoZSjuMCttGHayIs9
         /tQNtqtSGUN2m07JWu5HloN8yVV50NEWCdZQaLoGS2ZA7AiJ855WtXe6LhRaE/lCLIf9
         hDvVO1nd1P0bRmXm36Xp2lx5rFectdcoaH9176MobHi1QiqK3xbnmbdasoc0qKicdHpc
         8E6HWUtIS3cBW0b2sHp7sHFi68AjUwUPJwsasmLOlCfbD5pUmAt9nXv0fsMPYnZV0iEw
         BWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tJmiO/yRHhnwlodxj+avzdgR3GE4PT9F+7F0LzH0k+g=;
        b=kBAbzvtGlB6W2FWzA6kqGXWQTE/OcoH1vHBLzs7XhWZO5DO1VKq4FlQFNS6+oyV08g
         T2PokKExaZiNGGqBbp/j4LIkLcvLJJlsQ0pKhYIkjnCgUEWfOK+udP+YLhooFH+owtrp
         Aqb7v2vfcyp8hDfTUNiYLwuNzpR2iMcfEArkLpkp/U4Kyt7ARl3yJilmgemvbvEcWvFu
         /4rJWytsyTvSm6jDzGBIOA+kbn8YfRqcnJv8Ug7O0+580wkLV64eaX3MC40YtHR4MyRD
         xgSrcVb64dU88IAj2E4soVhrdbJu809T+dPWEkkfC94AwdTexQZ82DQAd0yscusmVT4e
         sq5g==
X-Gm-Message-State: APjAAAUr7vbdAhumaLVjfKmLEyRqdyqACnGbsLU+V29JlO6SJW22bafX
        A6mpXuVJbRYNkQ/P3iFowZrxPuw2vkE=
X-Google-Smtp-Source: APXvYqxItk6NNe4N9n6njIHHOtNEy3OeZwjfl3bBDogSMzlXIqN5iT6pmDVqIz2tBC/Tg/tACUPs1g==
X-Received: by 2002:a6b:7902:: with SMTP id i2mr28220048iop.67.1580937990618;
        Wed, 05 Feb 2020 13:26:30 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k16sm287338ili.35.2020.02.05.13.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 13:26:30 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.6-rc1
Message-ID: <457eea2f-d344-fa09-7ddb-77ce4cb85aff@kernel.dk>
Date:   Wed, 5 Feb 2020 14:26:29 -0700
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

Some later fixes for io_uring that should go into this merge window.
This pull request contains:

- Small cleanup series from Pavel

- Belt and suspenders build time check of sqe size and layout (Stefan)

- Addition of ->show_fdinfo() on request of Jann Horn, to aid in
  understanding mapped personalities

- eventfd recursion/deadlock fix, for both io_uring and aio

- Fixup for send/recv handling

- Fixup for double deferral of read/write request

- Fix for potential double completion event for close request

- Adjust fadvise advice async/inline behavior

- Fix for shutdown hang with SQPOLL thread

- Fix for potential use-after-free of fixed file table

Please pull!


  git://git.kernel.dk/linux-block.git tags/io_uring-5.6-2020-02-05


----------------------------------------------------------------
Jens Axboe (10):
      io_uring: add ->show_fdinfo() for the io_uring file descriptor
      eventfd: track eventfd_signal() recursion depth
      io_uring: prevent potential eventfd recursion on poll
      io_uring: use the proper helpers for io_send/recv
      io_uring: don't map read/write iovec potentially twice
      io_uring: fix sporadic double CQE entry for close
      io_uring: punt even fadvise() WILLNEED to async context
      aio: prevent potential eventfd recursion on poll
      io_uring: spin for sq thread to idle on shutdown
      io_uring: cleanup fixed file data table references

Pavel Begunkov (3):
      io_uring: remove extra ->file check
      io_uring: iterate req cache backwards
      io_uring: put the flag changing code in the same spot

Stefan Metzmacher (1):
      io_uring: add BUILD_BUG_ON() to assert the layout of struct io_uring_sqe

 fs/aio.c                |  20 +++-
 fs/eventfd.c            |  15 +++
 fs/io_uring.c           | 254 ++++++++++++++++++++++++++++++++++++++----------
 include/linux/eventfd.h |  14 +++
 4 files changed, 251 insertions(+), 52 deletions(-)

-- 
Jens Axboe

