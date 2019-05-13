Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611381BEF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 23:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEMVF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 17:05:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42234 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEMVF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:05:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id 145so7388404pgg.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 14:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=PuHiZ6bpD3R+oXfGvAAa10qnoh2RybG2RxMgpiwud+8=;
        b=cGBIN6gEPReQYJHdC3XFUC41YxHr3wOzcH9C3v0mReW4FEK8LmqtFkgulCGwVe61XN
         vlkdGYajh8nWHv0VPVmtcKx5Jn+nj1IzNuy3eznTEvDZI4NOOLZxKf1K3OOPZ3Vqctxa
         4tE0r7TdHgunTButfUIQAA4mELKzYH10Ukqpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PuHiZ6bpD3R+oXfGvAAa10qnoh2RybG2RxMgpiwud+8=;
        b=eThoOpCmUSy5RYLlDYdaHObE+YBUUNvz3tCJ8b56R7Cv6VlqSb3Bh0HZXXuOU8C8Bn
         BilLt1wXbfBgTqE+n6FXpMhYUei/obuIcjfk3W0y1YWPhWRGcj7x/nvO0H9aNPi2G1K3
         I5EXDe1iUEJtufCiN7RMJz0z44T2RpgwJiXaJBOvZaQWdmiGjXG72QzXIIEF0AFReUqK
         S3lOd5GRlgv0rwZptj+sTxLjZgYJEOJ8n65o5K3yuAl/P4s6PMeZxyE2iIY3JukD69Aw
         XCUuYpURpS1S1dqGh4fWr3MUtuYySPhteYksvOiiT41en5HWdkpNvusXDBiHSY5PMhHK
         o0hQ==
X-Gm-Message-State: APjAAAVXyerGuo1BEEQe7TxgUakRkOX1jn9fwU+lTLmRh3urH247lSLc
        tkKaPfWAYlzjLY5znlMajT3kww==
X-Google-Smtp-Source: APXvYqxPnDnFgVVZ0WHias0NQPwlSvQiGLeKBh6klK0i1uZrVBjB4KR92am4bmYqJ9HLcEnpTBUHFQ==
X-Received: by 2002:a62:544:: with SMTP id 65mr36291992pff.46.1557781527922;
        Mon, 13 May 2019 14:05:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s80sm3209515pfs.117.2019.05.13.14.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 14:05:26 -0700 (PDT)
Date:   Mon, 13 May 2019 14:05:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Douglas Anderson <dianders@chromium.org>
Subject: [GIT PULL] gcc-plugins fixes for v5.2-rc1
Message-ID: <201905131404.7A6A4B8FCA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this build (with older GCC < 6) fix for the ARM
stack-protector-per-task plugin for v5.2-rc1.

Thanks!

-Kees

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.2-rc1

for you to fetch changes up to 259799ea5a9aa099a267f3b99e1f7078bbaf5c5e:

  gcc-plugins: arm_ssp_per_task_plugin: Fix for older GCC < 6 (2019-05-10 15:35:01 -0700)

----------------------------------------------------------------
gcc-plugin fix:

- ARM stack-protector-per-task plugin: Fix for older GCC < 6 (Chris Packham)

----------------------------------------------------------------
Chris Packham (1):
      gcc-plugins: arm_ssp_per_task_plugin: Fix for older GCC < 6

 scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Kees Cook
