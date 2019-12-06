Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51559114AFB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 03:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLFCi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 21:38:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46609 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfLFCi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:38:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id a124so4760354oii.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 18:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFmFb2O60k6iYs0X9+H/MSbUhF0d/S8/aF7lYjok+wI=;
        b=H8QBSUvC9VM0kHXxxjTDieQkuTjcuspYdm6y0f3H5m7hmfmANioFe6hykGF1SbIliu
         4t0UNZ0siJUXyKFQeKI0J2TimHjiSkfomA/6Oc+S2JvBYebQVfOx/ltO/m3WL1NLYDhL
         sk2sBvM5DiRLb53l9K3OTrESzXmChN8G2NEjrgZb1DaHqwLuVSZqgMJVrUJ7WNQ4D4ei
         BnFntV5sYwf5zJm378oe7bxWkBmYhc0TLpYReaXshBE78StM11noZt17Xp0XzzPyzZ40
         V/13612qYEx0/M3cF1ad4jteC3NUEd9hBMphnZw7D6aFMsZM9ZpUfgear0kPWY3Y3Xoa
         qFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFmFb2O60k6iYs0X9+H/MSbUhF0d/S8/aF7lYjok+wI=;
        b=KHCWHxFvCmowqfTitn3MdJDN5GwF+IrwgTOM3SLWb+sC9QMzv1l7lj5qKZmCpJrOVF
         2j2RWF7KBdt0U6+0wlR7L3m7jm8LWF+b2cSX12sShwbB1EUkO709zhMF9trvqUUnyd+A
         P1T2uR7nXgw5qR459P0t1IdkszaXZ2JRoT+KnWUucfasSzBjDwBSnY7QghSolmT3R+s7
         Rwdq4arblA6x6XzFSVKi8kBMh08N955elWGnTofbohxu251WYeKNNI7X/nCc+G4jejiq
         Pqtxp0eNVuwaVIUGdZDHbHZaa2WNFj1vI3B+eV1zt77nSpqFmKeub/eG66lb8E/kr3Xz
         PH3g==
X-Gm-Message-State: APjAAAWWKIYj9DcbY79W3NqmV2dumPC6ZF6Xu4vkgfyVKj+KHBuj3Ybv
        rIuMrIgcgdJZkq9kjwLWU3gkOOnkqf7Yo3prWvLfWg==
X-Google-Smtp-Source: APXvYqzwXU223F+0XlzUaImmKzMdZdwa0cr+l7ZWdarNmNLMust8g0URrRh3mKNVmkOXtSRpObM5+QdRweiMyUIe/ao=
X-Received: by 2002:aca:c7cb:: with SMTP id x194mr10763839oif.157.1575599935867;
 Thu, 05 Dec 2019 18:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 6 Dec 2019 03:38:29 +0100
Message-ID: <CAG48ez0_CCxO=stFvK=4G4Og=xe9Rtws8PEVy-cSmLqcxfE2Zw@mail.gmail.com>
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GETFD request
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 12:44 AM Sargun Dhillon <sargun@sargun.me> wrote:
> PTRACE_GETFD is a generic ptrace API that allows the tracer to
> get file descriptors from the traceee.

typo: tracee

> The primary reason to use this syscall is to allow sandboxers to
> take action on an FD on behalf of the tracee. For example, this
> can be combined with seccomp's user notification feature to extract
> a file descriptor and call privileged syscalls, like binding
> a socket to a privileged port.
[...]
> +/* This gets a file descriptor from a running process. It doesn't require the
> + * process to be stopped.
> + */
> +#define PTRACE_GETFD   0x420f
[...]
> +static int ptrace_getfd(struct task_struct *child, unsigned long fd)

I'd make the "fd" parameter of this function an "unsigned int", given
that that's also the argument type of fcheck_files().

> +{
> +       struct files_struct *files;
> +       struct file *file;
> +       int ret = 0;
> +
> +       files = get_files_struct(child);
> +       if (!files)
> +               return -ENOENT;
> +
> +       spin_lock(&files->file_lock);
> +       file = fcheck_files(files, fd);
> +       if (!file)
> +               ret = -EBADF;
> +       else
> +               get_file(file);
> +       spin_unlock(&files->file_lock);
> +       put_files_struct(files);
> +
> +       if (ret)
> +               goto out;
> +
> +       ret = get_unused_fd_flags(0);

You're hardcoding the flags for the fd as 0, which means that there is
no way for the caller to enable O_CLOEXEC on the fd in a way that is
race-free against a concurrent execve(). If you can't easily plumb
through an O_CLOEXEC flag from userspace to here, you should probably
hardcode O_CLOEXEC here.

> +       if (ret >= 0)
> +               fd_install(ret, file);
> +
> +       fput(file);

Annoyingly, this isn't how fd_install() works. fd_install() has
slightly weird semantics and consumes the reference passed to it, so
this should be:

  if (ret >= 0)
    fd_install(ret, file);
  else
    fput(file);

> +out:
> +       return ret;
> +}
