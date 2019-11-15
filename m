Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DCBFE77B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 23:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOWQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 17:16:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34081 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfKOWQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:16:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id l202so10023905oig.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrwTiEGJlLLo81xG+S86aYgrEKB8cGFUXed3sRPs9qE=;
        b=eB8wJcgdGhhyBcAt4UQTmjUOGFBU7OkqAgrkZGfp8JozZCZkqY7OROEpsordbzwzkv
         4JIF00v4yJzmsVdFuOzdcuDEyz6VwbuPAdUduqa0BP03Z29k+PaI5bKdwzprwRrhaEd7
         CFbNQJCtm3tgoBjrDWvh2rcAk8/kXJQPKxGy2F0YMxCNZSkqc0LJJoI13QgjwUXxFG1T
         dugHUvn4F6sZlojrwJ/Y4pV+4r02QoSupqvcMZqqjY3c64cp3fFPY3umkKOsnOwk5V2I
         4Rk3UMl6TSTKrs/HyxjepeXidehTuL/tLldnFiddeh/UERCEZNaLx6uWsfVdloHZf/mz
         o4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrwTiEGJlLLo81xG+S86aYgrEKB8cGFUXed3sRPs9qE=;
        b=bVvUwVw1S19UQvRwsotvkCmYylSNBgr3ienH4jQe45+yDOGBn3svH035oHxqU+EqCZ
         Ylf3xoZxmcvKpDT63wy4cPM0o5ftocl2+OpJEFvFAXX7xBWBp5V36XKxuGolJqijqYf5
         zfw2QBEjJXuSxTohcKokjoFqC8GvMta8ymaYzMnGsiF5Ngbyi10fipd4d1FgbQeoWw3I
         AXyOLKAtNjQ4U3m7vUSgYYBSHUkL178TDTdPjFbTqviugJ8pYp0mTjbCTp6iDrkCJE3L
         EzKwcnvhtRPRRKF92spWWtKpAdTNLLGG45QKxHuGKYTguFYVS485Wl3sdDlDAFJQXtfU
         9VeQ==
X-Gm-Message-State: APjAAAVl4Me4IyZC+en/J/L8JKU5H9kp1AF3jcFCDgH+79Sz4k9C2Ors
        a+CMU5CTn6uSaFhrXWUYa4M41I2t6HUxG9btw35VPQ==
X-Google-Smtp-Source: APXvYqy7mAtMxI3Pn+9esu39unW7sjkUaLc6FCEsywtYoQXoGbpJVLJ1jrXK/jfSSxC3nmtTbth86MiAe0XIzLcH//c=
X-Received: by 2002:aca:f514:: with SMTP id t20mr9577132oih.24.1573856160984;
 Fri, 15 Nov 2019 14:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20191115045049.261104-1-saravanak@google.com> <20191115053201.GA800105@kroah.com>
 <20191115091035.GA2227@kunai>
In-Reply-To: <20191115091035.GA2227@kunai>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 15 Nov 2019 14:15:25 -0800
Message-ID: <CAGETcx9isTDaRW0KgdWVHxxTKdERB4DPeQyCa9QWXniNTpuZ_A@mail.gmail.com>
Subject: Re: [PATCH v1] i2c: of: Populate fwnode in of_i2c_get_board_info()
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 1:10 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Nov 15, 2019 at 01:32:01PM +0800, Greg Kroah-Hartman wrote:
> > On Thu, Nov 14, 2019 at 08:50:48PM -0800, Saravana Kannan wrote:
> > > This allows the of_devlink feature to work across i2c devices too. This
> > > avoid unnecessary probe deferrals of i2c devices, defers consumers of
> > > i2c devices till the i2c devices probe, and allows i2c drivers to
> > > implement sync_state() callbacks.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > > The of_devlink feature is present in driver-core-next branch. It started
> > > off with [1] but it has been improving since then.
> > >
> > > [1] -- https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/
> > >
> > >  drivers/i2c/i2c-core-of.c | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Wolfram, I can take this through my tree now if you have no objections
> > to this.
>
> What would be the advantage?

Of the patch or of him picking it up?

Advantage of the patch is in the commit text. Details of of_devlink
are also provided in the link I gave earlier.

Advantage of Greg picking it up: This patch will get tested/seen with
the set of changes (of_devlink) with which it'll have the biggest
functional impact.

-Saravana
