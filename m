Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725C8420A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 11:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437402AbfFLJYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 05:24:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35805 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437369AbfFLJYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:24:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so17813963qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 02:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83mzRAtBW6yppfmXJz7Et+RX8w7K37EJrrBws3kBffo=;
        b=LqDHkdutrLCAKkxtkqGh7TcpIelcQRJVnoQCcpu5CqpQUbp/ks9NaL8eNZNSHgGwqu
         K2P48IoJcR6OnXlnkaKrBrAEuVMcibiZxblYyzpjP0gPynK3aNucuZySy2YmYIMqZBSQ
         q2R6IDkXJ5Rl6WnS/k7PE1/4b4/fJjEIWUaahtbExpK4iwPVC98MHdyzVhsA4dZ/IkpC
         HBDjEO6MIqvPG9woeG/KdMp5GiG9vjU/6Tfnp69prx8dChj4mVr6Q6DPvDZF0UyR6XWL
         KbdtObDvA/Luy+1/TEBTpF3cCBCCL14JOvhtL59tx0rGMA8KJjHaZ1WH8qK8Hsw3PdYG
         NsSQ==
X-Gm-Message-State: APjAAAVMoInbJY95wwFLZyLHBRasdGfZuqdQvu+H9krMPzs0R1Y/plxn
        qNIx4+30QgMJRabQ4LwghAZ3VRKGguxOsFiA+1o=
X-Google-Smtp-Source: APXvYqynLmtgmbHMVUOvngr86TBq3ahDOmmFEenGU9KDMo0+zYI8LYvqeIrZeJSg4OPAA3QVvQv5IjvIX6F7oCejqO0=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr64168005qtf.204.1560331485624;
 Wed, 12 Jun 2019 02:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190611184503.GA3212@kroah.com>
In-Reply-To: <20190611184503.GA3212@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Jun 2019 11:24:29 +0200
Message-ID: <CAK8P3a1N=Vfb9FJYNqHFVLBbLT=uOpa3aHfQZRFLyXBPvJL5sQ@mail.gmail.com>
Subject: Re: [PATCH] ti-st: no need to check return value of debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 8:45 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
