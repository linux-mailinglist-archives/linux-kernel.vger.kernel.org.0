Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7038199900
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 16:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgCaOyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 10:54:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37113 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730366AbgCaOyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:54:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so26440617wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HO6TrY5vHW3xCtXAgehmLHCRS7dfehnjLhFx26xMDoQ=;
        b=U1G7c6dIUiJdJNDBHMSSRHwSZ62lP7+ual3LVgEwKhursW1dC+ZfNBC4rLJVBTgXzp
         gGb+09depK86K4VS+NBP5cVoROKTuIr6D0JxZQjPKT0meNE/Gv/M7W9BhTjpZJvxqqGk
         DVJz/ZducLCzcG7pk/vZI1twZC/jkuVPFy8oMKFocfrF/rCp446+WKSK0EGa/NNaR8Yu
         /jGCXzmhszph91/K3p39NswbYsyy4SN8Wumcmbo09q0jdZUPVjHKn9dZDDKt0CIlqXPt
         3O79or2gzduI/i6BKYXP75mWMd3TvIgfLVY2aSkLTCMjm9puCJRj/ZHaBjbI3ezsi9m9
         NHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HO6TrY5vHW3xCtXAgehmLHCRS7dfehnjLhFx26xMDoQ=;
        b=q5Ywdbzzt9FdGuA7N9SOi/3pPlSTuJDy2q9hj2JaIGCagmJlwF7z1afjfFtHivp7ps
         miTqnpxsuntNg7sE0lByDWD/TsrG6YBbqCQE+k/hzWiHoYxI3CXjIIU0qyzAdvzotRrY
         Cqv4oItjwSqu9lPT3mpHRVO5n6zKC+k72N6FpttM34rEMAaBYOsbB7fdZjSBRdmeX5P4
         PuH7ob1YoZ4jbyQCkzgrvd3vRMwMc3Im5Q1ZCE21ZuImFP78HTbYOM9NYH+z/7T8xuok
         IJG6TUkqTFRjisvpxmuZOCASa8uN9hFKs2xWznX4lPeJidG4NBEh9ygjzghcq2CaooDh
         EEvw==
X-Gm-Message-State: ANhLgQ21p71YrxnqitKz8GBEQHPoJWh8Qu9Hp/cpc6hNpmP0yThu4y8v
        V+glow1TBzZsT7nMGTMqTOOkbN+5ukE0dNvvL+I=
X-Google-Smtp-Source: ADFU+vvPHEvkU5ZhiAKv+8P2j3np9aLNguMy5XOtTBfPRjaV1VagZhSS1Sw2OCRqF/o9dlJ3e5prEKanaJn5pIAVwEc=
X-Received: by 2002:adf:b35e:: with SMTP id k30mr20406573wrd.362.1585666454267;
 Tue, 31 Mar 2020 07:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585651869.git.melissa.srw@gmail.com>
In-Reply-To: <cover.1585651869.git.melissa.srw@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 Mar 2020 10:54:03 -0400
Message-ID: <CADnq5_MBKBKFLFQBXHzLYGdY_d8rbiEcWQaEQi70tJHTGTcXqA@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amd/display: more code cleanup in the dc_link file
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 6:55 AM Melissa Wen <melissa.srw@gmail.com> wrote:
>
> These patches address many code style issues on dc_link for readability
> and cleaning up warnings. Change suggested by checkpatch.pl.
> Some issues remain and need some minor code refactoring for proper handling.
>
> Melissa Wen (4):
>   drm/amd/display: cleanup codestyle type BLOCK_COMMENT_STYLE on dc_link
>   drm/amd/display: codestyle cleanup on dc_link file until detect_dp
>     func
>   drm/amd/display: code cleanup on dc_link from is_same_edid to
>     get_ddc_line
>   drm/amd/display: code cleanup of dc_link file on func
>     dc_link_construct
>

Applied.  Thanks!

Alex

>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 358 +++++++++---------
>  1 file changed, 176 insertions(+), 182 deletions(-)
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
