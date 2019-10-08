Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8DCFD7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfJHPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 11:22:20 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33436 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJHPWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:22:20 -0400
Received: by mail-vk1-f195.google.com with SMTP id s21so117341vkm.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaNDrHWuf2YNQdBBfgofGBEnuYpRlrKz3qdtkWdVupc=;
        b=v8a8BLbdp886LwnyKcfcEzNg2DWslLphnhUYmwRCdeDXyhD/wXHxf4UFzmxxSVDOfX
         Y1SLDNnrIm9He9kujuCj924lKLMQu5Z3O+l7M4oWU3xCNqMchlsFmC+n4ehVTSlrfS76
         2ulnZTIoMM5YedI9n6jmBy5xfZxmHnXDV4ysoXI05s5LhCKxOyheUE7elUKrTUdsJ8l9
         CPqMlgBUGzW78/ZkC+FSC3BgoztHmMZbNFcXHrzGI0dLP2Dx8+3rzPcTlTJBPgAEuMny
         8kjO/eWWuhQ8pv7o+C/E/TMu/Yz49mJfamMWzKXbV24ANgzodOhPMegFzlnq2x103GLK
         ZClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaNDrHWuf2YNQdBBfgofGBEnuYpRlrKz3qdtkWdVupc=;
        b=eqtEXTkxG6ZwgkL6UuAk7a68vHC3e6EHfDEY6cb+pj0wXHM+9R1fMHmYBPaosgn9AY
         PLcaaZVfee9yr1EGrjPXKIIIfvxhyxbXzZxijq9NPe/40FzVnciap1782khTE7A1bidm
         HH+IGTtaGjrdAkjKxR5me4wIxYqa2km2Jad8qM4cAkuddKdVVfoQM8OqFBSDPblXte7u
         jn12lFngCItgq/PxSgfSvBnDfohCyCgVg2Sno9SV+D89dSQdlKnHzZii68ndSebzIIys
         puQKrmKJIfLPql6h9zBzkCmGPdc72FNNYQsHhH9eK7bgN9NlUgdhZvGIQsVjO7rvenom
         aNDg==
X-Gm-Message-State: APjAAAWOr9XVeS4ZUfFAXKO2HDgQhNq+qFJmvT3zDl1gnV6SdJt/SytX
        Tif9BL73E70nsLwgJXY49cAzeuANUik1DSAzfLq92Q==
X-Google-Smtp-Source: APXvYqw0cdHQAFUr9qXPA3syc72BDMnRBk0iMwv2cwlFyFw144X/NmOqKsuIGB6TOtCy8QxQCPWIn0sPHjmd721wUpk=
X-Received: by 2002:a1f:5003:: with SMTP id e3mr3693062vkb.35.1570548138747;
 Tue, 08 Oct 2019 08:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191007201452.208067-1-samitolvanen@google.com>
 <CAKwvOdmaMaO-Gpv2x0CWG+CRUCNKbNWJij97Jr0LaRaZXjAiTA@mail.gmail.com>
 <CABCJKufxncBPOx6==57asbMF_On=g1sZAv+w6RnqHJFSwOSeTw@mail.gmail.com> <CAKwvOd=k5iE8L5xbxwYDF=hSftqUXDdpgKYBDBa35XOkAx3d0w@mail.gmail.com>
In-Reply-To: <CAKwvOd=k5iE8L5xbxwYDF=hSftqUXDdpgKYBDBa35XOkAx3d0w@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 8 Oct 2019 08:22:07 -0700
Message-ID: <CABCJKucPcqSS=8dP-6hOwGpKUYxOk8Q_Av83O0A2A85JKznypQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: lse: fix LSE atomics with LLVM's integrated assembler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 2:46 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> I'm worried that one of these might lower to LSE atomics without
> ALTERNATIVE guards by blanketing all C code with `-march=armv8-a+lse`.

True, that's a valid concern. I think adding the directive to each
assembly block is the way forward then, assuming the maintainers are
fine with that.

Sami
