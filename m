Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26800192F08
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 18:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCYRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 13:19:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37910 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgCYRTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:19:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so1053833plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rb8HC6WGsGE44SQ6X/4w8KC/GhzvOIVOOh1NOcuS0o=;
        b=kxiJeYFeSlAM1QBZhriylp7P3+E/0IlkMNbZs5HqHRHVo7fzk8AW0hOIAnuXBZsU+j
         OGdIVimcyjuLURvB/KI/st7FxzLqvk22hGA8quolTPLXu0Pn8KeLJVukPVN0rgDrAnbE
         4zCbNDfg0y3RWmPjpGXr18nxMSvaw+EV5Dm/9Qh7PRAbmt2YYu6v4LHbE79Q1EGvopTP
         hvHIcdzGHUeIEfrhVzndPiShG8Y/EoWEYFBPDoP0tc2KEpITQtmsUTyAQsFuLgjoxzgP
         8pcaqOMQvTncduAOG3JG/ekDM+ms7KLxSpZ3HiRTCqPne9H2f8TMFxvdDuoSneR6DgzA
         9Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rb8HC6WGsGE44SQ6X/4w8KC/GhzvOIVOOh1NOcuS0o=;
        b=sl2ND8W86o4BuV1NPlmI9XmDM15LRgJy3s9d5zd626jkYAyLVnCXn50NM1KqDR3/pu
         owWs1gBq8Z0LxhQzH0yrdOk2SumFVg1r7DtQiBBQsLsPqrHm5+fl3LdIsm/DaJ65TzYI
         zif2mD3x2/NRaDpE7l7tUg93MMPxlJKQDr8iboVvGefEMgyeA85keuQ0mCk9cbY7wGae
         PWP1HM9rhLBd8iuHS7rwWHkx3ImHi4yuWgfsBBbJcAdxiQRkfFuyk++cYJ/KCnGypDTW
         NjQaiQMHRm8huTzZebPqB4RSHBSbbKL8KWiLppXVLCwXzl+10fNADMVoht1yZSqk1XnA
         pMmw==
X-Gm-Message-State: ANhLgQ3iGDlPbgjFCBfkNvv9m2skdVczVOcQdJKVWFFsXUjoFuWvrj18
        VAv5Z7uJb9hHRuG/pk05WhZg3Xu4Xyc528Qt3ct906KCD3o=
X-Google-Smtp-Source: ADFU+vuw8tjfEoctA9OGJGVVEc/U+r3gP9GtmCngawmj0t6q9H1tL86i8ssX8g7CQ3dny0tDhLG62Yx6AgnraK7Qsr4=
X-Received: by 2002:a17:902:7204:: with SMTP id ba4mr4220548plb.232.1585156745997;
 Wed, 25 Mar 2020 10:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200324024333.41663-1-davidgow@google.com>
In-Reply-To: <20200324024333.41663-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 25 Mar 2020 10:18:54 -0700
Message-ID: <CAFd5g451jGmh5xocZUOcDnFaSHRVBDnP=BznZ8mKefXV2XJxOw@mail.gmail.com>
Subject: Re: [PATCH kunit-next] kunit: kunit_tool: Allow .kunitconfig to
 disable config items
To:     David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 7:43 PM David Gow <davidgow@google.com> wrote:
>
> Rework kunit_tool in order to allow .kunitconfig files to better enforce
> that disabled items in .kunitconfig are disabled in the generated
> .config.
>
> Previously, kunit_tool simply enforced that any line present in
> .kunitconfig was also present in .config, but this could cause problems
> if a config option was disabled in .kunitconfig, but not listed in .config
> due to (for example) having disabled dependencies.
>
> To fix this, re-work the parser to track config names and values, and
> require values to match unless they are explicitly disabled with the
> "CONFIG_x is not set" comment (or by setting its value to 'n'). Those
> "disabled" values will pass validation if omitted from the .config, but
> not if they have a different value.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
