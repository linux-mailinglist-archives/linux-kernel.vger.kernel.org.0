Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7738A2AA8B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfEZPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 11:52:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45122 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbfEZPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 11:52:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id n22so2604205lfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHoFdmqYPstpJxz64t3x628SCZa/yDvhSqOoPOA4w6g=;
        b=HiVrlb3j4Y5yNwh6/jTPn8HCpEbqXkEXDwOcla5O5f8dWYrdyYwvVOYh79ZPa5sLuR
         posfmVSL3U7+kfupnep0eUcaME8BznR+rnxBQnRGiLRiCqJigRr8Gn1qraU3yTBtQxsN
         V4wSIbMLLzvD35ihMOTj7pcvMESgxu3h5Wr1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHoFdmqYPstpJxz64t3x628SCZa/yDvhSqOoPOA4w6g=;
        b=q1Tv1+n0Y6ZJ9Vj/DBgQ/vZS4zyDevUycNNjvZcLho9N6VWYvztnVJ8me0DnJxP6ft
         fkKzOZzoanm7M9dwETgLeSpR2e5lX/KpOAFp+YlnaL9HNZkPnSsh0PssFPExGxiCfSIf
         Tqhzm+R2NAauC2RB5tMUe+iXNXVQ02+ZotGZrkQhwnbcGuoBzwOCNKRyaeS34iaLB3+E
         r9XsQLP7URSoYl6XKCw1OZY1tGEl9kyyaPSreKOVf35YK/E/Z1VuZz9qDamCIojx0xbS
         6b4rLFU3QbDZx/3mOAaOtQBRH9CpDZ7Aq7FWLfUxM0r/5Q+BBUIbzSyyid+Tk6yfYRkP
         iKhg==
X-Gm-Message-State: APjAAAUIdIdIOLZ9x4UxofeKWLr20y2jfiA1WSnMGgzi9gGS3uvV4oBP
        +p9XytFBJLhBlIOlpjH+UWAYpoQf0P8=
X-Google-Smtp-Source: APXvYqyq0YgUzEZEliMLL/q3dTI9lZ1oLa6i7gonwDbByXuuaxOs+I2nHzJe/S1IXeqsqjj//+ESOw==
X-Received: by 2002:ac2:429a:: with SMTP id m26mr17748777lfh.152.1558885928128;
        Sun, 26 May 2019 08:52:08 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f11sm1745739lfa.48.2019.05.26.08.52.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 08:52:07 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h13so10334080lfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 08:52:07 -0700 (PDT)
X-Received: by 2002:a19:7418:: with SMTP id v24mr12467788lfe.79.1558885926829;
 Sun, 26 May 2019 08:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <1558864555-53503-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1558864555-53503-1-git-send-email-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 May 2019 08:51:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3YcO4JTpkeENETz3fqf3DeKc7-tvXwqPmVcq-pgKg5g@mail.gmail.com>
Message-ID: <CAHk-=wi3YcO4JTpkeENETz3fqf3DeKc7-tvXwqPmVcq-pgKg5g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 5.2-rc2
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 2:56 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>   https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

This says it's a tag, but it's not. It's just a commit pointer (also
called a "lightweight tag", because while it technically is exactly
the same thing as a branch, it's obviously in the tag namespace and
git will _treat_ it like a tag).

Normally your tags are proper signed tags. So I'm not pulling this,
waiting for confirmation.

               Linus
