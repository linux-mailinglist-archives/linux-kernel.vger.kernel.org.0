Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC7510B6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 20:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfK0TXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 14:23:40 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37770 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfK0TXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:23:40 -0500
Received: by mail-oi1-f193.google.com with SMTP id 128so13064542oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 11:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Hw0kz+i9Mk8GNpNzBnmR7s/yayYdDJKPB0j3/83kv4=;
        b=nyxjcgHAyOOTk376Ad6oVXa6b6/uZGiWdROp4ZAu14ImXIP2lRabEaWnZzN1qeKSre
         RAiFxTIXlri7abDsc5Dr2ZEX7wc2VRyfE+rWwForgEue8rC+W0hnI/bDQD0TU3IQvJaI
         ++Avuw3+7IxY6zxB6OIB+vmow7A3jVLN4vjELvLgvr1TbbGWLbE4CZ9r8G0toKPwwFXK
         6cmPoeN8RcupeDZ3H2NWHcpSt8hivxj9+TLUW841txs8kM/v3D0lwTHyM1PoRD842YlA
         cYGZP7o2CxIqOrmKDk0GGeV7i4hcfFya+YObWK3/+jtaHbDElKCM3a7XUma18MQw8pBl
         fQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Hw0kz+i9Mk8GNpNzBnmR7s/yayYdDJKPB0j3/83kv4=;
        b=lIhqZdM6shhQNfXCD0Qiefq4dI7m7NEPjoXjyOZSXDwtC6MS1Do0/AIpnwITvAqBBf
         z/8lAMXt7mmri3QkSte3pERcXNYx2BI/VqDREdLeUY2eoX59KEWUntQlOnzHKBZcDISO
         dx5eWTF70qHYLkN9fYCJukCca6quVi8NHKaNvehFT6X0cbsoQRbAhmBkY5iwH37LFjkg
         bo1YvRC9Uv1MKiXE3dlVh64WFQXK4kACrXNnsNKpnhauigH/yNqqsN1kFrMVSmjcvJr6
         94pqgrSnqv+J9QTzrKLuVutC1R5aubfRJjKuBp1Aft/Oi1ThoFAGa1uO5tmD5O+cnFmq
         8HZw==
X-Gm-Message-State: APjAAAVibgwMShwUK324vglVqw6bGxu78kRVAfACPXGFJh33cUQgFZ4q
        XLK2+NRAEvUpxoqrbZl7Se1EkQ5vwky7RTJhp5/Phw==
X-Google-Smtp-Source: APXvYqzd0diswvCyfrWBdO3wyErC5RMF3LoQj+2/Y8VPS1V/yCBMfWpMJ5+y7iCf4VMVajBy/G4v1znEhdboXyt4v1Q=
X-Received: by 2002:aca:782:: with SMTP id 124mr5318377oih.47.1574882618639;
 Wed, 27 Nov 2019 11:23:38 -0800 (PST)
MIME-Version: 1.0
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
In-Reply-To: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 27 Nov 2019 20:23:12 +0100
Message-ID: <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
Subject: Re: [PATCH RFC] signalfd: add support for SFD_TASK
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 6:11 AM Jens Axboe <axboe@kernel.dk> wrote:
> I posted this a few weeks back, took another look at it and refined it a
> bit. I'd like some input on the viability of this approach.
>
> A new signalfd setup flag is added, SFD_TASK. This is only valid if used
> with SFD_CLOEXEC. If set, the task setting up the signalfd descriptor is
> remembered in the signalfd context, and will be the one we use for
> checking signals in the poll/read handlers in signalfd.
>
> This is needed to make signalfd useful with io_uring and aio, of which
> the former in particular has my interest.
>
> I _think_ this is sane. To prevent the case of a task clearing O_CLOEXEC
> on the signalfd descriptor, forking, and then exiting, we grab a
> reference to the task when we assign it. If that original task exits, we
> catch it in signalfd_flush() and ensure waiters are woken up.

Mh... that's not really reliable, because you only get ->flush() from
the last exiting thread (or more precisely, the last exiting task that
shares the files_struct).

What is your goal here? To have a reference to a task without keeping
the entire task_struct around in memory if someone leaks the signalfd
to another process - basically like a weak pointer? If so, you could
store a refcounted reference to "struct pid" instead of a refcounted
reference to the task_struct, and then do the lookup of the
task_struct on ->poll and ->read (similar to what procfs does).

In other words:

> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index 44b6845b071c..4bbdab9438c1 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -50,28 +50,62 @@ void signalfd_cleanup(struct sighand_struct *sighand)
>
>   struct signalfd_ctx {
>         sigset_t sigmask;
> +       struct task_struct *task;

Turn this into "struct pid *task_pid".

> +static int signalfd_flush(struct file *file, void *data)
> +{
> +       struct signalfd_ctx *ctx = file->private_data;
> +       struct task_struct *tsk = ctx->task;
> +
> +       if (tsk == current) {
> +               ctx->task = NULL;
> +               wake_up(&tsk->sighand->signalfd_wqh);
> +               put_task_struct(tsk);
> +       }
> +
> +       return 0;
> +}

Get rid of this.

> +static struct task_struct *signalfd_get_task(struct signalfd_ctx *ctx)
> +{
> +       struct task_struct *tsk = ctx->task ?: current;
> +
> +       get_task_struct(tsk);
> +       return tsk;
> +}

Replace this with something like:

  if (ctx->task_pid)
    return get_pid_task(ctx->task_pid, PIDTYPE_PID); /* will return
NULL if the task is gone */
  else
    return get_task_struct(current);

and add NULL checks to the places that call this.

> @@ -167,10 +201,11 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
>                                 int nonblock)
>   {
>         ssize_t ret;
> +       struct task_struct *tsk = signalfd_get_task(ctx);

(Here we could even optimize away the refcounting using RCU if we
wanted to, since unlike in the ->poll handler, we don't need to be
able to block.)

>         if (ufd == -1) {
> -               ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> +               ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>                 if (!ctx)
>                         return -ENOMEM;
>
>                 ctx->sigmask = *mask;
> +               if (flags & SFD_TASK) {
> +                       ctx->task = current;
> +                       get_task_struct(ctx->task);
> +               }

and here do "ctx->task_pid = get_task_pid(current, PIDTYPE_PID)"
