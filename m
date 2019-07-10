Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C58862872
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 20:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbfGHSlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 14:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729653AbfGHSlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:41:39 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58899218A4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2019 18:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562611298;
        bh=9b+F9Hz2Y8H30aHHRkvQc01Q7Gs78aUxtvRFMnILt3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OnNVgf1rZbBMbAWkEZG9n1IHMujVjDuznYtf/hnsn2YAox4EKwjgaIJWzkXaX6LrW
         UQAiKDXo78OuVnUovg1Mf9shF92U8eiLohG7+Ne3CYBLdJB45xqAb1Sb1Be29aTzLb
         o8soStEKYoAPIgsT3nwmxxKs9S5Zo4TYRzAQB6Ic=
Received: by mail-wr1-f43.google.com with SMTP id x4so18256934wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 11:41:38 -0700 (PDT)
X-Gm-Message-State: APjAAAXhVuPqXAIo0ixfXNbQnWKbSwZh/FLBZL50xhkzFZkNzI5wc3Bo
        UYewR58w4HO7FSDBwxl2H6yBXizCvmAeUz0NX6Wjtw==
X-Google-Smtp-Source: APXvYqxsE7s1ia4AbKYPETOCZMSh2gisu3dfbsZTERM0bNvLfjbUFoq3TDYsJasURAGEV1lypQ7vx3YhaFsgJZ2mNOE=
X-Received: by 2002:a5d:4309:: with SMTP id h9mr19471591wrq.221.1562611296902;
 Mon, 08 Jul 2019 11:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190708090627.GO17490@shao2-debian> <20190708182904.GA12332@altlinux.org>
In-Reply-To: <20190708182904.GA12332@altlinux.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 8 Jul 2019 11:41:24 -0700
X-Gmail-Original-Message-ID: <CALCETrUAMh-U1a3a_YBw0V8oQHhVKteMOwdUYwzQJi8HVeVWWg@mail.gmail.com>
Message-ID: <CALCETrUAMh-U1a3a_YBw0V8oQHhVKteMOwdUYwzQJi8HVeVWWg@mail.gmail.com>
Subject: Re: [PATCH] selftests/seccomp/seccomp_bpf: update for PTRACE_GET_SYSCALL_INFO
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 11:29 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> The syscall entry/exit is now exposed via PTRACE_GETEVENTMSG,
> update the test accordingly.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
