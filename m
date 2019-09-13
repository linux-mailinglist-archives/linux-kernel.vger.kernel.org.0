Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE5DB287D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 00:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404106AbfIMWdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 18:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404024AbfIMWdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:33:54 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8641020692
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 22:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568414033;
        bh=cjHWd/DP/ktp4XlsM94VTm3zAuEBIhGetjG0yqa3Vpo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Shx+YhqmnYQhvRxpDQzXq2LKpo2FsVCT+XFmPwhhAX+tQmtCGIYXSfUWMUztzps72
         ouPOTWKeZK8oS62uraJ5Qz3ywUvgW3NLvFpjWqyEPf2+UL5FgkKqgupinuUXN8HvLv
         oFD88zu2HhTcI+fVcDzei5WGMIebaN/wultrawDo=
Received: by mail-wm1-f53.google.com with SMTP id g207so4213758wmg.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 15:33:53 -0700 (PDT)
X-Gm-Message-State: APjAAAWVafmWyk4el4xF9jchFF0sIUuSbb2ioyZX42EOBl+neD0SrCwo
        v/SVylcGbA6oBPaYJXh3s6iipVkHp1E9FMKCfueM4A==
X-Google-Smtp-Source: APXvYqy9QAudp9O1l3JDGJFrkseEYt0y6LJl89z3ULzFHS1HQQrA3UVVBRPBBAoSKdW9dWWxIwhkRprKBm9C2FfD1xI=
X-Received: by 2002:a1c:5f0b:: with SMTP id t11mr5096545wmb.76.1568414032091;
 Fri, 13 Sep 2019 15:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20190913210018.125266-2-samitolvanen@google.com>
In-Reply-To: <20190913210018.125266-2-samitolvanen@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Sep 2019 15:33:40 -0700
X-Gmail-Original-Message-ID: <CALCETrXDRY_q+-C24qZd3FNMLS2W8yCBOSMOHaA7jiVD-ayVNQ@mail.gmail.com>
Message-ID: <CALCETrXDRY_q+-C24qZd3FNMLS2W8yCBOSMOHaA7jiVD-ayVNQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86: use the correct function type in SYSCALL_DEFINE0
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 2:00 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Although a syscall defined using SYSCALL_DEFINE0 doesn't accept
> parameters, use the correct function type to avoid type mismatches
> with Control-Flow Integrity (CFI) checking.

Acked-by: Andy Lutomirski <luto@kernel.org>
