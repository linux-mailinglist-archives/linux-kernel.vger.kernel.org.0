Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686DF8EF63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 17:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfHOPdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 11:33:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35991 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730049AbfHOPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:33:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id p28so2455313edi.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3UNVvRcqgknRSbay7FUCJDbPbxBrvPJzPpgYbJ5C2I=;
        b=Prv6gJ49GcEBNbk0/Clw83UxMI9ce4oqQdlks9MrqN+WhicI+zhIDx3+DDoCJ35m/B
         K+q/KeUJLtWkumLEJxbQz8K+gqTatV+Riw/mLh2ZUzYYuBv8NRGNzVdMRgmMdimhiDFb
         yGoZr9lQtNJreo6tXcJO2em4iw5bILHe2IM1U5TUOElZiqxa5ilQ9hSxmc4hDGsD4gAh
         qCzf4IlbcsSrPXvgtVfi57wm8o+MaKG94oN/TfisMac7+pOsym5cw+k/DE/r/I9xaIzv
         azrTFF/IA7bkyp86T5QI4DJDBUI/ya1BKaPxtq9bcmgsA65E3v/thjM5DvfshpxaG5zC
         agKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3UNVvRcqgknRSbay7FUCJDbPbxBrvPJzPpgYbJ5C2I=;
        b=MjLF1p+NhkmrEM2hd1og/WYhcPA9u1T/r8L48O5ZkrYPX2hxu3HcD3TPDEZgx+DQGF
         3wQcN4DFARrc670nyM7NohDNmXq9YRQnkP4uIH7bBuvgqWzuk1b9D8FArxvxmYWRyWCJ
         1p2fCH9DKSCyooFtm9D3w0kGsNCGALjprgqtz7RBozXnlfE33zJnglAul0J0j8LnGCFd
         /q2X2Pnqdmi/tW+koP8kJoViYlmsCKrHW7ty/yyqX63QTmFSxFqzUevw+zzaAK5/qNse
         ov5Q5BszSSlzXC1efyrPUBpzzNukMakLWXtc02br9rAmST4TLP/yh03/mMzLOnXHyj0Y
         OtTw==
X-Gm-Message-State: APjAAAU1E+U+Op+hqEll5ikHI24JKRyDlZVQsU90AV+xdqWC+OVLOm4s
        JySMKxdGpty4Xw1Zwyi2MQvJdSV8wgKhkGPN1Yg=
X-Google-Smtp-Source: APXvYqyWNy6gsBFapmcJCjWhlOPlHn5R2djc4E/fTnSHykY18ryNLl3VxmiH0SxKCjmoBxEETYwBFsdELNQyfNKItac=
X-Received: by 2002:a05:6402:1344:: with SMTP id y4mr6022183edw.124.1565883192450;
 Thu, 15 Aug 2019 08:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190809071034.17279-1-hslester96@gmail.com> <20190814104941.qt66ozcau5fdswcs@pathway.suse.cz>
 <20190815075033.GA26479@tigerII.localdomain> <20190815135221.qcgerido7aahmpgn@pathway.suse.cz>
In-Reply-To: <20190815135221.qcgerido7aahmpgn@pathway.suse.cz>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Thu, 15 Aug 2019 23:33:01 +0800
Message-ID: <CANhBUQ3Gco8kR7xiMknFv3ryyfnfeiJO1R-rHzNWBux8b8=LSw@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] printk: Replace strncmp with str_has_prefix
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 9:52 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2019-08-15 16:50:33, Sergey Senozhatsky wrote:
> > On (08/14/19 12:49), Petr Mladek wrote:
> > > On Fri 2019-08-09 15:10:34, Chuhong Yuan wrote:
> > > > strncmp(str, const, len) is error-prone because len
> > > > is easy to have typo.
> > > > The example is the hard-coded len has counting error
> > > > or sizeof(const) forgets - 1.
> > > > So we prefer using newly introduced str_has_prefix()
> > > > to substitute such strncmp to make code better.
> > > >
> > > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > >
> > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> >
> > Reviewed-by:  Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>
> Chuong Yuan, should I take this patch via printk.git? Or will
> the entire series go via some other tree, please?
>

I think that it goes via printk.git is okay, thanks!

> Best Regards,
> Petr
