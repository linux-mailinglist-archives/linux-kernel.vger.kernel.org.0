Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0002F89EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfHLMvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 08:51:02 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70]:52743 "EHLO
        mail-ot1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfHLMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:51:01 -0400
Received: by mail-ot1-f70.google.com with SMTP id 88so5083262otc.19
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dpFe0pxSvvQ3CiqTWvVQ3nfhIYJ6p2bt/fOgk0i68So=;
        b=X+kR0ULoy/qlC8Dwb4ssEb3fqsAHr8ztJvL6ms60W15tEfNMaMNAcB+OMeFxNgXtUY
         WfNrt4a2dNyS/q82szJ+khjSpaHNytgtfoW3c+tVDTjDZSXmbn74dBAfyLE41hV5yzx2
         V1PuXGbzR6yqfAUq4phiBhwMitu/cvriniwTu4XCwsvtq/TG4BgjYN3gz75a3GEm5560
         c6izr3O2bQIiKGrLk/BoW5xUxzGYIpmM3isjyt+E28FnHzUFMC+/0qU8Oh/fvPXeytq3
         dfdIwzdH8VZEEJCJ+4ylSjL7+fBwzaK2kcrEESq9JFtB0hCOt8qJnWQ4I+cmVM+mfvRv
         4Low==
X-Gm-Message-State: APjAAAXMcreojytqjdpvQlObAPyLEq2EuD4T4DYJoDZJCPOCOWkgmZ3i
        zF8ZqDn7xHaI18EAA2dNFJUlJ8Ng0uR7xZO1rJWqd6rEackQ
X-Google-Smtp-Source: APXvYqzeOUNSZLHmIICrYoJx4kMoidLoy3cH2txtjlUjoEvrc0w4LGRMoWRVjXiMwJnpcl9H9P/TLOzvY92piEQmZ4Or2+jAFETO
MIME-Version: 1.0
X-Received: by 2002:a5e:990a:: with SMTP id t10mr14376062ioj.182.1565614261189;
 Mon, 12 Aug 2019 05:51:01 -0700 (PDT)
Date:   Mon, 12 Aug 2019 05:51:01 -0700
In-Reply-To: <CAAeHK+wnqRzpUDfspoXPVw76bAbrZ49JiwkeTj-g3U9zqLjZRg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4c41e058feaf977@google.com>
Subject: Re: general protection fault in __pm_runtime_resume
From:   syzbot <syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel@ucw.cz, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com

Tested on:

commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1341679a600000

Note: testing is done by a robot and is best-effort only.
