Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12422D5338
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 01:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfJLXJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 19:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfJLXJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 19:09:08 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5A4821929
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570921748;
        bh=GAvUJfnQ/ekmzshI/omTNt5MUxVTCo8T6Nqip48DUX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uidnwcpykkXAHe3lXfsPP/IMzZrFCiakkJxsK+1yCs0icQJcvPo0Yb+lnCrzIUIqA
         jEyDIB0AMMS6HoZQwJbZ44+MkTMg4cP+/1ftRdYtJ0UQMFccv83s+JTkQqyBHmfC2q
         bPDx6UMkijTnUr0HFcmdTDae2xv7+a8THzC74X4E=
Received: by mail-wr1-f54.google.com with SMTP id v8so15564099wrt.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 16:09:07 -0700 (PDT)
X-Gm-Message-State: APjAAAXDrzM2ZvjDILvUqofy1nDbJIVy1dkkGSwvieVDzBBIGZ87keFb
        U7guvpwjPkPnKOgZBo+qiiBQms9hwce1Bf3sR3ZBTw==
X-Google-Smtp-Source: APXvYqwToLzAnzQSsxAZzU4NTPQigPb3yanedeLHemgxicJ+jgCUwUmcHIr/UI5jamm/XXVoeZciNh4Pn5bou9O+JlU=
X-Received: by 2002:a5d:6949:: with SMTP id r9mr16124264wrw.106.1570921746082;
 Sat, 12 Oct 2019 16:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-5-dancol@google.com>
In-Reply-To: <20191012191602.45649-5-dancol@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 12 Oct 2019 16:08:54 -0700
X-Gmail-Original-Message-ID: <CALCETrVmYQ9xikif--RSAWhboY1yj=piEAEuPzisf+b+qEX4uA@mail.gmail.com>
Message-ID: <CALCETrVmYQ9xikif--RSAWhboY1yj=piEAEuPzisf+b+qEX4uA@mail.gmail.com>
Subject: Re: [PATCH 4/7] Teach SELinux about a new userfaultfd class
To:     Daniel Colascione <dancol@google.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lokeshgidra@google.com,
        Nick Kralevich <nnk@google.com>, nosh@google.com,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
>
> Use the secure anonymous inode LSM hook we just added to let SELinux
> policy place restrictions on userfaultfd use. The create operation
> applies to processes creating new instances of these file objects;
> transfer between processes is covered by restrictions on read, write,
> and ioctl access already checked inside selinux_file_receive.

This is great, and I suspect we'll want it for things like SGX, too.
But the current design seems like it will make it essentially
impossible for SELinux to reference an anon_inode class whose
file_operations are in a module, and moving file_operations out of a
module would be nasty.

Could this instead be keyed off a new struct anon_inode_class, an
enum, or even just a string?

--Andy
