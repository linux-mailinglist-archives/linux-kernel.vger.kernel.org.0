Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA87014EA00
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 10:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgAaJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 04:24:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40542 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgAaJY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:24:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so7827139wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 01:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSXbMxnOg8YIX/3kR6+7l+XVNm8PvjjA37JEVs4qXJA=;
        b=ui7hbxTOZhC0wBm4XNnnM0Qrgnmx1S1n0GrL/Laudw0hYYdsR1GLIa9vOUBxjFZlHz
         HhUqsfWj+95bLSa2fDIqoAy2Sju/2K+fz2mPXDywWxSV9lAQNBE+sibovuiLHGDn2Prc
         ts8yBm+V8hKRLucF6mM+5eGEnjgbMResPLnLf/15pN9uHZtj/qWPBth7G5O0cFI62R1Q
         rPrruQnZ0uu+PVy+Lx2pwT4PKKZcD3H/USUe5xcWlKF+KPCBZ78CkF8gtcKU0r32MACG
         ZVt+ZjVbWcZ5MHz/pAqB1m1kSJWBdYp4SL6FZcgsZMg868zQsB2SMjufSaUHf2HvDowP
         s0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSXbMxnOg8YIX/3kR6+7l+XVNm8PvjjA37JEVs4qXJA=;
        b=a+GKuvU4zEf906rpStjVpkhoa2s+dCQjZAtJKX5oiGfPVNrCw667VYXON9czwF4mbi
         8tBol6wNqux2xmTpAevCFRTy+bguDUGizNcR5T9yxFyyuiHW6/PPqWz2sAiwwo/i17Zh
         +Ga5mmTI3aoCOpCEu935DIW9fHZxUMGl7ycHQF/rxUDUsW0JE88tDHyHX0At3J+mMUTl
         ZRrkgtul6ycJke6dul8fa6/xX+jYU+Wx54qo7DuYip2EtmqllVH4AVy1+qno3n8sAWLD
         999do4PvEhrIjtYCg7gDhGO5PdoTLSWlEe8ECsS5eDvFlmOgVUFzPskq109uT0mfbdI/
         kC1w==
X-Gm-Message-State: APjAAAVsRMZaF7H5TQ/52Jn5xREgO8gAW09heM3POMr1zz8vA1lwJNLp
        1rh7MbBvPIbj4JhzWYELLHdFXA==
X-Google-Smtp-Source: APXvYqwIzUPuurz2q/j3XhmwutPdbx25t66VPpjsBDm8EXvsA9RKUuu8D/EHwhxi1yQ72R9rcNqNdA==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr11703127wmc.168.1580462695648;
        Fri, 31 Jan 2020 01:24:55 -0800 (PST)
Received: from localhost.localdomain (88-147-73-186.dyn.eolo.it. [88.147.73.186])
        by smtp.gmail.com with ESMTPSA id 16sm10144364wmi.0.2020.01.31.01.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 01:24:54 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/6] block, bfq: series of fixes, and not only, for some recently reported issues
Date:   Fri, 31 Jan 2020 10:24:03 +0100
Message-Id: <20200131092409.10867-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
these patches are mostly fixes for the issues reported in [1, 2]. All
patches have been publicly tested in the dev version of BFQ.

Thanks,
Paolo

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1767539
[2] https://bugzilla.kernel.org/show_bug.cgi?id=205447

Paolo Valente (6):
  block, bfq: do not plug I/O for bfq_queues with no proc refs
  block, bfq: do not insert oom queue into position tree
  block, bfq: get extra ref to prevent a queue from being freed during a
    group move
  block, bfq: extend incomplete name of field on_st
  block, bfq: get a ref to a group when adding it to a service tree
  block, bfq: clarify the goal of bfq_split_bfqq()

 block/bfq-cgroup.c  | 12 ++++++++++--
 block/bfq-iosched.c | 20 +++++++++++++++++++-
 block/bfq-iosched.h |  3 ++-
 block/bfq-wf2q.c    | 27 ++++++++++++++++++++++-----
 4 files changed, 53 insertions(+), 9 deletions(-)

--
2.20.1
