Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645E894D01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfHSScs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 14:32:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42593 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbfHSScs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:32:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id o6so2070142oic.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exxLbBApgV6PTvl2h9eJqhythd6t0fRT+JVMGKS8jEo=;
        b=N30rnKGYB739Ves7tBVKXM7MJwv0hEld9wM3zcbr+n297W9Ejk+DzCQCEdxtGEBsWq
         2P2prdeVYHZxybcQRtRZP34kO2zDjlvaF3VvQBnRjNUeQUWHkDkvfneERyaygt3BoWjz
         k27twPFOjFa+WT6492ZgYVaivVhWYYwdwpaz7rDUxPznVeEjcOyzwYhhetIprbCKJtD0
         mDMfAKS6MgOlkyeTPDLJsopCOlkG1+qC99JlITj9PuR3C2M5jZaWrr1S917vl8zu8qXo
         nlTNjTV9kFxH3J8HwixkqMzHejwrYsanOuXf7RhaIOUROwaswjq1fJdoKZToC1gOau4V
         iJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exxLbBApgV6PTvl2h9eJqhythd6t0fRT+JVMGKS8jEo=;
        b=KKk5hvVg6pHEd2Cez5HdxIVlQi5CHQxuOXkpsLsR8YoeTdFzQ2MglpEZvizH1+KPJd
         3Zcu2DJrhRhLPEGN2NTdNInaM1kMNRSWrw+PhMwJYFTPE/aXOqGJh29BjASor/uDRK21
         XOxdbEoUc0IqEbLwu64AfWWaQvPx9Pb0sQp/rUBdnnUWs6ZrcepOV1CNH7dmkseBo5Wz
         R7pMuvoKsC5G2g4HHQHTJdVBTCQmvOiRKPLHylNcNIwR9G29NjIjqe9sgQKhlZLZh8iI
         IQMBem4YTOM37qYJfG3MSZl3LSNxFrpxBBo46Hug0gb10Dbme+qwLYq8WdLnYFj7RMny
         xAJA==
X-Gm-Message-State: APjAAAUIGI+k2KDGkbj1tPnBYgclSdHiQvcZn+YinqEMm3cE20slri2T
        mg2eh5jz+QOt8hrMabGzBJk4H+khOBK6ekFW8QYIZw==
X-Google-Smtp-Source: APXvYqzcZxO35hPKUmgsbjbwPt60jfZ97oWtgJ+2o4Wi3kg5sdjLktycoyqy673ojuAgMkF0aJPeKJ6c/q7Msvu7Tqs=
X-Received: by 2002:aca:d44f:: with SMTP id l76mr14876016oig.172.1566239567531;
 Mon, 19 Aug 2019 11:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190819175457.231058-1-swboyd@chromium.org> <20190819175457.231058-3-swboyd@chromium.org>
 <5d5ae8c2.1c69fb81.25dd0.ca75@mx.google.com>
In-Reply-To: <5d5ae8c2.1c69fb81.25dd0.ca75@mx.google.com>
From:   Tri Vo <trong@android.com>
Date:   Mon, 19 Aug 2019 11:32:36 -0700
Message-ID: <CANA+-vBM-xy1ET=5x0peHmiaODr9MT-bTBkuBKEFEq=UHSo3kQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM / wakeup: Unexport pm_wakeup_sysfs_{add,remove}()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:21 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Sorry, subject should be
>
> PM / wakeup: Unexport wakeup_source_sysfs_{add,remove}()
>
> Quoting Stephen Boyd (2019-08-19 10:54:57)
> > These functions are just used by the PM core, and that isn't modular so
> > these functions don't need to be exported. Drop the exports.
> >
> > Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
> > Cc: Tri Vo <trong@android.com
>
> Messed up the address here too. Should be
>
> Cc: Tri Vo <trong@android.com>
>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tri Vo <trong@android.com>
