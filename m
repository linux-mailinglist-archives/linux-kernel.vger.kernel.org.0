Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8348F12BE37
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 19:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfL1SCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 13:02:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40908 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfL1SCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 13:02:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id w21so32850193otj.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 10:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=kBKkmy9BwwAux87beG9h8Fp0xilQf5cdOHcpgLVKCzg=;
        b=AXvXFlQdTAE7rim4WIdHBvKlsGT7J0nY/skfxD+/WwbD3BYPIL+wrwHem4i2AQUS5l
         pGOgEojPvOOLHzD/ZEEt2FEpppJLwqGpLQjBsYYYiAGI0PdwSLRUmx7MqKaoFG8XFQo9
         ZHRucm9h0aJcnt4RTWSHhaG4zDXROO5FnVYgJz7aUJJqYgkWRfHwWHOTZEa8cZ5I6Hvx
         eTf+yJzLLZ2k5+wYqgGEdy2pBMay5MtSeIUkn50LAAlLtd4CQazZzzPjVRg6UDBLG4QK
         yr0wicbZpawXLbhMzzrbdbovb36eobUrlYHFIQhvfS8kgzC6M+uJzdViVegYq/MWHYaf
         3OWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=kBKkmy9BwwAux87beG9h8Fp0xilQf5cdOHcpgLVKCzg=;
        b=CLJBr4PHOTTVWlGBSIqJNHPyEQbKiu3CVWfU3FAArBvs9u9zueAPQNU5yIwlJXzozp
         fc3CGsx5Rl6U2wb31ACJFq6ydJpg2/pXMqLb4UdMVJcWjuFv9FC6UWConl7KDs5wiKZe
         V7T621AegU1NkaPVsTPeOxpCl3eBkB1zXw4Vu1sh+Kk4q9JCK9a3XpMgdY9Po92k/FKq
         K3jEAyBY5aOmtrebF302QWHJfrQxx1E5OoTaP3YwttqFUjsWv6r2XwSPqyq2b72E54K/
         mTy0Ry+fsOGwNG35hIA5KjErjEJJRrEJDAUAjMpFHbA5N+1fhj2mx6gTlIiFoFoQuppa
         2wzA==
X-Gm-Message-State: APjAAAXEqIcc2LuF+ZYnldQzoTwDKZ4nKlydXK4pTWx4K8D6mobDmp/X
        AfT+mICRCSXPA8eGDmAElRvw0aziGOkzU7iOl3ZqOg==
X-Google-Smtp-Source: APXvYqz7zTVQLFkJ2RW6QJmmkfZUvYk3NTC8wROyUI0CT2PkyOXqHHtOeVsm2YHf4fjjMII8aRWkplH8JfXvh8Oy1cg=
X-Received: by 2002:a05:6830:685:: with SMTP id q5mr38946145otr.208.1577556144207;
 Sat, 28 Dec 2019 10:02:24 -0800 (PST)
MIME-Version: 1.0
From:   Francois Saint-Jacques <fsaintjacques@gmail.com>
Date:   Sat, 28 Dec 2019 13:02:13 -0500
Message-ID: <CABNn7+pYPSfduacOATcKT1X_=qs70i7Bc8pELXDahY7BoB9_wQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf inject --jit: Remove //anon mmap events
To:     jolsa@redhat.com
Cc:     Steve.MacLean@microsoft.com, eranian@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd just like to weight in that this patch fixes the issue Steve
mentioned. I have a local experiment using LLVM's ORC jit with jitdump
support and couldn't get any symbols recognized by perf until applying
this patch.

Thank you,
Fran=C3=A7ois
