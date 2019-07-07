Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E426961581
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2019 18:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfGGQPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 12:15:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44376 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfGGQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 12:15:21 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so29430933iob.11;
        Sun, 07 Jul 2019 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPjV5oIkkTKWgs8bzuMudxn+m/34k9ESgX/d9EjKBY4=;
        b=TWOzKVhtLNsWGzSmCaNZ6b/RZ3+Q0QunAQWRvFiNWs1RisWJjT0tbEfSaH4szCiWfq
         82uSZ4Xvjt6zWF5p026f32NIV/sy/6hd5AsJxTSsxrgwzMPdbEP44HkqaP+B9Q8QLvGY
         ECPuLqNdhl4Y6DYcbNZMIdDn10XiRwz+pYUe3zKKKxaTqkouVwh3CpK/NeQ4lfy4Qzci
         /LwMAd/E0YTYFdoEsh6AH3BYOxqZKfKOUnfH6U1WpPC+HbFE6z/yYoBAGaPxrM2iA4PE
         RA7UnwRtCLj3ZAlGqYs/vpvDG83e6mXKuSofbiuIMkue5dKOkbDzFhtM4/9W0v3YYfRI
         BqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPjV5oIkkTKWgs8bzuMudxn+m/34k9ESgX/d9EjKBY4=;
        b=RR/Ch5zgVIJ1nhgt+7lPw6Moot8YI6A8h/O/Qi+EfWxj1882fp9VLpBKF7wtrtBgF1
         8THv548aUNDohDDzOlhBkchoi4EneRTz2jokfC9CcBqSxgebNOz/i+ipds03/254Nqbe
         8524Oh9eyrHY5lJ84ytDpjohUZ72zXRoPSA6mBA5mCXu+pxLH8J/stlXP6Le1gqpZWHW
         19GGfoFFUY3fHE95wek2wYQeCJOyr1TJDvts6SidG0FTVYJEJyxcg8Y1RBO1WLDTZSkF
         TjqFuw1f89Skbd7yqBo6xotU6rYv8MQ/yJdMxr4Y2D1zERAD/YNln2Woi6Wbb1FY97jC
         WZfg==
X-Gm-Message-State: APjAAAUNm/rVEcnOfGC1fRd6OzpjfWBfzatpkPMg1092LJuxcl/zJE1g
        7W/PM5mzBCrEwoqYTei7S4M81SgCY87NwSr/KIg=
X-Google-Smtp-Source: APXvYqyUye9cz+0n15zQ4gOArOoK5kXFrcrLZZSEtAMpudDveLjSJuBRU+UsJPJBC8N4qob10YrUs4SNp8kqivMgQUg=
X-Received: by 2002:a6b:e20a:: with SMTP id z10mr7315185ioc.76.1562516120337;
 Sun, 07 Jul 2019 09:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-12-git-send-email-s.mesoraca16@gmail.com> <CAG48ez0uFX4AniOk1W0Vs6j=7Q5QfSFQTrBBzC2qL2bpWn_yCg@mail.gmail.com>
In-Reply-To: <CAG48ez0uFX4AniOk1W0Vs6j=7Q5QfSFQTrBBzC2qL2bpWn_yCg@mail.gmail.com>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sun, 7 Jul 2019 18:15:09 +0200
Message-ID: <CAJHCu1K-x1tCehO1CxTf9ZzVKLh44dE9hwWWSCxnW1A4SHX=kQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] S.A.R.A.: /proc/*/mem write limitation
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:
>
> On Sat, Jul 6, 2019 at 12:55 PM Salvatore Mesoraca
> <s.mesoraca16@gmail.com> wrote:
> > Prevent a task from opening, in "write" mode, any /proc/*/mem
> > file that operates on the task's mm.
> > A process could use it to overwrite read-only memory, bypassing
> > S.A.R.A. restrictions.
> [...]
> > +static void sara_task_to_inode(struct task_struct *t, struct inode *i)
> > +{
> > +       get_sara_inode_task(i) = t;
>
> This looks bogus. Nothing is actually holding a reference to `t` here, right?

I think you are right, I should probably store the PID here.

> > +}
> > +
> >  static struct security_hook_list data_hooks[] __lsm_ro_after_init = {
> >         LSM_HOOK_INIT(cred_prepare, sara_cred_prepare),
> >         LSM_HOOK_INIT(cred_transfer, sara_cred_transfer),
> >         LSM_HOOK_INIT(shm_alloc_security, sara_shm_alloc_security),
> > +       LSM_HOOK_INIT(task_to_inode, sara_task_to_inode),
> >  };
> [...]
> > +static int sara_file_open(struct file *file)
> > +{
> > +       struct task_struct *t;
> > +       struct mm_struct *mm;
> > +       u16 sara_wxp_flags = get_current_sara_wxp_flags();
> > +
> > +       /*
> > +        * Prevent write access to /proc/.../mem
> > +        * if it operates on the mm_struct of the
> > +        * current process: it could be used to
> > +        * bypass W^X.
> > +        */
> > +
> > +       if (!sara_enabled ||
> > +           !wxprot_enabled ||
> > +           !(sara_wxp_flags & SARA_WXP_WXORX) ||
> > +           !(file->f_mode & FMODE_WRITE))
> > +               return 0;
> > +
> > +       t = get_sara_inode_task(file_inode(file));
> > +       if (unlikely(t != NULL &&
> > +                    strcmp(file->f_path.dentry->d_name.name,
> > +                           "mem") == 0)) {
>
> This should probably at least have a READ_ONCE() somewhere in case the
> file concurrently gets renamed?

My understanding here is that /proc/$pid/mem files cannot be renamed.
t != NULL implies we are in procfs.
Under these assumptions I think that that code is fine.
Am I wrong?

> > +               get_task_struct(t);
> > +               mm = get_task_mm(t);
> > +               put_task_struct(t);
>
> Getting and dropping a reference to the task_struct here is completely
> useless. Either you have a reference, in which case you don't need to
> take another one, or you don't have a reference, in which case you
> also can't take one.

Absolutely agree.

> > +               if (unlikely(mm == current->mm))
> > +                       sara_warn_or_goto(error,
> > +                                         "write access to /proc/*/mem");
>
> Why is the current process so special that it must be protected more
> than other processes? Is the idea here to rely on other protections to
> protect all other tasks? This should probably come with a comment that
> explains this choice.

Yes, I should have spent some more words here.
Access to /proc/$pid/mem from other processes is already regulated by
security_ptrace_access_check (i.e. Yama).
Unfortunately, that hook is ignored when "mm == current->mm".
It seems that there is some user-space software that relies on /proc/self/mem
being writable (cfr. commit f511c0b17b08).

Thank you for your suggestions.
