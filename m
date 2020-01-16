Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6338113EF58
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 19:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395389AbgAPSOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 13:14:41 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43202 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395373AbgAPSOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:14:36 -0500
Received: by mail-ua1-f68.google.com with SMTP id o42so7957170uad.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4/SSgF43F8oOB5ed/Mu+sVQAJxuMOrgg0eXAd3RvzI=;
        b=jhtLpi9WlDS+egj1OpzohuuS9pQgMd5pKXv8LVi9TmM1esvDD/PbLI6+bFwE6vYUwl
         YbwYAIPyLL2iLWWFZ4ytb5/fY8kOXcb6A2/+9FD7Gi+C+JXHa3WLLW4PAc3A1LG6fGUB
         fcGO38CrloQAqONKKE9kyts4coCH7PcaZdcHpdbxmqab0w+fwQS/lEgAZr4mVDvHpJYZ
         zSX2xCdkYeoNMT4FCcjJ3ScoEaWXWSt7GQBFRFwgocvBKdk4BkZaxg5rW15RDuLSco8V
         obn4/UfOsChIVw5BO4a6LT+gT/AarmEyS+XJlpk0+EheBerIjl/hOt6iDgKZdetSZVhc
         J+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4/SSgF43F8oOB5ed/Mu+sVQAJxuMOrgg0eXAd3RvzI=;
        b=QRdxgyuTe0s/y4LtfObxyaIyp8rJWRQl0SRSg3rv9NUL7peD2nCergVLcs7XyskU1Y
         Ah0A2a0LR37kYeMyfejgUY9mZ5AcPlGS7dxQUyYdhXqBHy7wsvAaF5kyJnrDma23Wa2F
         KjhdLWV189qJxeJKimDpKPGhdjfhLGal5Zc9p1nMwFvDYU26vU3EQVRrqrKFauolX+C9
         9LU+R2+TzZwEx20CNvHMAOLM+iDg1/CAlGv1a4D4/o3k5GQacHBVwZv1rfLEjYGfbXXO
         svNoav03zqKEjejFQQHaf2lRvtC3m0XcTJepYozx5FRSq/GubxH4vF/kvinpCOXXIACH
         4X7Q==
X-Gm-Message-State: APjAAAXfm0VHggWtjGnBrtDWLWY40efwIgKMAIV4n4xeDlbTHW4amgD8
        wbz6xKlFiiH382oJ0z+ciEn7BAkI5pQAlKHJApZwug==
X-Google-Smtp-Source: APXvYqxIIWRmLZKLxckIhAMKbhmdzDCTkxbmnPMWtT8X50l5n92iMdw1uWSvaleMeLdpwMB55APzs6jyZJod3pJATys=
X-Received: by 2002:ab0:422:: with SMTP id 31mr20481306uav.98.1579198475361;
 Thu, 16 Jan 2020 10:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191206221351.38241-1-samitolvanen@google.com> <20191206221351.38241-13-samitolvanen@google.com>
 <20200116174648.GE21396@willie-the-truck>
In-Reply-To: <20200116174648.GE21396@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 16 Jan 2020 10:14:24 -0800
Message-ID: <CABCJKucWusLEaLyq=Dv5pWjxcUX7Q9dL=fSstwNK4eJ_6k33=w@mail.gmail.com>
Subject: Re: [PATCH v6 12/15] arm64: vdso: disable Shadow Call Stack
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 9:46 AM Will Deacon <will@kernel.org> wrote:
> Should we be removing -ffixed-x18 too, or does that not propagate here
> anyway?

No, we shouldn't touch -ffixed-x18 here. The vDSO is always built with
x18 reserved since commit 98cd3c3f83fbb ("arm64: vdso: Build vDSO with
-ffixed-x18").

Sami
