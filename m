Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE85014865A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 14:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbgAXNrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 08:47:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44283 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387592AbgAXNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:47:35 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so1137346lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 05:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QuykXdQgCukrm1B7kCx5H9azkbpe9JqxdJC6IEPLP7E=;
        b=J6a8hcIIm8TiHH7TFIWcKGNByxaxpGVHUBzfqcswFSaQJIo67XSe+jI/5Aig5QGp4s
         8XAFZy0uXAlv4BOPy6Nwt4EsB7ZUkY0d1YxQYyue+MTYwG3flz/z5ihFeuf3WZ8J6CIP
         8hwkBKpr/ICPb57F9QAD17waDv9EeQa/p0d+RZ1Mnu+2XyUzTayfF0I7zLCsASBZ4Nml
         +86CQYFlR6CTNLxUB/FSwpAj6OmSZL3Eg9Eg6iHx6H3ctM9+43zA2HvmS+ONA99hROS5
         uyxyVQm4aZioTXCoKkIoapHgljJESHoNAa5iE+sfndupMYXEJAjKiX6BCCAkJnu36xGm
         N4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuykXdQgCukrm1B7kCx5H9azkbpe9JqxdJC6IEPLP7E=;
        b=rqhIhgxRKZ5SEJ7rMSJx0IGlZ/bF7nQ8OfeJH2q2WivaaeRH+p8n+bOSgxiR9ojaRr
         5MQQ/54Yp7w3f58/+Pz5skvIl0t9A9Pojtm/t4o8t7L4IeCuC+0VkcHVxvWQFaQgEkRF
         /c8NJGMj+DR3JowgWR8jstbNQ0l026MyEY3E1dcwSxeAaQbhUBPLTyYVXSKAf3afjyA0
         AmSn+h77Rw6a+gkNa7s7gitjbVmllC9diCywWe9odWctLunU82LHxiicmkkW7OnaWRb/
         iY3387o2bgLKFgjRBwX+UCPGnNWElmXEL+0BmGEhGjT+CShQjBbjB/PJVWagjD59UqfE
         34wQ==
X-Gm-Message-State: APjAAAVm1anZiaaOmBGx0SxJct5dNQfiH7Li42i70yK/HgMZRIISw0kH
        tAbp/R/SXxvgnQFfam7S8ahOrTHIg5JptBVdCg3l8w==
X-Google-Smtp-Source: APXvYqxSRivfVrVbecQRjiQSIldNxUXvYMaxmjaf7gMkpNKfFesNvQYGQkxZKCv7eNPDJcp9U+KT9AiBpzwGKyEexqQ=
X-Received: by 2002:ac2:5b41:: with SMTP id i1mr1457644lfp.82.1579873652504;
 Fri, 24 Jan 2020 05:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20200124092806.004582306@linuxfoundation.org>
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 Jan 2020 19:17:21 +0530
Message-ID: <CA+G9fYtxRoK6D1_oMf9zQj8MW0JtPdphDDO1NHcYQcoFNL5pjw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/102] 5.4.15-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 at 15:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.15 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Jan 2020 09:26:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.15-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> Andrii Nakryiko <andriin@fb.com>
>     libbpf: Fix call relocation offset calculation bug

Perf build failed on stable-rc 5.4 branch for arm, arm64, x86_64 and i386.

libbpf.c: In function 'bpf_program__collect_reloc':
libbpf.c:1795:5: error: implicit declaration of function 'pr_warn';
did you mean 'pr_warning'? [-Werror=implicit-function-declaration]
     pr_warn("bad call relo offset: %lu\n", sym.st_value);
     ^~~~~~~
     pr_warning
libbpf.c:1795:5: error: nested extern declaration of 'pr_warn'
[-Werror=nested-externs]
Makefile:653: arch/arm64/Makefile: No such file or directory
cc1: all warnings being treated as errors

-- 
Linaro LKFT
https://lkft.linaro.org
