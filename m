Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1349214A6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 15:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgA0O6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 09:58:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33369 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgA0O6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:58:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id m10so8741772wmc.0;
        Mon, 27 Jan 2020 06:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FwNSt4/8vC5KfsfPGKzFax9QH8bqrtKi3O+OhMD0cY=;
        b=D/JThCWaliUF/sycgUIZ5cA7Ogm7ZxSjFthb2TbQTz/GBJdvsPJtpC1nBXDo8PIfpv
         o2dS7Rm1n4MWQI5Pwam6Fw8XUUOFcyB7WMWYcBnI+VqtgmqWojkRVh6W5+HqjsYDDstx
         UzcXyLqntBIye/bwF7bEvsSQomM/KilMY+HrJALk5uSJEhdeCvJlV+vCR0QWhDWTn3S1
         NfeiOUELvmND/wckPuImJ/fLCRUWx0BcQinvTRXQy2EMBybHdlvumfXOkL2NKRHLZ1En
         YBMyDHJx2Eb1V/toRQH/zf+v5YYi28+hnC9RatE7FGnLRY42nNjsodga/y+65xabdaVl
         Xqjg==
X-Gm-Message-State: APjAAAUT+qHaIoC3+m2lN4fLrovK0LPISpzkRByoBugRRMEI3iq0Vio7
        uE5jm2EVC/3gNYt/dG6ShMbNB0RWorTq1geu8Ls=
X-Google-Smtp-Source: APXvYqyN/ShG7knKaIA7fQGn+oAr1g2YMuZDwv88Pf5iKz1ihsZnAbd1u/bVB+bfTZ6VM9wqsd7qr54Nt9KYzIRhq9g=
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr14882474wmg.154.1580137118168;
 Mon, 27 Jan 2020 06:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20200127100031.1368732-1-namhyung@kernel.org> <20200127111234.GA1114818@krava>
In-Reply-To: <20200127111234.GA1114818@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 27 Jan 2020 23:58:27 +0900
Message-ID: <CAM9d7cimJi8V0PtWy=jLSdPrX0na5rLE2NfXTZtW56PdX=fj3Q@mail.gmail.com>
Subject: Re: [PATCH] tools lib api fs: Move cgroupsfs_find_mountpoint()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Jan 27, 2020 at 8:12 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jan 27, 2020 at 07:00:31PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > -
> > -     if (strlen(path) < maxlen) {
> > -             strcpy(buf, path);
> > -             return 0;
> > -     }
> > -     return -1;
> > -}
> > -
> >  static int open_cgroup(const char *name)
> >  {
> >       char path[PATH_MAX + 1];
> > @@ -79,7 +20,7 @@ static int open_cgroup(const char *name)
> >       int fd;
> >
> >
> > -     if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
> > +     if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, "perf_event"))
>
> nice, but could you please follow fs API names and change the
> name to cgroupfs__mountpoint
>
> I think we don't need to define the rest of the functions now,
> if they are not used
>
>         #define FS(name)                                \
>                 const char *name##__mountpoint(void);   \
>                 const char *name##__mount(void);        \
>                 bool name##__configured(void);          \
>
> just follow the function name

I thought about it too, but still it has different arguments.
So I left it as is... Do you really want to rename?

Thanks
Namhyung
