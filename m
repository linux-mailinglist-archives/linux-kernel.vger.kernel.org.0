Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE78F7D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 02:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfHPAJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 20:09:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39635 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHPAJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 20:09:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id z3so1697207pln.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 17:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Bmhf8PVD5dJtgK9AddO0xa1upUkZ6UmEqObX9gGUygw=;
        b=g/cwtFRUJnie4vfNE+kfKj1lR1TiRyNEuVwdAY1iDM2oMDkvNQRPopBFt2AACv1B8z
         983Gy7jmtLNUtCEhVXCX0aUFR0m7mYkc9iO4WydqOtvtn8OwfPTSoRaPcIBcLsbbjpTY
         nzPx9Gqd7qjNWuN/dFaJhHqps9pmNKWOvWrxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bmhf8PVD5dJtgK9AddO0xa1upUkZ6UmEqObX9gGUygw=;
        b=FZqhwX+hG56BrUl3XZVVlfS7aCg1jtramjn/dfYvr9NFZX0zzpFOtpD6jTjqf3HDbl
         fdmzIBJhXzR20dp7uWisE5N+r8gNorjJwS/4INb3MMq3d43l5FPLxHM28UxGZPcS6dzf
         KdQ3RxAsG8jonIzn7YnXRvZdk8ec+57M8CDnsAOPSlrxb0I5a6YEQzIuXYGGvffSVJmP
         xeWmzIh6sO+4GnGsEgjM3AWVIy8Hf6kJxxnSFDsdw1yX/dbxzUzVY3jWlnPwrzQU2w01
         gQTBpBzKoYx4AclFf9oSVlilCJSGF3kl3BC/W+lW5pL9e9Qg5GmHMYC2NpMfQmD7CgY1
         nJDw==
X-Gm-Message-State: APjAAAW59h75ABQCc3Y5xqT0EOJzKEiZ2vgTXrjyJtcn7GOs14sdy++0
        w7DL1efud+YwNscBAgt+sQhAJQ==
X-Google-Smtp-Source: APXvYqybBoOAvisp8F+JZ3q5jUty2R8V65DI77Sn3u4nQ2zi0kHjcTpl9h1Y3GptDlHG/aiHG0TmbA==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr6747611pla.212.1565914193322;
        Thu, 15 Aug 2019 17:09:53 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g2sm4056916pfi.26.2019.08.15.17.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 17:09:52 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 0/3] firmware: selftest for request_firmware_into_buf
Date:   Thu, 15 Aug 2019 17:09:42 -0700
Message-Id: <20190816000945.29810-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds kernel selftest of request_firmware_into_buf.
The API was added to the kernel previously untested.

Also included in this patch series is a fix for a race condition
discovered while testing request_firmware_into_buf.  Mutex may
not be correct final solution but demonstrates a fix to a race
condition new test exposes.

Scott Branden (3):
  test_firmware: add support for request_firmware_into_buf
  selftest: firmware: Add request_firmware_into_buf tests
  firmware: add mutex fw_lock_fallback for race condition

 drivers/base/firmware_loader/main.c           | 15 +++++
 lib/test_firmware.c                           | 50 +++++++++++++++-
 .../selftests/firmware/fw_filesystem.sh       | 57 ++++++++++++++++++-
 tools/testing/selftests/firmware/fw_lib.sh    | 11 ++++
 4 files changed, 129 insertions(+), 4 deletions(-)

-- 
2.17.1

