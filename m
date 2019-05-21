Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E824D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 12:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfEUKyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 06:54:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44669 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEUKyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:54:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id n134so12675281lfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuQPCza8xJfYgY0dneZk0G6xayTBnNxEtRyHod+p3HY=;
        b=lQCrlTHs22nkIIE4mZHxZ2y/0PC+h9l08GqJNnXF+rFnYfOvyiDBMc91per5friV2/
         tvfKd63MlktUgYPwIHzRpMAkmo8QE/YfyLCy97H4HPDmkAVPnUvhQV5AenOjgUCZToxS
         NHX+YbNOx6AR3tAYzyF8pxtyx0oelYAi+WGNjkCcTa3SmiNTAhYdq82nOQRLZSIUO5HC
         UAgJkDPhjLZQgdyLIHXZtFjLtO1hOBiROigrbPg7AgnqtxU5N1uO1fKZ4hSh33m5866Y
         /SvdZEBVse5bdZwcD0z8A5jTkcc9xAOXnSZXYDs4kEVlXpTWd7WX8PkdvSMjU6e91lzL
         2XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuQPCza8xJfYgY0dneZk0G6xayTBnNxEtRyHod+p3HY=;
        b=GgMUw6nwNy0UCEBqjHQ8OQnj8rJN/01Xz1ffVDYl6GxqDHRm97EYztB9E7usWzNHjI
         jgnnzc+nmfqU5buwWXILdifLZyhQQ2F0EV4IHSLXrg2bhKxh42Wb052TLuyhkxznPYIm
         h2bIj8yF/LvE8ipXnupJxDX6J/lbI7oZD+IZt+SW7xl96TcBNs8LLTprN8jgVgrxFpxF
         KLddeMmQvLPS6amO3ax4EfHEIeebC+mPtvd19p2pXfMW/1PR+rsXnjOklA59Tmzkmswh
         /g9WKBT1DMskMNyHRhUfQBOfj5Hv647VMUiNxVmJBtZEJnX7k0JYjTe3J2AdgZbbb6w7
         xPNA==
X-Gm-Message-State: APjAAAXqltMB9IZ3VS8LPj4Cv1qsDYpgDjZRsnEKyh9atzR9Q5GIjNYE
        DVzrfU6u2aFf/TdiLruu5nrBEIJXfGru4RpyI9zfxA==
X-Google-Smtp-Source: APXvYqztX7fYok/uhqw5ZT0BRL6qm99DV5CcOWDJsCELsoCIo6z6fMBHqDmOwb7+hNYnFgvYtYgxd/kFSm2WUh1SNCg=
X-Received: by 2002:ac2:418c:: with SMTP id z12mr8772790lfh.0.1558436090142;
 Tue, 21 May 2019 03:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190517154256.255696-1-darekm@google.com> <20190517154256.255696-2-darekm@google.com>
 <8f2ceecd-da9e-a923-da72-cdc660eecb3a@xs4all.nl>
In-Reply-To: <8f2ceecd-da9e-a923-da72-cdc660eecb3a@xs4all.nl>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Tue, 21 May 2019 12:54:38 +0200
Message-ID: <CALFZZQHjc8WxuuGzcWUjDJ2TU9Pyp+f0XN0p8iPahPFAOtw6AA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] drm/bridge: dw-hdmi: pass connector info to the
 CEC adapter
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 1:30 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 5/17/19 5:42 PM, Dariusz Marcinkiewicz wrote:
> > This patch makes dw-hdmi pass DRM connector info to a respective
> > CEC adapter. In order to be able to do that it delays creation of
> > the dw-hdmi-cec platform device until DRM connector is initialized.
> >
> > Requires testing.
>
> Testing this patch with the Khadas VIM2 board gives this kernel warning:
>
Thank you for testing!

This was probably because the platform device info was not fully
initialized. Hopefully it is better in v7.

Regards.
