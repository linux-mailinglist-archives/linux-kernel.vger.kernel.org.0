Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B0641C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 09:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGJHPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 03:15:32 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41560 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfGJHPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:15:31 -0400
Received: by mail-pl1-f202.google.com with SMTP id i3so840567plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0pW1BcsjTPSHyEkMo96k/o71l5W8M51wh7ZyhpVzADM=;
        b=mHi2l865KLWjgVk77JKmNtYGZe0xgmJqUcNAffie+cN+57XolMX3GDCpJ2ZH1ceLYR
         MfFyvnNY0Qwe0x/ZOIiekj7NzIlsbUZDTxthSd/LJOgqPFNF5dEsFtGMwPVF/nYSdHyJ
         3VdZcCGqzormHX3dS/yuInQiUg9E6laAPfQmLbGCGEz4HepJhwqJgmDJF7yj1dr6aCix
         Siqg+NV9jVwUY3x9AB0/e1BJUu0lC4cmATkNcO/Wd9E8nEXdmqgE1jZEc5mwC0ai37Am
         Pbg5JO4uqte1qi5grtXQRrH7O14tsuFUMbYzcI0pjXuihXi7w4+aV03+iVTZpiuzAPq1
         67HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0pW1BcsjTPSHyEkMo96k/o71l5W8M51wh7ZyhpVzADM=;
        b=J7+tjjGx6K7KAHByTtF/3pspIHEVIwzCKDD8YmuWsTBYC18841JtboTJqMxCf9pRbn
         YtrEaKHizX09qrUainhgKnlISMaSGoXydMY39AUvR019Zcw1MBpDd/ErUo52xqs1uYIh
         ReHYaLEHfxpK/2XwrS8SGr6Ui5o23GM6vYqWmrSHXYbbubnHxNefkNPCDQRvCqImL4Z2
         11748SCtpLuvXXqQ9nPR52OixU21peZHT8iOScTZDgD/B4YeDuh75lrK7hulSWNy/5pk
         9yTZulaIfs5mK1LvqHwnxJcCjToYJSaMe+gwgQEEDo/T5uz4+MvB8hoDTGXkhK3pVIFo
         GAzw==
X-Gm-Message-State: APjAAAWeQK7ILwRw40aBDjCfGn7z+F81VuF/oH+xpBvnnpTYWEeVx85d
        F7wZeokE0U9TKpi1XmrA3MNwzaviIFRcwY3BWdDo2A==
X-Google-Smtp-Source: APXvYqyb0LRYaKSRSGjVUbWvUV4R01ShtwO7/fsNXpVB/VnszhSBSXJqqHQquziMhALgKYKtHVI7t5pL3wpE0iRmNMtOpg==
X-Received: by 2002:a63:1f56:: with SMTP id q22mr33295799pgm.315.1562742929971;
 Wed, 10 Jul 2019 00:15:29 -0700 (PDT)
Date:   Wed, 10 Jul 2019 00:14:50 -0700
Message-Id: <20190710071508.173491-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

## TL;DR

This new patch set only contains a very minor change suggested by
Masahiro to [PATCH v7 06/18] and is otherwise identical to PATCH v7.

Also, with Josh's ack on the preceding patch set, I think we now have
all necessary reviews and acks from all interested parties.

## Background

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
(however, KUnit still allows you to run tests on test machines or in VMs
if you want[1]) and does not require tests to be written in userspace
running on a host kernel. Additionally, KUnit is fast: From invocation
to completion KUnit can run several dozen tests in about a second.
Currently, the entire KUnit test suite for KUnit runs in under a second
from the initial invocation (build time excluded).

KUnit is heavily inspired by JUnit, Python's unittest.mock, and
Googletest/Googlemock for C++. KUnit provides facilities for defining
unit test cases, grouping related test cases into test suites, providing
common infrastructure for running tests, mocking, spying, and much more.

### What's so special about unit testing?

A unit test is supposed to test a single unit of code in isolation,
hence the name. There should be no dependencies outside the control of
the test; this means no external dependencies, which makes tests orders
of magnitudes faster. Likewise, since there are no external dependencies,
there are no hoops to jump through to run the tests. Additionally, this
makes unit tests deterministic: a failing unit test always indicates a
problem. Finally, because unit tests necessarily have finer granularity,
they are able to test all code paths easily solving the classic problem
of difficulty in exercising error handling code.

### Is KUnit trying to replace other testing frameworks for the kernel?

No. Most existing tests for the Linux kernel are end-to-end tests, which
have their place. A well tested system has lots of unit tests, a
reasonable number of integration tests, and some end-to-end tests. KUnit
is just trying to address the unit test space which is currently not
being addressed.

### More information on KUnit

There is a bunch of documentation near the end of this patch set that
describes how to use KUnit and best practices for writing unit tests.
For convenience I am hosting the compiled docs here[2].

Additionally for convenience, I have applied these patches to a
branch[3]. The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/rfc/v5.2/v8 branch.

## Changes Since Last Version

Like I said in the TL;DR, there is only one minor change since the
previous revision. That change only affects patch 06/18; it makes it so
that make doesn't attempt to scan the kunit/ directory when CONFIG_KUNIT
is not set as suggested by Masahiro.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2/v8

-- 
2.22.0.410.gd8fdbe21b5-goog

