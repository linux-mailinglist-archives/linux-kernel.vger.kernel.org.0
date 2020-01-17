Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6A0140C91
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 15:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAQOdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 09:33:19 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:33315 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgAQOdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:33:19 -0500
Received: by mail-pl1-f170.google.com with SMTP id ay11so9950740plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 06:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=w4mp3hsKOArV78Fh9THmePV3c421RHxulbG70WLaTp4=;
        b=eqXflPFuuamkC1dxHfVih0Dj2pBPqEkO4/H0rMCRtDNvHwZgbkHR13FKZyhkKvu7be
         Qv/iPkXTtzSY4uhWfe9sCrh88KI7jbsKHwe5Re+NHjLOFtVcmsh7nPI8BxJ1qHt7S59W
         uGZoQLZ4b9zCqSaZBxXoY8uP5Yy3wwbgMrvK+Y+PuHOw+eeTujlkeBb8XUF8lYQtKDU+
         vt1RVkUWp7m7ldiTe3YbeUSRV4+Sp2julnGyUaD4ukaCbcPAtiIL1bYmTGHPeY/3eah7
         oKo5TJ1cJIHzNHKvXcL9uvmOf2YndiXZKffTvkqOU81wMb6GYo/bvvRbwqG6acshfEsK
         luXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=w4mp3hsKOArV78Fh9THmePV3c421RHxulbG70WLaTp4=;
        b=fjVmFchu/nP8zzapgcAntcpweE0V3X2CsKb+PN9X1BQv3PUug6Se+UEuzMQTOqM5QJ
         T3QfAouAGNXl8+EBP+pHp+a9QWXzXJVAnEXwad1ySmCMbed930Yu9yiyM5Er9CwvlSt+
         sJV5hqKsKf2/6+JWoYzAjyvtU4BzeoupIiMc0Qy8nKn7XsVyIvFxfSMG6od4/xjQV5j6
         GaYTjh8VYd+xgGa50nuLuBCt0I7ti8rgq5vS8vqJpuwA6MDoX38Mm9LSxvd4Yj3eLhVF
         mQ/ZPTa+P/kLWSbL93rHGPGVtz0AD7Nu0asCniX2/T7FnRKu13T9WDUuVOaEkQtWzZU6
         bfKQ==
X-Gm-Message-State: APjAAAUlhWr1Wo2P1rdFPGSlQKr8cfa0GC+TZuZLmPr4MHwrSMpQMI2O
        9PWNUpO1e4BuS+XRFj5ckoxKTRN0biM=
X-Google-Smtp-Source: APXvYqy3SNNpATed1MOyfomAGHqYY170zILmu6a0D/TplCHXTJqzBxhRkSyWNeyLP4Z/AmC9I7R5VQ==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr35417493plk.209.1579271597816;
        Fri, 17 Jan 2020 06:33:17 -0800 (PST)
Received: from [192.168.1.182] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id b8sm30023821pff.114.2020.01.17.06.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 06:33:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.5-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <48229b93-5e4d-78a2-3171-021e2a87c99b@kernel.dk>
Date:   Fri, 17 Jan 2020 07:33:15 -0700
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

A set of fixes that should go into this release. This pull request
contains:

- Ensure ->result is always set when IO is retried (Bijan)

- In conjunction with the above, fix a regression in polled IO issue
  when retried (me/Bijan)

- Don't setup async context for read/write fixed, otherwise we may
  wrongly map the iovec on retry (me)

- Cancel io-wq work if we fail getting mm reference (me)

- Ensure dependent work is always initialized correctly (me)

- Only allow original task to submit IO, don't allow it from a passed
  ring fd (me)

Please pull!


  git://git.kernel.dk/linux-block.git tags/io_uring-5.5-2020-01-16


----------------------------------------------------------------
Bijan Mottahedeh (1):
      io_uring: clear req->result always before issuing a read/write request

Jens Axboe (5):
      io_uring: don't setup async context for read/write fixed
      io-wq: cancel work if we fail getting a mm reference
      io_uring: be consistent in assigning next work from handler
      io_uring: ensure workqueue offload grabs ring mutex for poll list
      io_uring: only allow submit from owning task

 fs/io-wq.c    | 12 ++++++----
 fs/io_uring.c | 72 +++++++++++++++++++++++++++++++++++++++--------------------
 2 files changed, 56 insertions(+), 28 deletions(-)

-- 
Jens Axboe

