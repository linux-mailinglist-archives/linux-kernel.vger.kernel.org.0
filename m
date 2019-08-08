Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4866C8623E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 14:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfHHMvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 08:51:01 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71]:56775 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbfHHMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:51:01 -0400
Received: by mail-ot1-f71.google.com with SMTP id q22so61497552otl.23
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 05:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CEErlphARtaydDqTgQRNdb74yQCEmh25NXbvc/7QiI8=;
        b=C0rrD3GokoVofp/TW+uqTjaehaaHibXQf7w0Nqupm3VfOGrdvv953tmDQSyUWKPQpf
         1WT7TltRfsP5n8uaRU+ptqqJR2sS+gKjvaQfmDuhHT9Hjh9KHlG3ezpWvAV2zY+DMzAu
         RkqSMPGFbq0RMU0G0EFuOVAGLppMfSUr8/CJW/MdLpuIVpeLEBxQHci0TpwGr7ytOfMz
         lnpkZOaSIkAmaUCjW92gdd2uyVPu5LI8f4FIjiYMykDKQ3JGrPxLpJC9lJgl9kq9U5PW
         Lzv04wWRCr0C3zgOAd4HirWYVvO0TN/3SbPA1a1H6AgxZVkuum117oTNrIoTlzXsjJFW
         fwYA==
X-Gm-Message-State: APjAAAUER1eKLJcxzid5VxxnM6xyjuifHex2sOCoR0YFTKLxlK5k1pr7
        pWJLhBZM8Vq//PIH36Px/mxTNQnBg1DwitRrXUP4CMTIWrkA
X-Google-Smtp-Source: APXvYqykHlapjSYrrJt7Y/KfDR8LnW9sAsqXyA6MZtRuOUiOq/wU1wiKae3gCIaBGfyypEIk+jmD4cHVsM90UKTlAQ9FmMS0hk6d
MIME-Version: 1.0
X-Received: by 2002:a02:9f84:: with SMTP id a4mr16736469jam.20.1565268660528;
 Thu, 08 Aug 2019 05:51:00 -0700 (PDT)
Date:   Thu, 08 Aug 2019 05:51:00 -0700
In-Reply-To: <CAAeHK+yzpyCX4dVKwgYXg5oca1yecJ+T5R=6WbEtLzowRSN-9g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d2d87058f9a821f@google.com>
Subject: Re: KASAN: use-after-free Read in dvb_usb_device_exit (2)
From:   syzbot <syzbot+c58e976e022432ee60b4@syzkaller.appspotmail.com>
To:     allison@lohutok.net, andreyknvl@google.com, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mail@maciej.szmigiero.name,
        mchehab@kernel.org, oneukum@suse.com, sean@mess.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+c58e976e022432ee60b4@syzkaller.appspotmail.com

Tested on:

commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1622161c600000

Note: testing is done by a robot and is best-effort only.
