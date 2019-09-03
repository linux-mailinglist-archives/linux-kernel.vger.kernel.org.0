Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBC5A6DC8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 18:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfICQRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 12:17:03 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47491 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:17:03 -0400
Received: by mail-pf1-f201.google.com with SMTP id t65so6181415pfd.14
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UrlqrCIUzfMhHCe5wLYX0g77V45RijxDNiDyP3pgT14=;
        b=kSu3Gk9PM4NfwgdqpreP7IkrcxZKUGfh/Gg2sQoZAg2CdsYxa8/nOjytFhOHd2YQvY
         sDChXAY8pVl0ut4pI8JJimC7cOyd0egf6mtNQrRgTeRRPhG86RGOVUOEOHm74Xvg0TSJ
         ilk0dgeJec4iYaHwUhXXDvtacqrE65ifpiOtnrVSuFXQ6jBzvaqUGoRcTYsid92kONeh
         nsaIodZbK3IpsB54D+2AxH8vC8Pa1ApnCRHrDR46CLc6OcRjEgX4OygtVvPXTFgfl1Fw
         Pm3d5HVb8TQJLgrIL17SUCFT602XI4YiwEeKAzmEfeBcYZma/vBqdO3qUAl1OwUUXSlw
         96CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UrlqrCIUzfMhHCe5wLYX0g77V45RijxDNiDyP3pgT14=;
        b=H3zrX0mFSj2hxeXoK/118Ta6Md+O92WPn5UHmbkVExhyvMUfwl8YXducNDkTobPJSz
         asBwb4U2pmrkO0012UK1S6fVWPbMBCLkuFRM8l7ekDlUb373LXRXSbizoCBbL+3JelcN
         Q4tJhp6TIIe9b4gyKRSfbT/iphf+nRCP/UvUu8O/IQ5xiRijYMdrN3bckBgRMHga+154
         EJxFOyiU9i8InwOI37HbgLrhHkkO7TBsevY24Q2LMPEDJZqqm9v67/+40rByTtdnmA1d
         qi6XIa6jfP/V7lW7U0fxvLwM8XnjLWwWPk0QWnYNz7W5hXNv0GbHcpzG4zPil+RrfBLW
         Pnfw==
X-Gm-Message-State: APjAAAXE3H7u12nTC136enCV+uA/OFiD9KnXnzUo+ozF4mWxPcpARLcg
        XgyMwtmPxnsQlPuFqhWRtDHl7Qtag34=
X-Google-Smtp-Source: APXvYqx514tvSIuvTeW1+JBrh6dQloiVYGBy9lkamMCGeewg5BgyrCFeE8lQdhAeGjwqHdAf0hlbC5cQ+lQ=
X-Received: by 2002:a65:684a:: with SMTP id q10mr31337177pgt.417.1567527422227;
 Tue, 03 Sep 2019 09:17:02 -0700 (PDT)
Date:   Tue,  3 Sep 2019 09:16:51 -0700
Message-Id: <20190903161655.107408-1-hridya@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 0/4] Add binder state and statistics to binderfs
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the only way to access binder state and
statistics is through debugfs. We need a way to
access the same even when debugfs is not mounted.
These patches add a mount option to make this
information available in binderfs without affecting
its presence in debugfs. The following debugfs nodes
will be made available in a binderfs instance when
mounted with the mount option 'stats=global' or 'stats=local'.

 /sys/kernel/debug/binder/failed_transaction_log
 /sys/kernel/debug/binder/proc
 /sys/kernel/debug/binder/state
 /sys/kernel/debug/binder/stats
 /sys/kernel/debug/binder/transaction_log
 /sys/kernel/debug/binder/transactions

Hridya Valsaraju (4):
  binder: add a mount option to show global stats
  binder: Add stats, state and transactions files
  binder: Make transaction_log available in binderfs
  binder: Add binder_proc logging to binderfs

 drivers/android/binder.c          |  95 ++++++-----
 drivers/android/binder_internal.h |  84 ++++++++++
 drivers/android/binderfs.c        | 255 ++++++++++++++++++++++++++----
 3 files changed, 362 insertions(+), 72 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog

